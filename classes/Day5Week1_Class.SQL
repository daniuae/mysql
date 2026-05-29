-- MySQL Complete Demo: Window Functions + CTE + CASE Expression + Stored Procedures + Triggers

-- Use the following single schema for all concepts.

-- 1. Create Tables
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2),
    joining_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
2. Insert Sample Data
INSERT INTO departments VALUES
(10,'IT'),
(20,'HR'),
(30,'Finance'),
(40,'Sales');

INSERT INTO employees VALUES
(101,'Arun',10,90000,'2020-01-15','Active'),
(102,'Priya',10,75000,'2021-03-20','Active'),
(103,'Rahul',20,65000,'2019-07-11','Active'),
(104,'Sneha',20,70000,'2022-05-01','Inactive'),
(105,'Vikram',30,85000,'2018-09-14','Active'),
(106,'Anitha',30,95000,'2017-11-25','Active'),
(107,'Kiran',40,60000,'2023-02-12','Active'),
(108,'Deepa',40,55000,'2023-06-15','Active');
===================================================
CASE EXPRESSION
===================================================
What is CASE?

CASE works like IF-ELSE in SQL.

Syntax
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE result3
END
Example 1: Salary Grade
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 90000 THEN 'Grade A'
        WHEN salary >= 70000 THEN 'Grade B'
        ELSE 'Grade C'
    END AS grade
FROM employees;
Output
Employee	Salary	Grade
Arun	90000	A
Priya	75000	B
Kiran	60000	C
Example 2: Employee Status
SELECT
    employee_name,
    status,
    CASE
        WHEN status='Active'
        THEN 'Working'

        ELSE 'Not Working'
    END AS employee_state
FROM employees;
===================================================
COMMON TABLE EXPRESSIONS (CTE)
===================================================
What is CTE?

Temporary result set available only for the query execution.

Think of it as:

Temporary Table
      OR
Named Subquery
Syntax
WITH cte_name AS
(
    SELECT ...
)
SELECT *
FROM cte_name;
Example 1: Employees with Salary > Average
Without CTE
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
Using CTE
WITH avg_salary AS
(
    SELECT AVG(salary) AS avg_sal
    FROM employees
)
SELECT e.*
FROM employees e
JOIN avg_salary a
ON e.salary > a.avg_sal;
Example 2: Department Wise Salary
WITH dept_salary AS
(
    SELECT
        department_id,
        SUM(salary) total_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_salary;
Example 3: Multiple CTEs
WITH dept_avg AS
(
    SELECT
        department_id,
        AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
),
high_paid AS
(
    SELECT *
    FROM employees
    WHERE salary > 80000
)
SELECT
    h.employee_name,
    h.salary,
    d.avg_salary
FROM high_paid h
JOIN dept_avg d
ON h.department_id=d.department_id;
===================================================
WINDOW FUNCTIONS
===================================================
What are Window Functions?

Perform calculations across rows without collapsing data.

Unlike GROUP BY, all rows remain visible.

ROW_NUMBER()

Assigns unique sequence.

SELECT
    employee_name,
    salary,
    ROW_NUMBER()
    OVER(ORDER BY salary DESC) AS row_num
FROM employees;
RANK()

Ties share same rank.

SELECT
    employee_name,
    salary,
    RANK()
    OVER(ORDER BY salary DESC) rank_no
FROM employees;
DENSE_RANK()

No gaps in ranking.

SELECT
    employee_name,
    salary,
    DENSE_RANK()
    OVER(ORDER BY salary DESC) dense_rank_no
FROM employees;
NTILE()

Divide records into buckets.

SELECT
    employee_name,
    salary,
    NTILE(4)
    OVER(ORDER BY salary DESC) quartile
FROM employees;
Department-wise Ranking
SELECT
    employee_name,
    department_id,
    salary,
    ROW_NUMBER()
    OVER
    (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) dept_rank
FROM employees;
Explanation
PARTITION BY department_id

IT Department
-------------
Arun
Priya

HR Department
-------------
Rahul
Sneha

Ranking restarts for every department.
Running Total
SELECT
    employee_name,
    salary,
    SUM(salary)
    OVER
    (
        ORDER BY employee_id
    ) running_total
FROM employees;
Department Wise Running Total
SELECT
    employee_name,
    department_id,
    salary,
    SUM(salary)
    OVER
    (
        PARTITION BY department_id
        ORDER BY employee_id
    ) dept_running_total
FROM employees;
LEAD()

Next row value.

SELECT
    employee_name,
    salary,
    LEAD(salary)
    OVER(ORDER BY salary DESC) next_salary
FROM employees;
LAG()

Previous row value.

SELECT
    employee_name,
    salary,
    LAG(salary)
    OVER(ORDER BY salary DESC) previous_salary
FROM employees;
===================================================
STORED PROCEDURES
===================================================
What is Stored Procedure?

A reusable SQL program stored inside MySQL.

Procedure 1: Get All Employees
DELIMITER $$

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT *
    FROM employees;
END $$

DELIMITER ;
Execute
CALL GetEmployees();
Procedure 2: Input Parameter
DELIMITER $$

CREATE PROCEDURE GetEmployeeByDept
(
    IN p_department_id INT
)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = p_department_id;
END $$

DELIMITER ;
Execute
CALL GetEmployeeByDept(10);
Procedure 3: Output Parameter
DELIMITER $$

CREATE PROCEDURE EmployeeCount
(
    OUT total_count INT
)
BEGIN
    SELECT COUNT(*)
    INTO total_count
    FROM employees;
END $$

DELIMITER ;
Execute
CALL EmployeeCount(@cnt);

SELECT @cnt;
Procedure 4: Input + Output
DELIMITER $$

CREATE PROCEDURE DepartmentSalary
(
    IN p_dept INT,
    OUT total_salary DECIMAL(10,2)
)
BEGIN
    SELECT SUM(salary)
    INTO total_salary
    FROM employees
    WHERE department_id=p_dept;
END $$

DELIMITER ;
Execute
CALL DepartmentSalary(10,@salary);

SELECT @salary;
===================================================
TRIGGERS
===================================================
What is Trigger?

Automatic code execution when INSERT, UPDATE or DELETE occurs.

BEFORE INSERT Trigger

Prevent Negative Salary

DELIMITER $$

CREATE TRIGGER trg_before_insert_employee
BEFORE INSERT
ON employees
FOR EACH ROW
BEGIN

    IF NEW.salary < 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT='Salary cannot be negative';
    END IF;

END $$

DELIMITER ;
Test
INSERT INTO employees
VALUES
(
109,
'Rakesh',
10,
-5000,
'2024-01-01',
'Active'
);
Result
ERROR:
Salary cannot be negative
AFTER UPDATE Trigger

Track Salary Changes

DELIMITER $$

CREATE TRIGGER trg_salary_audit
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN

    IF OLD.salary <> NEW.salary THEN

        INSERT INTO employee_audit
        (
            employee_id,
            old_salary,
            new_salary
        )
        VALUES
        (
            OLD.employee_id,
            OLD.salary,
            NEW.salary
        );

    END IF;

END $$

DELIMITER ;
Test
UPDATE employees
SET salary = 100000
WHERE employee_id = 101;
Verify
SELECT *
FROM employee_audit;
Combined Interview Scenario (CTE + Window Function + CASE)

Question: Find Top 2 Highest Paid Employees from each Department and classify them.

WITH ranked_employees AS
(
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        ROW_NUMBER()
        OVER
        (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) rn
    FROM employees
)
SELECT
    employee_name,
    department_id,
    salary,
    CASE
        WHEN salary >= 90000 THEN 'High Salary'
        WHEN salary >= 70000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END salary_category
FROM ranked_employees
WHERE rn <= 2;
/*
Concepts Used
✓ CTE
✓ ROW_NUMBER()
✓ PARTITION BY
✓ CASE Expression
✓ Filtering Top-N Records
✓ Real Interview Scenario

This single schema can be used to teach freshers and intermediate developers all five topics together in MySQL 8+.
/*
