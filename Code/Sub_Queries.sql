-- =========================================================
-- SUBQUERIES HANDS-ON LAB
-- =========================================================

-- =========================================================
-- DROP TABLES
-- =========================================================

DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- =========================================================
-- INSERT DATA INTO EMPLOYEES
-- =========================================================

INSERT INTO employees VALUES
(1, 'Arjun Sharma',      'HR'),
(2, 'Priya Nair',        'Engineering'),
(3, 'Rahul Verma',       'Finance'),
(4, 'Sneha Iyer',        'Engineering'),
(5, 'Vikram Singh',      'HR'),
(6, 'Ananya Reddy',      'Finance'),
(7, 'Karthik Rao',       'Engineering'),
(8, 'Meera Joshi',       'HR'),
(9, 'Rohit Kapoor',      'Marketing'),
(10, 'Pooja Menon',      'Marketing');

-- =========================================================
-- INSERT DATA INTO SALARIES
-- =========================================================

INSERT INTO salaries VALUES
(1, 50000.00),
(2, 85000.00),
(3, 62000.00),
(4, 95000.00),
(5, 54000.00),
(6, 47000.00),
(7, 99000.00),
(8, 52000.00),
(9, 68000.00),
(10, 72000.00);

-- =========================================================
-- DUPLICATE ENTRIES FOR TESTING
-- =========================================================

INSERT INTO salaries VALUES
(2, 85000.00),
(3, 62000.00);

-- =========================================================
-- 1. EMPLOYEES WITH SALARY
-- HIGHER THAN AVERAGE SALARY
-- =========================================================

SELECT name, department
FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM salaries
    WHERE salary > (
        SELECT AVG(salary)
        FROM salaries
    )
);

-- =========================================================
-- 2. CORRELATED SUBQUERY
-- HIGHEST SALARY IN EACH DEPARTMENT
-- =========================================================

SELECT e.name,
       e.department,
       s.salary
FROM employees e
JOIN salaries s
    ON e.employee_id = s.employee_id
WHERE s.salary = (
    SELECT MAX(s2.salary)
    FROM employees e2
    JOIN salaries s2
        ON e2.employee_id = s2.employee_id
    WHERE e2.department = e.department
);

-- =========================================================
-- 3. TOTAL SALARY PAID
-- IN EACH DEPARTMENT
-- =========================================================

SELECT DISTINCT department,
(
    SELECT SUM(s.salary)
    FROM employees e2
    JOIN salaries s
        ON e2.employee_id = s.employee_id
    WHERE e2.department = e.department
) AS total_department_salary
FROM employees e;

-- =========================================================
-- 4. EMPLOYEES WHO EARN LESS THAN
-- THEIR DEPARTMENT AVERAGE
-- =========================================================

SELECT e.name,
       e.department,
       s.salary
FROM employees e
JOIN salaries s
    ON e.employee_id = s.employee_id
WHERE s.salary < (
    SELECT AVG(s2.salary)
    FROM employees e2
    JOIN salaries s2
        ON e2.employee_id = s2.employee_id
    WHERE e2.department = e.department
);

-- =========================================================
-- 5. SUBQUERY + JOIN
-- DETAILED EMPLOYEE SALARY DATA
-- =========================================================

SELECT e.employee_id,
       e.name,
       e.department,
       sal.salary
FROM employees e
JOIN (
    SELECT employee_id, salary
    FROM salaries
) sal
ON e.employee_id = sal.employee_id;

-- =========================================================
-- 6. EMPLOYEES WHOSE SALARY
-- IS IN TOP 10% OF ALL SALARIES
-- =========================================================

SELECT e.name,
       e.department,
       s.salary
FROM employees e
JOIN salaries s
    ON e.employee_id = s.employee_id
WHERE s.salary >= (
    SELECT MAX(salary) * 0.90
    FROM salaries
);

-- =========================================================
-- 7. SUBQUERY IN SELECT CLAUSE
-- EMPLOYEE SALARY RANK
-- =========================================================

SELECT e.name,
       s.salary,
(
    SELECT COUNT(DISTINCT s2.salary) + 1
    FROM salaries s2
    WHERE s2.salary > s.salary
) AS salary_rank
FROM employees e
JOIN salaries s
    ON e.employee_id = s.employee_id
ORDER BY salary_rank;

-- =========================================================
-- 8. IDENTIFY DUPLICATE ENTRIES
-- IN SALARIES TABLE
-- =========================================================

SELECT employee_id,
       salary,
       COUNT(*) AS duplicate_count
FROM salaries
GROUP BY employee_id, salary
HAVING COUNT(*) > 1;

-- =========================================================
-- VERIFY TABLE DATA
-- =========================================================

SELECT * FROM employees;
SELECT * FROM salaries;
