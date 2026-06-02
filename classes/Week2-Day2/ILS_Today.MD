(
  emp_id     INT PRIMARY KEY,
  emp_name   VARCHAR(100) NOT NULL,
  designation VARCHAR(50),
  manager_id INT NULL,
  salary     DECIMAL(10,2)
);

INSERT INTO employees VALUES
(1,'CEO','Chief Executive Officer',NULL,250000),
(2,'Sales Head','Head – Sales',1,150000),
(3,'Finance Head','Head – Finance',1,150000),
(4,'Sales Executive','Executive',2,80000),
(5,'Accountant','Executive',3,70000),
(6,'Sales Intern','Intern',4,40000);


How it works

A classic adjacency list: each row has a manager_id pointing to its parent.



Expected

6 rows, 3 levels deep (CEO → Heads → Exec/Intern).



Pitfalls

Avoid a self-FK until you know insert order and data are clean.
Names/IDs are unique here for clarity.

2) Inspect the data


What & Why

Know your starting point and confirm parent/child relationships.

Run

SELECT * FROM employees ORDER BY emp_id;
Expected

A flat list. Note who reports to whom.

Pitfalls

None — this is a visual sanity check.


3) Your first recursive CTE (discover the tree with depth)


What & Why

Understand anchor vs recursive members.

Run

WITH RECURSIVE org AS (
  -- Anchor: start at the root(s)
  SELECT emp_id, emp_name, designation, manager_id, 1 AS level
  FROM employees
  WHERE manager_id IS NULL

  UNION ALL

  -- Recursive: walk down to children
  SELECT e.emp_id, e.emp_name, e.designation, e.manager_id, org.level + 1
  FROM employees e
  JOIN org ON e.manager_id = org.emp_id
)
SELECT * FROM org ORDER BY level, emp_id;
How it works

Anchor returns CEO.
Recursive finds rows whose manager_id equals any org.emp_id from the prior step.
Iterates until no new rows appear.
Expected

All 6 employees with a level column (1..3/4).

Pitfalls

If you made a cycle (employee manages self), recursion never ends. (We’ll fix that below.)
If you see only CEO, you probably mis-joined manager_id to emp_id.

Part 2: Advanced Recursive Analytics (Salary/Budget/Depth)


Goal
Use recursion to produce manager rollups, department totals, and depth metrics that business teams ask for.



1) Enhance data with departments (realistic analytics)


What & Why

Department rollups are common (budgets, headcount).

Run

ALTER TABLE employees ADD COLUMN dept VARCHAR(50);
UPDATE employees SET dept='Executive' WHERE emp_id=1;
UPDATE employees SET dept='Sales'     WHERE emp_id IN (2,4,6);
UPDATE employees SET dept='Finance'   WHERE emp_id IN (3,5);
Expected

Employees now have dept.

Pitfalls

Keep dept names consistent (casing/spaces).


2) Total salary under each manager (includes indirect)


What & Why

Managers want their full salary footprint.

Run

WITH RECURSIVE closure AS (
  SELECT emp_id AS ancestor, emp_id AS descendant
  FROM employees
  UNION ALL
  SELECT c.ancestor, e.emp_id
  FROM employees e
  JOIN closure c ON e.manager_id = c.descendant
)
SELECT m.emp_id AS manager_id,
       m.emp_name AS manager_name,
       SUM(e.salary) - m.salary AS total_salary_under      -- exclude manager’s own salary
FROM closure
JOIN employees m ON m.emp_id = closure.ancestor
JOIN employees e ON e.emp_id = closure.descendant
GROUP BY m.emp_id, m.emp_name
ORDER BY total_salary_under DESC;
How it works

For each manager (ancestor), sum all descendant salaries and subtract the manager’s own.

Expected

CEO shows the largest rollup.

Pitfalls

If you don’t subtract, you’ll include the manager’s own salary.


Part 3 - Performance Benchmarking & Tuning (Recursive vs Alternatives)

Goal
Measure how recursion scales. You’ll create a large synthetic org, run baselines, add indexes, and compare alternatives. You’ll use modern tools: EXPLAIN ANALYZE and status counters.



 Note: In MySQL 8 the SHOW PROFILE feature was removed. Prefer EXPLAIN ANALYZE and Performance Schema / status variables.


1) Create a big test dataset (10,001 employees)


What & Why

You need scale to see real performance differences.

Run

DROP DATABASE IF EXISTS bench_cte;
CREATE DATABASE bench_cte;
USE bench_cte;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100),
  manager_id INT NULL
);

-- Generate integers 1..10001 using a recursive CTE
WITH RECURSIVE nums AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n+1 FROM nums WHERE n < 10001
)
SELECT COUNT(*) FROM nums;  -- sanity = 10001

-- Insert rows:
-- emp_id=1 is the CEO (manager_id=NULL).
-- Everyone else gets a random manager with a smaller id → guarantees a DAG (no cycles).
INSERT INTO employees (emp_id, emp_name, manager_id)
SELECT n AS emp_id,
       CONCAT('Emp', n) AS emp_name,
       CASE WHEN n = 1 THEN NULL
            ELSE FLOOR(1 + RAND(n) * (n-1))  -- manager_id in [1, n-1]
       END AS manager_id
FROM nums;

-- (Optional) verify a few:
SELECT * FROM employees ORDER BY emp_id LIMIT 10;
How it works

The recursive nums CTE creates a numbers table.
Each employee chooses a manager with id < own → no cycles.
Expected

10,001 rows; CEO has id=1.

Pitfalls

If you seed manager_id ≥ emp_id, you can create loops → don’t.
If cte_max_recursion_depth is too small, increase it:
SHOW VARIABLES LIKE 'cte_max_recursion_depth';
SET SESSION cte_max_recursion_depth = 20000;

2) Baseline: recursive traversal without index


What & Why

Measure the “worst reasonable” case.

Run

EXPLAIN ANALYZE
WITH RECURSIVE org AS (
  SELECT emp_id, manager_id FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.emp_id, e.manager_id
  FROM employees e
  JOIN org ON e.manager_id = org.emp_id
)
SELECT COUNT(*) FROM org;
How it works

EXPLAIN ANALYZE runs the query and prints a real plan with timings.

Expected

Total time noticeable (hundreds of ms to a few seconds, depends on host).
You’ll see loops/rows examined per step.
Pitfalls

Make sure you’re actually using ANALYZE, not plain EXPLAIN.

3) Add the critical index (manager_id)


What & Why

This is the single most important tuning step for adjacency lists.

Run

CREATE INDEX idx_manager_id ON employees(manager_id);

EXPLAIN ANALYZE
WITH RECURSIVE org AS (
  SELECT emp_id, manager_id FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.emp_id, e.manager_id
  FROM employees e
  JOIN org ON e.manager_id = org.emp_id
)
SELECT COUNT(*) FROM org;
How it works

The join can now find children via the index instead of scanning whole table.

Expected

Big drop in total execution time.
Plan shows indexed lookups (ref).
Pitfalls

If time doesn’t drop: confirm the index name and that this session sees it.
