Complete SQL SELECT Cheat Sheet (Beginner to Advanced)

This cheat sheet focuses entirely on the SELECT statement and almost every commonly used combination in SQL.

1. Basic SELECT
SELECT * 
FROM employees;

Retrieve all columns.

SELECT employee_id,
       employee_name,
       salary
FROM employees;

Retrieve specific columns.

2. Column Alias
SELECT employee_name AS Name,
       salary AS EmployeeSalary
FROM employees;

Output:

Name	EmployeeSalary
Arun	50000
3. Arithmetic Operations
SELECT employee_name,
       salary,
       salary * 12 AS annual_salary
FROM employees;
4. DISTINCT

Removes duplicates.

SELECT DISTINCT department
FROM employees;
5. WHERE Clause

Filters rows.

SELECT *
FROM employees
WHERE salary > 50000;
6. Comparison Operators
Operator	Meaning
=	Equal
<>	Not Equal
!=	Not Equal
>	Greater Than
<	Less Than
>=	Greater or Equal
<=	Less or Equal

Example:

SELECT *
FROM employees
WHERE salary >= 60000;
7. AND
SELECT *
FROM employees
WHERE department='IT'
AND salary > 60000;
8. OR
SELECT *
FROM employees
WHERE department='IT'
OR department='HR';
9. NOT
SELECT *
FROM employees
WHERE NOT department='HR';
10. BETWEEN
SELECT *
FROM employees
WHERE salary BETWEEN 50000 AND 80000;

Equivalent:

salary >= 50000
AND salary <= 80000
11. IN
SELECT *
FROM employees
WHERE department IN ('IT','HR','Finance');
12. NOT IN
SELECT *
FROM employees
WHERE department NOT IN ('HR');
13. LIKE

Pattern matching.

Starts With
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';
Ends With
SELECT *
FROM employees
WHERE employee_name LIKE '%a';
Contains
SELECT *
FROM employees
WHERE employee_name LIKE '%ar%';
Single Character
SELECT *
FROM employees
WHERE employee_name LIKE '_run';
14. IS NULL
SELECT *
FROM employees
WHERE manager_id IS NULL;
15. IS NOT NULL
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;
16. ORDER BY

Ascending:

SELECT *
FROM employees
ORDER BY salary;

Descending:

SELECT *
FROM employees
ORDER BY salary DESC;

Multiple Columns:

SELECT *
FROM employees
ORDER BY department,
         salary DESC;
17. LIMIT / TOP / FETCH
PostgreSQL/MySQL
SELECT *
FROM employees
LIMIT 5;
SQL Server
SELECT TOP 5 *
FROM employees;
Oracle/PostgreSQL
SELECT *
FROM employees
FETCH FIRST 5 ROWS ONLY;
18. Aggregate Functions
COUNT
SELECT COUNT(*)
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
19. GROUP BY
SELECT department,
       COUNT(*) employee_count
FROM employees
GROUP BY department;
20. HAVING

Filter aggregated data.

SELECT department,
       AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;
21. CASE Statement
SELECT employee_name,
       salary,
       CASE
          WHEN salary >= 100000 THEN 'A'
          WHEN salary >= 70000 THEN 'B'
          ELSE 'C'
       END AS grade
FROM employees;
22. INNER JOIN
SELECT e.employee_name,
       d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id;
23. LEFT JOIN
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id;

Returns all employees.

24. RIGHT JOIN
SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id=d.department_id;

Returns all departments.

25. FULL OUTER JOIN
SELECT *
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id=d.department_id;
26. CROSS JOIN
SELECT *
FROM colors
CROSS JOIN sizes;

Every combination.

27. SELF JOIN
SELECT e.employee_name,
       m.employee_name manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id=m.employee_id;
28. UNION

Removes duplicates.

SELECT city FROM customers
UNION
SELECT city FROM suppliers;
29. UNION ALL

Keeps duplicates.

SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers;
30. INTERSECT

Common records.

SELECT city FROM customers
INTERSECT
SELECT city FROM suppliers;
31. EXCEPT / MINUS

Records in first query only.

SELECT city FROM customers
EXCEPT
SELECT city FROM suppliers;

Oracle:

MINUS
32. Scalar Subquery
SELECT employee_name,
       salary,
       (SELECT AVG(salary)
        FROM employees) avg_salary
FROM employees;
33. Single Row Subquery
SELECT *
FROM employees
WHERE salary >
(
   SELECT AVG(salary)
   FROM employees
);
34. IN Subquery
SELECT *
FROM employees
WHERE department_id IN
(
   SELECT department_id
   FROM departments
   WHERE location='Bangalore'
);
35. EXISTS
SELECT *
FROM departments d
WHERE EXISTS
(
   SELECT 1
   FROM employees e
   WHERE e.department_id=d.department_id
);
36. NOT EXISTS
SELECT *
FROM departments d
WHERE NOT EXISTS
(
   SELECT 1
   FROM employees e
   WHERE e.department_id=d.department_id
);
37. Correlated Subquery
SELECT *
FROM employees e
WHERE salary >
(
   SELECT AVG(salary)
   FROM employees
   WHERE department_id=e.department_id
);
38. Derived Table
SELECT *
FROM
(
    SELECT department_id,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
) x;
39. Common Table Expression (CTE)
WITH dept_avg AS
(
    SELECT department_id,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_avg;
40. Recursive CTE
WITH RECURSIVE emp_hierarchy AS
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
    JOIN emp_hierarchy h
    ON e.manager_id=h.employee_id
)
SELECT *
FROM emp_hierarchy;
41. Window Functions
ROW_NUMBER()
SELECT employee_name,
       salary,
       ROW_NUMBER() OVER
       (
           ORDER BY salary DESC
       ) rn
FROM employees;
RANK()
SELECT employee_name,
       salary,
       RANK() OVER
       (
          ORDER BY salary DESC
       ) rnk
FROM employees;
DENSE_RANK()
SELECT employee_name,
       salary,
       DENSE_RANK() OVER
       (
          ORDER BY salary DESC
       ) drnk
FROM employees;
NTILE()
SELECT employee_name,
       salary,
       NTILE(4) OVER
       (
          ORDER BY salary DESC
       ) quartile
FROM employees;
42. LAG

Previous row value.

SELECT employee_name,
       salary,
       LAG(salary)
       OVER(ORDER BY salary) previous_salary
FROM employees;
43. LEAD

Next row value.

SELECT employee_name,
       salary,
       LEAD(salary)
       OVER(ORDER BY salary) next_salary
FROM employees;
44. FIRST_VALUE
SELECT employee_name,
       salary,
       FIRST_VALUE(salary)
       OVER(ORDER BY salary DESC)
FROM employees;
45. LAST_VALUE
SELECT employee_name,
       salary,
       LAST_VALUE(salary)
       OVER(
             ORDER BY salary
             ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
       )
FROM employees;
46. Running Total
SELECT employee_name,
       salary,
       SUM(salary)
       OVER
       (
          ORDER BY employee_id
       ) running_total
FROM employees;
47. Partition By
SELECT employee_name,
       department,
       salary,
       AVG(salary)
       OVER
       (
          PARTITION BY department
       ) dept_avg
FROM employees;
48. SELECT Execution Order

Most important interview question.

SELECT
FROM
JOIN
ON
WHERE
GROUP BY
HAVING
WINDOW FUNCTIONS
SELECT
DISTINCT
UNION
ORDER BY
LIMIT

Logical Processing Order:

1. FROM
2. JOIN
3. ON
4. WHERE
5. GROUP BY
6. HAVING
7. WINDOW FUNCTIONS
8. SELECT
9. DISTINCT
10. UNION/INTERSECT/EXCEPT
11. ORDER BY
12. LIMIT/OFFSET
49. Top N Records
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;
50. Top N Per Department
SELECT *
FROM
(
    SELECT employee_name,
           department,
           salary,
           ROW_NUMBER() OVER
           (
             PARTITION BY department
             ORDER BY salary DESC
           ) rn
    FROM employees
) x
WHERE rn <= 3;
51. Pagination
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 10 OFFSET 20;

Returns rows 21–30.

Most Common Real-World Combination
SELECT d.department_name,
       COUNT(*) employee_count,
       AVG(e.salary) avg_salary
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id
WHERE e.salary > 50000
GROUP BY d.department_name
HAVING AVG(e.salary) > 60000
ORDER BY avg_salary DESC;

This single query demonstrates:

✅ SELECT
✅ JOIN
✅ WHERE
✅ GROUP BY
✅ Aggregate Functions
✅ HAVING
✅ ORDER BY

These constructs cover roughly 90–95% of SQL SELECT queries used in real-world reporting, ETL, analytics, and data engineering projects.
