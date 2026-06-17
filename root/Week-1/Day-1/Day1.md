# SQL Scenarios: When to Use Subqueries, Derived Tables, and Correlated Subqueries

One of the most common SQL design questions is:

> When should I use a Subquery, Derived Table, or Correlated Subquery?

The answer depends on the business problem you are trying to solve.

---

# 1. Subquery

A subquery is a query nested inside another query.

```sql
SELECT *
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);
```

---

## When to Use a Subquery

### Scenario 1: Compare Against an Aggregate Value

**Problem:** Find employees earning more than the company average salary.

```sql
SELECT EmployeeName,
       Salary
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);
```

### Why?

The average salary must be calculated first before comparing individual employee salaries.

---

### Scenario 2: Retrieve a Value from Another Table

**Problem:** Find employees belonging to the IT department.

```sql
SELECT *
FROM Employees
WHERE DepartmentID =
(
    SELECT DepartmentID
    FROM Departments
    WHERE DepartmentName = 'IT'
);
```

---

### Scenario 3: Check Membership Using IN

**Problem:** Find customers who have placed orders.

```sql
SELECT *
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
);
```

---

### Scenario 4: Check Existence Using EXISTS

**Problem:** Find customers who have at least one order.

```sql
SELECT *
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
);
```

---

## Real-World Use Cases

- Employees above average salary
- Products sold at least once
- Customers with orders
- Products never ordered
- Employees belonging to a specific department

---

# 2. Derived Table (Inline View)

A derived table is a subquery placed inside the `FROM` clause.

It acts as a temporary table.

```sql
SELECT *
FROM
(
    SELECT DepartmentID,
           AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) DeptSalary;
```

---

## When to Use a Derived Table

### Scenario 1: Aggregate First, Then Filter

**Problem:** Find departments whose average salary exceeds 80,000.

```sql
SELECT *
FROM
(
    SELECT DepartmentID,
           AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) D
WHERE AvgSalary > 80000;
```

---

### Scenario 2: Multi-Step Calculations

**Problem:** Calculate total sales per customer.

```sql
SELECT *
FROM
(
    SELECT CustomerID,
           SUM(Amount) AS TotalSales
    FROM Orders
    GROUP BY CustomerID
) SalesSummary;
```

---

### Scenario 3: Simplify Complex Queries

Instead of writing one huge query:

```sql
SELECT ...
FROM Orders
JOIN Customers
JOIN Products
JOIN Payments;
```

Break it into logical parts:

```sql
SELECT *
FROM
(
    SELECT ...
    FROM Orders
    JOIN Customers
) X;
```

---

### Scenario 4: Top N Analysis

**Problem:** Get departments ranked by total sales.

```sql
SELECT *
FROM
(
    SELECT DepartmentID,
           SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY DepartmentID
) D
ORDER BY TotalSales DESC;
```

---

## Real-World Use Cases

- Dashboard reporting
- Revenue calculations
- Sales summaries
- Aggregation before joins
- Ranking and analytics

---

# 3. Correlated Subquery

A correlated subquery references columns from the outer query.

It executes once for every row processed by the outer query.

```sql
SELECT *
FROM Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
```

Notice:

```sql
e.DepartmentID
```

The inner query depends on the outer query.

---

## When to Use a Correlated Subquery

### Scenario 1: Compare Within a Group

**Problem:** Find employees earning more than their department average salary.

```sql
SELECT EmployeeName,
       Salary,
       DepartmentID
FROM Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
```

---

### Scenario 2: Find Latest Record Per Group

**Problem:** Find the latest order for each customer.

```sql
SELECT *
FROM Orders o
WHERE OrderDate =
(
    SELECT MAX(OrderDate)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);
```

---

### Scenario 3: Highest Salary Per Department

```sql
SELECT *
FROM Employees e
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
```

---

### Scenario 4: Duplicate Detection

**Problem:** Find duplicate email addresses.

```sql
SELECT *
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Customers c2
    WHERE c.Email = c2.Email
      AND c.CustomerID <> c2.CustomerID
);
```

---

### Scenario 5: Products Never Ordered

```sql
SELECT *
FROM Products p
WHERE NOT EXISTS
(
    SELECT 1
    FROM OrderDetails od
    WHERE p.ProductID = od.ProductID
);
```

---

## Real-World Use Cases

- Top performer in each department
- Latest transaction per customer
- Duplicate record detection
- Data validation
- Fraud analysis
- Missing relationship checks

---

# Visual Understanding

## Subquery

```text
Calculate Once
       ↓
Use Result in Main Query
```

Example:

```text
AVG Salary
    ↓
Employees > AVG Salary
```

---

## Derived Table

```text
Create Temporary Result Set
           ↓
Use Like a Table
           ↓
Filter / Join / Sort
```

Example:

```text
Department Average Salary
            ↓
Filter Avg Salary > 80000
```

---

## Correlated Subquery

```text
Outer Row 1 → Execute Subquery
Outer Row 2 → Execute Subquery
Outer Row 3 → Execute Subquery
...
```

Example:

```text
Employee A → Compare with Dept A Average

Employee B → Compare with Dept B Average

Employee C → Compare with Dept C Average
```

---

# Comparison Table

| Feature | Subquery | Derived Table | Correlated Subquery |
|----------|----------|----------|----------|
| Location | WHERE, SELECT | FROM | WHERE |
| Depends on Outer Query | No | No | Yes |
| Execution | Once | Once | Per Row |
| Performance | Good | Good | Can Be Slower |
| Best For | Single Value/List | Intermediate Result Set | Row-by-Row Comparison |

---

# Interview Questions and Solutions

## Question 1

### Find employees earning above company average salary.

**Use:** Subquery

```sql
SELECT *
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);
```

---

## Question 2

### Find departments whose average salary exceeds 80,000.

**Use:** Derived Table

```sql
SELECT *
FROM
(
    SELECT DepartmentID,
           AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) D
WHERE AvgSalary > 80000;
```

---

## Question 3

### Find employees earning above their department average.

**Use:** Correlated Subquery

```sql
SELECT *
FROM Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
```

---

## Question 4

### Find the latest order for every customer.

**Use:** Correlated Subquery

```sql
SELECT *
FROM Orders o
WHERE OrderDate =
(
    SELECT MAX(OrderDate)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);
```

---

# Quick Decision Guide

### Use a Subquery When

✅ You need a value or list of values first.

```sql
Salary > AVG(Salary)
```

```sql
DepartmentID IN (...)
```

---

### Use a Derived Table When

✅ You need a temporary result set.

```text
Aggregate → Filter

Aggregate → Join

Aggregate → Rank

Aggregate → Sort
```

---

### Use a Correlated Subquery When

✅ Every row requires its own comparison.

```text
Employee vs Department Average

Customer vs Latest Customer Order

Product vs Product Sales
```

---

# Golden Rule

| Requirement | Best Choice |
|------------|-------------|
| Need a value first | Subquery |
| Need a temporary table | Derived Table |
| Need row-by-row comparison | Correlated Subquery |

### Easy Way to Remember

- **Subquery** → "Get me a value first."
- **Derived Table** → "Create a temporary table first."
- **Correlated Subquery** → "For each row, compare against related rows."
