# SQL Training Guide: Subquery vs Correlated Subquery vs Common Table Expression (CTE)

> **Database Used:** AdventureWorks  
> **Target Audience:** SQL Beginners, Developers, Data Engineers, BI Developers

---

# Introduction

One of the most common questions in SQL interviews and real-world projects is:

- When should I use a **Subquery**?
- When should I use a **Correlated Subquery**?
- When should I use a **Common Table Expression (CTE)**?

Although these three techniques may sometimes produce the same result, they are designed for **different business problems**.

---

# Quick Comparison

| Feature | Subquery | Correlated Subquery | Common Table Expression (CTE) |
|----------|----------|---------------------|-------------------------------|
| Executes | Once | Once for every row of outer query | Once (logical result set) |
| Depends on Outer Query | ❌ No | ✅ Yes | ❌ No |
| Readability | Medium | Low | Excellent |
| Performance | Usually Good | Can be Slow | Good (depends on optimizer) |
| Easy to Maintain | Medium | Difficult | Excellent |
| Best Used For | Single calculation | Row-by-row comparison | Complex reports |

---

# Decision Tree

```text
Need a single value?

        │
        ▼

     YES
        │
        ▼

 Use Subquery

        │
        ▼

NO

Need comparison against each row?

        │
        ▼

YES

        │
        ▼

Use Correlated Subquery

        │
        ▼

NO

Large report?

Multiple calculations?

Need readability?

        │
        ▼

Use CTE
```

---

# 1. Subquery

## Definition

A **Subquery** is a query inside another SQL query.

The database executes the subquery first.

The result is then supplied to the outer query.

---

## Execution Flow

```text
Subquery Executes

↓

Returns Result

↓

Outer Query Uses Result
```

---

## Business Scenario

You are the **Sales Director** of AdventureWorks.

You ask:

> Show me products whose price is greater than the company's average product price.

The database first calculates the average product price.

Then it returns all products whose price exceeds that average.

---

## AdventureWorks Table

```
Production.Product
```

| Column |
|----------|
| ProductID |
| Name |
| ListPrice |

---

## SQL Example

```sql
SELECT ProductID,
       Name,
       ListPrice
FROM Production.Product
WHERE ListPrice >
(
    SELECT AVG(ListPrice)
    FROM Production.Product
);
```

---

## Step-by-Step Execution

### Step 1

```sql
SELECT AVG(ListPrice)
FROM Production.Product;
```

Example Output

```
438.66
```

---

### Step 2

SQL becomes

```sql
SELECT ProductID,
       Name,
       ListPrice
FROM Production.Product
WHERE ListPrice > 438.66;
```

---

## Business Use Cases

| Industry | Scenario |
|-----------|----------|
| Retail | Products priced above average |
| Banking | Accounts with balance above average |
| Healthcare | Patients older than average age |
| HR | Employees earning above company average |
| Manufacturing | Machines producing above average output |

---

## When to Use

Use a Subquery when:

- Comparing against average
- Comparing against maximum
- Comparing against minimum
- Comparing against total count
- Comparing against total sales

---

## Advantages

- Easy to write
- Easy to understand
- Executes once
- Good performance

---

## Disadvantages

- Difficult to maintain if deeply nested
- Repeated subqueries reduce readability

---

# 2. Correlated Subquery

## Definition

A **Correlated Subquery** references columns from the outer query.

The subquery executes once **for every row** processed by the outer query.

---

## Execution Flow

```text
Read First Row

↓

Run Subquery

↓

Read Second Row

↓

Run Subquery

↓

Read Third Row

↓

Run Subquery

↓

Continue...
```

---

## Business Scenario

Imagine the HR Manager asks:

> Show employees earning more than the average salary of their own department.

Notice the difference.

Not the overall company average.

Instead:

- Sales employees compare with Sales average
- HR employees compare with HR average
- IT employees compare with IT average

Each employee requires a different average.

---

## AdventureWorks Tables

```
HumanResources.Employee

HumanResources.EmployeeDepartmentHistory

HumanResources.EmployeePayHistory
```

---

## SQL Example

```sql
SELECT e.BusinessEntityID,
       eph.Rate
FROM HumanResources.Employee e
JOIN HumanResources.EmployeePayHistory eph
    ON e.BusinessEntityID = eph.BusinessEntityID
WHERE eph.Rate >
(
    SELECT AVG(eph2.Rate)
    FROM HumanResources.EmployeePayHistory eph2
    WHERE eph2.BusinessEntityID = e.BusinessEntityID
);
```

> **Note:** This is a simplified demonstration of a correlated subquery. In a production AdventureWorks query, you would typically correlate on department (via `EmployeeDepartmentHistory`) or another grouping attribute rather than `BusinessEntityID`, which usually has one current pay rate.

---

## Real Business Example

Find customers whose total purchases exceed the average purchases within their sales territory.

```sql
SELECT c.CustomerID
FROM Sales.Customer c
WHERE
(
    SELECT SUM(TotalDue)
    FROM Sales.SalesOrderHeader s
    WHERE s.CustomerID = c.CustomerID
)
>
(
    SELECT AVG(CustomerTotal)
    FROM
    (
        SELECT CustomerID,
               SUM(TotalDue) AS CustomerTotal
        FROM Sales.SalesOrderHeader
        GROUP BY CustomerID
    ) x
);
```

---

## Business Use Cases

| Industry | Scenario |
|-----------|----------|
| Retail | Product price vs category average |
| Banking | Customer balance vs branch average |
| Hospital | Patient age vs department average |
| HR | Salary vs department average |
| Education | Student marks vs class average |

---

## When to Use

Use a Correlated Subquery when:

- Each row needs its own calculation
- Comparing rows with their own group
- Comparing categories individually
- Department-level analysis
- Territory-level analysis

---

## Advantages

- Flexible
- Powerful
- Solves row-specific business problems

---

## Disadvantages

- Executes many times
- Can become slow on large tables
- Harder to read

---

# 3. Common Table Expression (CTE)

## Definition

A **CTE (Common Table Expression)** is a temporary named result set that exists only for the duration of a single SQL statement.

Think of it as a temporary, readable view used immediately.

---

## Syntax

```sql
WITH SalesCTE AS
(
    SELECT ...
)
SELECT *
FROM SalesCTE;
```

---

## Execution Flow

```text
Create Temporary Result

↓

Store as CTE

↓

Main Query Uses CTE
```

---

## Business Scenario

The CEO asks:

> Show the Top 10 Salespeople along with total sales, ranking, and previous year's sales.

Without a CTE:

- Multiple nested queries
- Difficult to understand
- Hard to maintain

With a CTE:

- Break the problem into logical steps
- Easier to debug
- Easier to extend

---

## AdventureWorks Tables

```
Sales.SalesOrderHeader

Sales.SalesPerson
```

---

## SQL Example

```sql
WITH SalesSummary AS
(
    SELECT SalesPersonID,
           SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    GROUP BY SalesPersonID
)
SELECT *
FROM SalesSummary
WHERE TotalSales > 1000000;
```

---

## Another Example

Top Selling Products

```sql
WITH ProductSales AS
(
    SELECT ProductID,
           SUM(OrderQty) AS QuantitySold
    FROM Sales.SalesOrderDetail
    GROUP BY ProductID
)
SELECT TOP (5) *
FROM ProductSales
ORDER BY QuantitySold DESC;
```

---

# Recursive CTE

AdventureWorks stores employee-manager relationships.

Recursive CTEs can build an organizational hierarchy.

```text
CEO

↓

Vice President

↓

Manager

↓

Supervisor

↓

Employee
```

---

## Recursive CTE Example

```sql
WITH EmployeeHierarchy AS
(
    SELECT BusinessEntityID,
           OrganizationNode,
           OrganizationLevel
    FROM HumanResources.Employee
    WHERE OrganizationLevel = 0

    UNION ALL

    SELECT e.BusinessEntityID,
           e.OrganizationNode,
           e.OrganizationLevel
    FROM HumanResources.Employee e
    INNER JOIN EmployeeHierarchy eh
        ON e.OrganizationNode.GetAncestor(1) = eh.OrganizationNode
)
SELECT *
FROM EmployeeHierarchy;
```

---

## Business Use Cases

| Industry | Scenario |
|-----------|----------|
| Retail | Sales summaries |
| Banking | Monthly reports |
| HR | Organization hierarchy |
| Manufacturing | Product hierarchy |
| Logistics | Shipment tracking |
| Healthcare | Patient treatment flow |

---

## Advantages

- Highly readable
- Easy to debug
- Easy to maintain
- Ideal for large reports
- Supports recursion

---

## Disadvantages

- Scope limited to one SQL statement
- Not intended as a permanent object

---

# Side-by-Side Business Comparison

## Subquery

**Question**

> Which products cost more than the average product price?

```text
Average Price

↓

Compare All Products
```

---

## Correlated Subquery

**Question**

> Which products cost more than the average price of their own category?

```text
Laptop

↓

Laptop Average

Phone

↓

Phone Average

Shoes

↓

Shoes Average
```

---

## CTE

**Question**

> Generate a Sales Dashboard

```text
Sales Data

↓

Aggregate

↓

Rank

↓

Filter

↓

Final Report
```

---

# Feature Comparison

| Feature | Subquery | Correlated Subquery | CTE |
|----------|----------|---------------------|-----|
| Readability | ⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ |
| Performance | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ |
| Maintenance | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Best for Reports | ⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ |
| Best for Calculations | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Supports Recursion | ❌ | ❌ | ✅ |

---

# Interview Questions

1. What is a Subquery?
2. What is a Correlated Subquery?
3. How does a Correlated Subquery differ from a normal Subquery?
4. What is a Common Table Expression (CTE)?
5. When would you choose a CTE over a Subquery?
6. What are the advantages of CTEs?
7. What is a Recursive CTE?
8. Can a CTE improve readability?
9. Why can Correlated Subqueries become slow?
10. How would you rewrite a Correlated Subquery using a JOIN or a Window Function?

---

# Summary

| Situation | Best Choice | Reason |
|-----------|-------------|--------|
| Compare against one overall value | Subquery | Executes once and is simple |
| Compare each row against its own group's value | Correlated Subquery | Outer row drives the inner calculation |
| Break a complex query into logical steps | CTE | Improves readability and maintainability |
| Reuse intermediate results in one statement | CTE | Avoids repeating logic |
| Build organizational or hierarchical reports | Recursive CTE | Supports recursion |

---

# Best Practice

For SQL beginners, teach these concepts in the following order:

1. **Subquery** — Compare with a single calculated value.
2. **Correlated Subquery** — Compare each row with its own group's value.
3. **CTE** — Organize complex logic into readable steps.
4. **Recursive CTE** — Traverse hierarchies such as employees, managers, and bills of materials.

This progression helps learners understand not only the syntax, but also the business reasoning behind each technique.
