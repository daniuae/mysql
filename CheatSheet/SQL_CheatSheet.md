# SQL Complete Cheat Sheet (Beginner → Advanced)

> A comprehensive SQL reference for beginners, developers, data engineers, analysts, and interview preparation.

---

# SQL Execution Order

Although we write SQL like this:

```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
```

SQL actually executes in this order:

```text
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT / TOP
```

---

# Database Commands

## Create Database

```sql
CREATE DATABASE CompanyDB;
```

## Select Database

### MySQL

```sql
USE CompanyDB;
```

### SQL Server

```sql
USE CompanyDB;
GO
```

---

# Table Commands

## Create Table

```sql
CREATE TABLE Employee
(
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);
```

## Alter Table

```sql
ALTER TABLE Employee
ADD Email VARCHAR(100);
```

## Rename Column

```sql
ALTER TABLE Employee
RENAME COLUMN Name TO EmployeeName;
```

## Drop Table

```sql
DROP TABLE Employee;
```

## Truncate Table

```sql
TRUNCATE TABLE Employee;
```

---

# CRUD Operations

## Insert

```sql
INSERT INTO Employee
VALUES
(1,'John',25,50000,'IT');
```

Multiple Records

```sql
INSERT INTO Employee VALUES
(2,'David',30,65000,'HR'),
(3,'Sara',28,70000,'Finance');
```

---

## Select

```sql
SELECT *
FROM Employee;
```

Specific Columns

```sql
SELECT Name, Salary
FROM Employee;
```

---

## Update

```sql
UPDATE Employee
SET Salary = 75000
WHERE EmployeeID = 1;
```

---

## Delete

```sql
DELETE
FROM Employee
WHERE EmployeeID = 1;
```

---

# WHERE Clause

```sql
WHERE Salary > 50000
```

```sql
WHERE Salary < 50000
```

```sql
WHERE Salary >= 50000
```

```sql
WHERE Salary <= 50000
```

```sql
WHERE Salary <> 50000
```

---

# Logical Operators

## AND

```sql
WHERE Department='IT'
AND Salary>60000;
```

## OR

```sql
WHERE Department='IT'
OR Department='HR';
```

## NOT

```sql
WHERE NOT Department='Finance';
```

---

# BETWEEN

```sql
WHERE Salary BETWEEN 50000 AND 80000;
```

---

# IN

```sql
WHERE Department IN
('IT','HR','Finance');
```

---

# LIKE

Starts With

```sql
WHERE Name LIKE 'A%';
```

Ends With

```sql
WHERE Name LIKE '%n';
```

Contains

```sql
WHERE Name LIKE '%oh%';
```

Single Character

```sql
WHERE Name LIKE '_a%';
```

---

# NULL

```sql
WHERE ManagerID IS NULL;
```

```sql
WHERE ManagerID IS NOT NULL;
```

---

# DISTINCT

```sql
SELECT DISTINCT Department
FROM Employee;
```

---

# ORDER BY

Ascending

```sql
ORDER BY Salary ASC;
```

Descending

```sql
ORDER BY Salary DESC;
```

Multiple Columns

```sql
ORDER BY Department,
Salary DESC;
```

---

# LIMIT / TOP

MySQL

```sql
LIMIT 5;
```

SQL Server

```sql
SELECT TOP 5 *
FROM Employee;
```

Oracle

```sql
FETCH FIRST 5 ROWS ONLY;
```

---

# Aggregate Functions

```sql
COUNT(*)
```

```sql
SUM(Salary)
```

```sql
AVG(Salary)
```

```sql
MIN(Salary)
```

```sql
MAX(Salary)
```

---

# GROUP BY

```sql
SELECT Department,
COUNT(*)
FROM Employee
GROUP BY Department;
```

---

# HAVING

```sql
SELECT Department,
AVG(Salary)
FROM Employee
GROUP BY Department
HAVING AVG(Salary)>60000;
```

---

# Alias

```sql
SELECT Salary AS MonthlySalary
FROM Employee;
```

---

# CASE

```sql
SELECT
Name,
CASE
WHEN Salary>80000 THEN 'High'
WHEN Salary>60000 THEN 'Medium'
ELSE 'Low'
END AS SalaryBand
FROM Employee;
```

---

# Arithmetic

```sql
SELECT Salary*12 AS AnnualSalary
FROM Employee;
```

---

# JOINS

## INNER JOIN

```sql
SELECT *
FROM Employee e
INNER JOIN Department d
ON e.DepartmentID=d.DepartmentID;
```

## LEFT JOIN

```sql
SELECT *
FROM Employee e
LEFT JOIN Department d
ON e.DepartmentID=d.DepartmentID;
```

## RIGHT JOIN

```sql
SELECT *
FROM Employee e
RIGHT JOIN Department d
ON e.DepartmentID=d.DepartmentID;
```

## FULL OUTER JOIN

```sql
SELECT *
FROM Employee e
FULL OUTER JOIN Department d
ON e.DepartmentID=d.DepartmentID;
```

## CROSS JOIN

```sql
SELECT *
FROM Employee
CROSS JOIN Department;
```

## SELF JOIN

```sql
SELECT
e.Name,
m.Name AS Manager
FROM Employee e
LEFT JOIN Employee m
ON e.ManagerID=m.EmployeeID;
```

---

# UNION

```sql
SELECT Name FROM Employee

UNION

SELECT Name FROM Manager;
```

---

# UNION ALL

```sql
SELECT Name FROM Employee

UNION ALL

SELECT Name FROM Manager;
```

---

# EXISTS

```sql
SELECT *
FROM Employee e
WHERE EXISTS
(
SELECT 1
FROM Orders o
WHERE o.EmployeeID=e.EmployeeID
);
```

---

# Subqueries

```sql
SELECT *
FROM Employee
WHERE Salary >
(
SELECT AVG(Salary)
FROM Employee
);
```

---

# Correlated Subquery

```sql
SELECT *
FROM Employee e
WHERE Salary >
(
SELECT AVG(Salary)
FROM Employee
WHERE Department=e.Department
);
```

---

# Common Table Expression (CTE)

```sql
WITH EmployeeCTE AS
(
SELECT *
FROM Employee
)
SELECT *
FROM EmployeeCTE;
```

---

# Recursive CTE

```sql
WITH RecursiveCTE AS
(
SELECT 1 AS Number

UNION ALL

SELECT Number+1
FROM RecursiveCTE
WHERE Number<10
)

SELECT *
FROM RecursiveCTE;
```

---

# Views

```sql
CREATE VIEW EmployeeView AS
SELECT *
FROM Employee;
```

---

# Constraints

```sql
PRIMARY KEY
```

```sql
FOREIGN KEY
```

```sql
UNIQUE
```

```sql
NOT NULL
```

```sql
CHECK
```

```sql
DEFAULT
```

---

# Indexes

```sql
CREATE INDEX idx_name
ON Employee(Name);
```

Unique Index

```sql
CREATE UNIQUE INDEX idx_email
ON Employee(Email);
```

---

# Transactions

```sql
BEGIN TRANSACTION;

UPDATE Employee
SET Salary=70000
WHERE EmployeeID=1;

COMMIT;
```

Rollback

```sql
ROLLBACK;
```

---

# Window Functions

## ROW_NUMBER

```sql
ROW_NUMBER()
OVER(ORDER BY Salary DESC)
```

## RANK

```sql
RANK()
OVER(ORDER BY Salary DESC)
```

## DENSE_RANK

```sql
DENSE_RANK()
OVER(ORDER BY Salary DESC)
```

## NTILE

```sql
NTILE(4)
OVER(ORDER BY Salary DESC)
```

## LEAD

```sql
LEAD(Salary)
OVER(ORDER BY Salary)
```

## LAG

```sql
LAG(Salary)
OVER(ORDER BY Salary)
```

## FIRST_VALUE

```sql
FIRST_VALUE(Salary)
OVER(ORDER BY Salary)
```

## LAST_VALUE

```sql
LAST_VALUE(Salary)
OVER(ORDER BY Salary)
```

---

# String Functions

```sql
UPPER(Name)
```

```sql
LOWER(Name)
```

```sql
TRIM(Name)
```

```sql
SUBSTRING(Name,1,5)
```

```sql
REPLACE(Name,'a','A')
```

```sql
CONCAT(FirstName,' ',LastName)
```

```sql
LENGTH(Name)
```

SQL Server

```sql
LEN(Name)
```

---

# Numeric Functions

```sql
ROUND()
```

```sql
ABS()
```

```sql
CEILING()
```

```sql
FLOOR()
```

```sql
POWER()
```

```sql
SQRT()
```

```sql
MOD()
```

```sql
RAND()
```

---

# Date Functions

Current Date

```sql
CURRENT_DATE
```

Current Timestamp

```sql
CURRENT_TIMESTAMP
```

SQL Server

```sql
GETDATE()
```

Date Add

```sql
DATEADD()
```

Date Difference

```sql
DATEDIFF()
```

Year

```sql
YEAR(Date)
```

Month

```sql
MONTH(Date)
```

Day

```sql
DAY(Date)
```

---

# Conversion Functions

```sql
CAST()
```

```sql
CONVERT()
```

---

# NULL Functions

```sql
COALESCE()
```

```sql
NULLIF()
```

---

# Pivot

```sql
PIVOT(...)
```

---

# Unpivot

```sql
UNPIVOT(...)
```

---

# MERGE (UPSERT)

```sql
MERGE
WHEN MATCHED
WHEN NOT MATCHED;
```

---

# Stored Procedures

```sql
CREATE PROCEDURE GetEmployees
AS
BEGIN
SELECT *
FROM Employee;
END;
```

---

# User Defined Functions

```sql
CREATE FUNCTION
```

---

# Triggers

```sql
CREATE TRIGGER
```

---

# Temporary Tables

SQL Server

```sql
CREATE TABLE #TempTable
(
ID INT
);
```

PostgreSQL

```sql
CREATE TEMP TABLE TempEmployee
(
ID INT
);
```

---

# Variables (SQL Server)

```sql
DECLARE @Salary INT;

SET @Salary = 50000;
```

---

# SQL Clause Order

```
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
WINDOW
ORDER BY
LIMIT
```

---

# Join Summary

| Join | Description |
|------|-------------|
| INNER | Matching rows only |
| LEFT | All left rows |
| RIGHT | All right rows |
| FULL | All rows |
| CROSS | Cartesian Product |
| SELF | Join same table |

---

# Window Function Summary

| Function | Purpose |
|----------|----------|
| ROW_NUMBER | Sequential numbering |
| RANK | Rank with gaps |
| DENSE_RANK | Rank without gaps |
| NTILE | Divide into buckets |
| LEAD | Next row |
| LAG | Previous row |
| FIRST_VALUE | First value |
| LAST_VALUE | Last value |

---

# SQL Learning Roadmap

## Beginner

- SELECT
- WHERE
- ORDER BY
- INSERT
- UPDATE
- DELETE
- DISTINCT

## Intermediate

- GROUP BY
- HAVING
- CASE
- JOINS
- Aggregate Functions
- Subqueries

## Advanced

- CTE
- Window Functions
- Views
- Indexes
- Transactions
- Stored Procedures
- Functions
- Triggers
- MERGE
- Performance Tuning

---

# SQL Performance Tips

- Avoid `SELECT *` in production.
- Create indexes on frequently filtered columns.
- Filter data early using `WHERE`.
- Use appropriate JOIN types.
- Use `EXISTS` instead of `IN` for large correlated queries when appropriate.
- Review execution plans.
- Keep statistics updated.
- Use proper data types.
- Avoid functions on indexed columns in `WHERE`.
- Partition very large tables when appropriate.

---

# Interview Checklist

- SQL Execution Order
- CRUD
- WHERE
- GROUP BY
- HAVING
- CASE
- JOINS
- UNION
- Subqueries
- CTE
- Window Functions
- Views
- Indexes
- Transactions
- Stored Procedures
- Triggers
- Performance Tuning
