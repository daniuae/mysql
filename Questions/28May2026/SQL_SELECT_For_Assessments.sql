COMPLETE SQL SELECT CHEAT SHEET (BEGINNER → ADVANCED → INTERVIEW LEVEL)

This is a consolidated reference covering:

✅ SELECT
✅ WHERE
✅ ORDER BY
✅ GROUP BY
✅ HAVING
✅ JOINS
✅ SUBQUERIES
✅ CTEs
✅ Aggregate Functions
✅ Window Functions
✅ Set Operators
✅ Ranking Functions
✅ Analytical Functions
✅ Real-world Query Patterns

1. BASIC SELECT
SELECT *
FROM employees;
SELECT employee_id,
       employee_name,
       salary
FROM employees;
2. COLUMN ALIAS
SELECT employee_name AS employee,
       salary AS monthly_salary
FROM employees;
3. DISTINCT
SELECT DISTINCT department
FROM employees;
4. WHERE CONDITIONS
Equal
SELECT *
FROM employees
WHERE department='IT';
Not Equal
SELECT *
FROM employees
WHERE department <> 'IT';
Multiple Conditions
SELECT *
FROM employees
WHERE salary > 50000
AND department='IT';
OR
SELECT *
FROM employees
WHERE department='IT'
OR department='HR';
BETWEEN
SELECT *
FROM employees
WHERE salary BETWEEN 50000 AND 100000;
IN
SELECT *
FROM employees
WHERE department IN ('IT','HR','Finance');
NOT IN
SELECT *
FROM employees
WHERE department NOT IN ('HR');
LIKE
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';

Starts with A

LIKE '%A'

Ends with A

LIKE '%AR%'

Contains AR

NULL
SELECT *
FROM employees
WHERE manager_id IS NULL;
5. ORDER BY
SELECT *
FROM employees
ORDER BY salary DESC;

Multiple Columns

SELECT *
FROM employees
ORDER BY department,
         salary DESC;
6. LIMIT / TOP

PostgreSQL / MySQL

SELECT *
FROM employees
LIMIT 10;

SQL Server

SELECT TOP 10 *
FROM employees;
7. AGGREGATE FUNCTIONS
COUNT
SELECT COUNT(*)
FROM employees;
COUNT DISTINCT
SELECT COUNT(DISTINCT department)
FROM employees;
SUM
SELECT SUM(salary)
FROM employees;
AVG
SELECT AVG(salary)
FROM employees;
MIN
SELECT MIN(salary)
FROM employees;
MAX
SELECT MAX(salary)
FROM employees;
STRING_AGG (PostgreSQL)
SELECT department,
       STRING_AGG(employee_name, ', ')
FROM employees
GROUP BY department;
ARRAY_AGG (PostgreSQL)
SELECT department,
       ARRAY_AGG(employee_name)
FROM employees
GROUP BY department;
Statistical Aggregates (PostgreSQL)
Variance
SELECT VARIANCE(salary)
FROM employees;
Standard Deviation
SELECT STDDEV(salary)
FROM employees;
8. GROUP BY
SELECT department,
       COUNT(*) total_employees
FROM employees
GROUP BY department;

Multiple Columns

SELECT department,
       designation,
       COUNT(*)
FROM employees
GROUP BY department,
         designation;
9. HAVING
SELECT department,
       AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;
10. CASE EXPRESSION
SELECT employee_name,
       salary,
       CASE
            WHEN salary >= 100000 THEN 'A'
            WHEN salary >= 70000 THEN 'B'
            ELSE 'C'
       END grade
FROM employees;
11. JOINS
INNER JOIN
SELECT e.employee_name,
       d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id;
LEFT JOIN
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id;
RIGHT JOIN
SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id=d.department_id;
FULL OUTER JOIN
SELECT *
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id=d.department_id;
CROSS JOIN
SELECT *
FROM colors
CROSS JOIN sizes;
SELF JOIN
SELECT e.employee_name,
       m.employee_name manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id=m.employee_id;
12. SUBQUERIES
Scalar Subquery

Returns exactly one value.

SELECT employee_name,
       salary,
       (
          SELECT AVG(salary)
          FROM employees
       ) company_avg_salary
FROM employees;
Single Row Subquery
SELECT *
FROM employees
WHERE salary >
(
   SELECT AVG(salary)
   FROM employees
);
Multiple Row Subquery
SELECT *
FROM employees
WHERE department_id IN
(
   SELECT department_id
   FROM departments
   WHERE location='Bangalore'
);
Correlated Subquery

Runs once per row.

SELECT *
FROM employees e
WHERE salary >
(
   SELECT AVG(salary)
   FROM employees
   WHERE department_id=e.department_id
);
EXISTS
SELECT *
FROM departments d
WHERE EXISTS
(
     SELECT 1
     FROM employees e
     WHERE e.department_id=d.department_id
);
NOT EXISTS
SELECT *
FROM departments d
WHERE NOT EXISTS
(
     SELECT 1
     FROM employees e
     WHERE e.department_id=d.department_id
);
ANY
SELECT *
FROM employees
WHERE salary >
ANY
(
   SELECT salary
   FROM employees
   WHERE department='HR'
);

Meaning:

Salary greater than at least one HR employee.

ALL
SELECT *
FROM employees
WHERE salary >
ALL
(
   SELECT salary
   FROM employees
   WHERE department='HR'
);

Meaning:

Salary greater than every HR employee.

13. DERIVED TABLE
SELECT *
FROM
(
    SELECT department_id,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
) x;
14. COMMON TABLE EXPRESSIONS (CTE)
WITH dept_avg AS
(
    SELECT department_id,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_avg;
15. RECURSIVE CTE
WITH RECURSIVE hierarchy AS
(
    SELECT employee_id,
           employee_name,
           manager_id
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id,
           e.employee_name,
           e.manager_id
    FROM employees e
    JOIN hierarchy h
    ON e.manager_id=h.employee_id
)
SELECT *
FROM hierarchy;
16. SET OPERATORS
UNION
SELECT city FROM customers
UNION
SELECT city FROM suppliers;
UNION ALL
SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers;
INTERSECT
SELECT city FROM customers
INTERSECT
SELECT city FROM suppliers;
EXCEPT
SELECT city FROM customers
EXCEPT
SELECT city FROM suppliers;
17. WINDOW FUNCTIONS

Syntax:

Function()
OVER
(
    PARTITION BY ...
    ORDER BY ...
)
18. ROW_NUMBER()
SELECT employee_name,
       salary,
       ROW_NUMBER()
       OVER(ORDER BY salary DESC) rn
FROM employees;
19. RANK()
SELECT employee_name,
       salary,
       RANK()
       OVER(ORDER BY salary DESC) rnk
FROM employees;
20. DENSE_RANK()
SELECT employee_name,
       salary,
       DENSE_RANK()
       OVER(ORDER BY salary DESC) drnk
FROM employees;
21. NTILE()
SELECT employee_name,
       salary,
       NTILE(4)
       OVER(ORDER BY salary DESC)
FROM employees;
22. LAG()

Previous Row

SELECT employee_name,
       salary,
       LAG(salary)
       OVER(ORDER BY salary)
FROM employees;
23. LEAD()

Next Row

SELECT employee_name,
       salary,
       LEAD(salary)
       OVER(ORDER BY salary)
FROM employees;
24. FIRST_VALUE()
SELECT employee_name,
       FIRST_VALUE(employee_name)
       OVER(ORDER BY salary DESC)
FROM employees;
25. LAST_VALUE()
SELECT employee_name,
       LAST_VALUE(employee_name)
       OVER(
             ORDER BY salary
             ROWS BETWEEN
             UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
       )
FROM employees;
26. NTH_VALUE()
SELECT employee_name,
       NTH_VALUE(employee_name,3)
       OVER(
             ORDER BY salary DESC
             ROWS BETWEEN
             UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
       )
FROM employees;
27. Running Total
SELECT employee_name,
       salary,
       SUM(salary)
       OVER(ORDER BY employee_id)
FROM employees;
28. Running Average
SELECT employee_name,
       AVG(salary)
       OVER(ORDER BY employee_id)
FROM employees;
29. Partition Based Aggregation
SELECT employee_name,
       department,
       salary,
       AVG(salary)
       OVER(PARTITION BY department)
FROM employees;
30. Window Aggregates
SUM
SUM(salary)
OVER(PARTITION BY department)
AVG
AVG(salary)
OVER(PARTITION BY department)
MIN
MIN(salary)
OVER(PARTITION BY department)
MAX
MAX(salary)
OVER(PARTITION BY department)
COUNT
COUNT(*)
OVER(PARTITION BY department)
31. TOP N PER GROUP
SELECT *
FROM
(
     SELECT employee_name,
            department,
            salary,
            ROW_NUMBER()
            OVER(
                PARTITION BY department
                ORDER BY salary DESC
            ) rn
     FROM employees
) x
WHERE rn <= 3;
32. PAGINATION
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 10 OFFSET 20;
33. SELECT EXECUTION ORDER (VERY IMPORTANT)
1. FROM
2. JOIN
3. ON
4. WHERE
5. GROUP BY
6. Aggregate Functions
7. HAVING
8. Window Functions
9. SELECT
10. DISTINCT
11. UNION / INTERSECT / EXCEPT
12. ORDER BY
13. LIMIT / OFFSET
34. MOST COMMON INTERVIEW QUERY

Employees earning more than their department average.

SELECT employee_id,
       employee_name,
       department_id,
       salary
FROM employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
    WHERE department_id=e.department_id
);
35. MOST COMMON DATA ENGINEER QUERY

Latest Order Per Customer

SELECT *
FROM
(
      SELECT customer_id,
             order_id,
             order_date,
             ROW_NUMBER()
             OVER(
                 PARTITION BY customer_id
                 ORDER BY order_date DESC
             ) rn
      FROM orders
) x
WHERE rn=1;
36. ULTIMATE SELECT TEMPLATE
WITH cte_name AS
(
    SELECT ...
    FROM table1 t1
    JOIN table2 t2
      ON t1.id=t2.id
    WHERE condition
)

SELECT column_list,
       aggregate_function(),
       window_function()
OVER(
      PARTITION BY ...
      ORDER BY ...
)
FROM cte_name
WHERE condition
GROUP BY columns
HAVING condition
UNION
SELECT ...
ORDER BY columns
LIMIT n;

This single cheat sheet covers approximately 98% of SELECT-related SQL asked in interviews, used in reporting, ETL pipelines, data warehousing, analytics, PostgreSQL, MySQL, SQL Server, Oracle, Snowflake, BigQuery, Redshift, Databricks SQL, and Spark SQL projects.
