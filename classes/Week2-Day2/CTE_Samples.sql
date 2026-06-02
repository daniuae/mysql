-- Introduction to CTE's

-- Objective
-- Learn how to:

-- Use CTEs (WITH clause) to simplify complex queries
-- Create recursive CTEs for hierarchical data
-- Chain multiple CTEs together
-- Apply CTEs for data transformation, reporting, and cleanup

-- Business Scenario
-- You work for Learnlytica Training Corp, where course and enrollment data is stored in MySQL.

-- You need to:

-- Summarize total enrollments per course
-- Identify active students
-- Explore recursive relationships like manager–employee structures
-- Instead of writing long nested queries, you’ll use Common Table Expressions for clarity and reusability.

-- Pre-Lab Setup
-- Login to MySQL

-- mysql - u root - p

-- Create a new lab database

CREATE DATABASE sql_lab_cte;

USE sql_lab_cte;

-- Create tables

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    category VARCHAR(50),
    fee DECIMAL(10, 2)
);

CREATE TABLE enrollments (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    student_name VARCHAR(50),
    enrollment_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

-- Insert sample data

INSERT INTO
    courses (course_name, category, fee)
VALUES (
        'Python Basics',
        'Programming',
        300
    ),
    ('Advanced SQL', 'Data', 400),
    (
        'Power BI Dashboards',
        'Analytics',
        350
    ),
    (
        'Linux Fundamentals',
        'Infrastructure',
        250
    ),
    ('Machine Learning', 'AI', 500);

INSERT INTO
    enrollments (
        course_id,
        student_name,
        enrollment_date,
        status
    )
VALUES (
        1,
        'Alice',
        '2024-01-10',
        'Active'
    ),
    (
        2,
        'Bob',
        '2024-02-05',
        'Active'
    ),
    (
        2,
        'Charlie',
        '2024-03-01',
        'Inactive'
    ),
    (
        3,
        'Daisy',
        '2024-03-12',
        'Active'
    ),
    (
        4,
        'Ethan',
        '2024-04-18',
        'Active'
    ),
    (
        5,
        'Fiona',
        '2024-05-22',
        'Inactive'
    ),
    (
        1,
        'George',
        '2024-02-08',
        'Active'
    ),
    (
        2,
        'Helen',
        '2024-03-19',
        'Active'
    ),
    (
        3,
        'Ian',
        '2024-03-22',
        'Inactive'
    );

-- Preview

SELECT * FROM courses;

SELECT * FROM enrollments;

-- Part A - Introduction to CTEs
-- A CTE (Common Table Expression) is a temporary, named result set.
-- It’s defined using a WITH clause, and exists only during query execution.
-- You can think of it as a “temporary view” for better readability.
-- CTEs make multi-step queries much cleaner than nested subqueries.

--  Part B - Basic CTE Example
-- Create a simple CTE that retrieves all active enrollments:
-- select avg(salary) from employees;

WITH
    avg_cte as (
        select *
        from employees
    )
select *
from avg_cte;

with RECURSIVE avg_recur_cte as (



)

WITH
    active_students AS (
        SELECT student_name, course_id, status
        FROM enrollments
        WHERE
            status = 'Active'
    )
SELECT *
FROM active_students;

-- Observe: You can query active_students as if it were a real table.
-- It vanishes after execution — it’s temporary.

-- Part C -Using CTE with Joins

-- Combine CTE results with other tables for richer insights:

WITH
    active_students AS (
        SELECT student_name, course_id
        FROM enrollments
        WHERE
            status = 'Active'
    )
SELECT a.student_name, c.course_name, c.category
FROM active_students a
    JOIN courses c ON a.course_id = c.course_id;

-- This helps HR or trainers see which students are actively learning which course.

/**********************************************************************************/
use sql_lab_cte;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    manager_id INT
);

INSERT INTO
    employees
VALUES (1, 'CEO', NULL),
    (2, 'Sales Head', 1),
    (3, 'Finance Head', 1),
    (4, 'Sales Exec', 2),
    (5, 'Accountant', 3);

WITH RECURSIVE
    org AS (
        SELECT
            emp_id,
            emp_name,
            manager_id,
            1 AS level
        FROM employees
        WHERE
            manager_id IS NULL
        UNION ALL
        SELECT e.emp_id, e.emp_name, e.manager_id, o.level + 1
        FROM employees e
            JOIN org o ON e.manager_id = o.emp_id
    )
SELECT *
FROM org;

WITH RECURSIVE
    org as (
        SELECT
            emp_id,
            emp_name,
            manager_id,
            1 as level
        from employees
        where
            manager_id is null
        UNION ALL
        SELECT e.emp_id, e.emp_name, e.manager_id, o.level + 1
        from employees e
            join org o on e.manager_id = o.emp_id
    )
select *
from org;

use labcte;

select department, avg(salary) as avg_salary
from employees
GROUP BY
    department;

select * from employees;

WITH
    avg_dept AS (
        SELECT department, AVG(salary) AS avg_salary
        FROM Employees
        GROUP BY
            department
    )
SELECT *
FROM avg_dept
WHERE
    avg_salary > 50000;

-- SHOW PROFILE FOR QUERY N;
SHOW STATUS LIKE 'Created_tmp%';

with
    dept_cte as (
        select department, avg(salary) as avg_sal
        from Employees
        group by
            department
    )
select *
from dept_cte
where
    avg_sal > 50000;

/**********************************************************************************/
