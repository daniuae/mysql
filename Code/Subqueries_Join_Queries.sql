-- Objective: Practice complex join operations in SQL.
-- Summary: This lab introduces learners to advanced SQL joins, including INNER JOIN, LEFT JOIN, and FULL OUTER JOIN. 
-- Learners will practice retrieving and combining data from multiple related tables.
-- Create the tables orders, customers, and products:

/* =========================================================
   SUBQUERIES & NESTED SUBQUERIES - COMPLETE TRAINING SCRIPT
   Database  : AdventureWorks (MySQL Compatible)
   Audience  : Freshers
   Purpose   : Learn all major subquery combinations
   ========================================================= */





/* =========================================================
   COMPLETE SUBQUERY TRAINING SET
   WITH DDL + INSERTS + SUBQUERY EXAMPLES
   Database : MySQL
   Theme    : AdventureWorks Style
   Audience : Freshers
   Notes: Execute the tables and insert scripts first and then execute other scripts.
   ========================================================= */


/* =========================================================
   DROP TABLES
   ========================================================= */

DROP TABLE IF EXISTS sales_order_details;
DROP TABLE IF EXISTS sales_orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS customers;



/* =========================================================
   CREATE TABLES
   ========================================================= */

CREATE TABLE departments
(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    group_name VARCHAR(100)
);

CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    job_title VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2),
    vacation_hours INT,
    sick_leave_hours INT,
    organization_level INT,
    
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    list_price DECIMAL(10,2)
);

CREATE TABLE sales_orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    territory VARCHAR(50),
    total_due DECIMAL(10,2),
    
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE sales_order_details
(
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    order_qty INT,
    line_total DECIMAL(10,2),
    
    FOREIGN KEY (order_id)
    REFERENCES sales_orders(order_id),
    
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);



/* =========================================================
   INSERT INTO DEPARTMENTS
   ========================================================= */

INSERT INTO departments VALUES
(1, 'Production', 'Manufacturing'),
(2, 'Sales', 'Marketing'),
(3, 'HR', 'Administration'),
(4, 'Finance', 'Administration'),
(5, 'IT', 'Technology');



/* =========================================================
   INSERT INTO EMPLOYEES
   ========================================================= */

INSERT INTO employees VALUES
(101, 'Arun Kumar', 'Manager', 1, 85000, 60, 12, 1),
(102, 'Priya Sharma', 'Developer', 5, 65000, 45, 10, 2),
(103, 'Rahul Verma', 'Sales Executive', 2, 55000, 30, 8, 3),
(104, 'Sneha Iyer', 'HR Executive', 3, 50000, 25, 15, 2),
(105, 'Vikram Singh', 'Finance Analyst', 4, 72000, 55, 5, 1),
(106, 'Neha Patel', 'Developer', 5, 62000, 35, 9, 2),
(107, 'Karan Mehta', 'Production Lead', 1, 80000, 70, 7, 1),
(108, 'Divya Nair', 'Sales Manager', 2, 78000, 50, 6, 1);



/* =========================================================
   INSERT INTO CUSTOMERS
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Ramesh Traders', 'India'),
(2, 'Global Mart', 'USA'),
(3, 'City Retail', 'India'),
(4, 'Tech World', 'UK'),
(5, 'Prime Stores', 'USA');



/* =========================================================
   INSERT INTO PRODUCTS
   ========================================================= */

INSERT INTO products VALUES
(1001, 'Laptop', 'Electronics', 80000),
(1002, 'Mobile', 'Electronics', 30000),
(1003, 'Office Chair', 'Furniture', 12000),
(1004, 'Desk', 'Furniture', 15000),
(1005, 'Printer', 'Electronics', 18000),
(1006, 'Tablet', 'Electronics', 25000),
(1007, 'Monitor', 'Electronics', 22000),
(1008, 'Keyboard', 'Accessories', 2000);



/* =========================================================
   INSERT INTO SALES ORDERS
   ========================================================= */

INSERT INTO sales_orders VALUES
(5001, 1, '2025-01-10', 'India', 95000),
(5002, 2, '2025-01-11', 'USA', 120000),
(5003, 3, '2025-01-15', 'India', 45000),
(5004, 4, '2025-01-20', 'UK', 60000),
(5005, 5, '2025-01-25', 'USA', 150000);



/* =========================================================
   INSERT INTO SALES ORDER DETAILS
   ========================================================= */

INSERT INTO sales_order_details VALUES
(1, 5001, 1001, 1, 80000),
(2, 5001, 1008, 5, 10000),
(3, 5002, 1002, 2, 60000),
(4, 5002, 1007, 2, 44000),
(5, 5003, 1003, 2, 24000),
(6, 5003, 1004, 1, 15000),
(7, 5004, 1005, 2, 36000),
(8, 5005, 1001, 1, 80000),
(9, 5005, 1006, 2, 50000);



/* =========================================================
   SUBQUERY EXAMPLES
   ========================================================= */



/* =========================================================
   1. SCALAR SUBQUERY
   ========================================================= */

-- Employees earning more than average salary

SELECT employee_name,
       salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);



/* =========================================================
   2. SUBQUERY IN SELECT
   ========================================================= */

-- Show salary with overall average salary

SELECT employee_name,
       salary,
       (
           SELECT AVG(salary)
           FROM employees
       ) AS average_salary
FROM employees;



/* =========================================================
   3. SUBQUERY IN FROM
   ========================================================= */

-- Derived table example

SELECT *
FROM
(
    SELECT employee_name,
           salary
    FROM employees
) AS emp
WHERE salary > 60000;



/* =========================================================
   4. SINGLE ROW SUBQUERY
   ========================================================= */

-- Employee with highest salary

SELECT employee_name,
       salary
FROM employees
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees
);



/* =========================================================
   5. MULTI ROW SUBQUERY - IN
   ========================================================= */

-- Employees from Administration departments

SELECT employee_name,
       department_id
FROM employees
WHERE department_id IN
(
    SELECT department_id
    FROM departments
    WHERE group_name = 'Administration'
);



/* =========================================================
   6. NOT IN SUBQUERY
   ========================================================= */

-- Employees not in Technology group

SELECT employee_name
FROM employees
WHERE department_id NOT IN
(
    SELECT department_id
    FROM departments
    WHERE group_name = 'Technology'
);



/* =========================================================
   7. EXISTS
   ========================================================= */

-- Customers having orders

SELECT customer_name
FROM customers c
WHERE EXISTS
(
    SELECT 1
    FROM sales_orders so
    WHERE c.customer_id = so.customer_id
);



/* =========================================================
   8. NOT EXISTS
   ========================================================= */

-- Customers without orders

SELECT customer_name
FROM customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales_orders so
    WHERE c.customer_id = so.customer_id
);



/* =========================================================
   9. CORRELATED SUBQUERY
   ========================================================= */

-- Employees earning above department average

SELECT employee_name,
       salary,
       department_id
FROM employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees e2
    WHERE e.department_id = e2.department_id
);



/* =========================================================
   10. EXISTS WITH PRODUCTS
   ========================================================= */

-- Products that were sold

SELECT product_name
FROM products p
WHERE EXISTS
(
    SELECT 1
    FROM sales_order_details sod
    WHERE p.product_id = sod.product_id
);



/* =========================================================
   11. ANY
   ========================================================= */

-- Employees earning more than ANY employee in department 2

SELECT employee_name,
       salary
FROM employees
WHERE salary > ANY
(
    SELECT salary
    FROM employees
    WHERE department_id = 2
);



/* =========================================================
   12. ALL
   ========================================================= */

-- Employees earning more than ALL employees in department 3

SELECT employee_name,
       salary
FROM employees
WHERE salary > ALL
(
    SELECT salary
    FROM employees
    WHERE department_id = 3
);



/* =========================================================
   13. SOME
   ========================================================= */

-- SOME behaves same as ANY

SELECT employee_name,
       salary
FROM employees
WHERE salary > SOME
(
    SELECT salary
    FROM employees
    WHERE department_id = 1
);



/* =========================================================
   14. NESTED SUBQUERY
   ========================================================= */

-- Employees working in Manufacturing group

SELECT employee_name
FROM employees
WHERE department_id IN
(
    SELECT department_id
    FROM departments
    WHERE group_name =
    (
        SELECT group_name
        FROM departments
        WHERE department_name = 'Production'
    )
);



/* =========================================================
   15. MULTIPLE NESTED SUBQUERY
   ========================================================= */

-- Products sold in USA territory

SELECT product_name
FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM sales_order_details
    WHERE order_id IN
    (
        SELECT order_id
        FROM sales_orders
        WHERE territory = 'USA'
    )
);



/* =========================================================
   16. AGGREGATE SUBQUERY
   ========================================================= */

-- Products above average price

SELECT product_name,
       list_price
FROM products
WHERE list_price >
(
    SELECT AVG(list_price)
    FROM products
);



/* =========================================================
   17. GROUP BY SUBQUERY
   ========================================================= */

-- Territories having sales greater than 1 order

SELECT territory,
       COUNT(*) AS total_orders
FROM sales_orders
GROUP BY territory
HAVING COUNT(*) >
(
    SELECT 1
);



/* =========================================================
   18. HAVING WITH SUBQUERY
   ========================================================= */

-- Territories with sales above average sales

SELECT territory,
       SUM(total_due) AS territory_sales
FROM sales_orders
GROUP BY territory
HAVING SUM(total_due) >
(
    SELECT AVG(total_sales)
    FROM
    (
        SELECT SUM(total_due) AS total_sales
        FROM sales_orders
        GROUP BY territory
    ) x
);



/* =========================================================
   19. ORDER BY + LIMIT SUBQUERY
   ========================================================= */

-- Second highest salary

SELECT employee_name,
       salary
FROM employees
WHERE salary =
(
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
);



/* =========================================================
   20. CASE WITH SUBQUERY
   ========================================================= */

-- Salary category

SELECT employee_name,
       salary,
       CASE
           WHEN salary >
                (
                    SELECT AVG(salary)
                    FROM employees
                )
           THEN 'Above Average'
           ELSE 'Below Average'
       END AS salary_category
FROM employees;



/* =========================================================
   21. JOIN + SUBQUERY
   ========================================================= */

-- Employees from Production department

SELECT e.employee_name,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id =
(
    SELECT department_id
    FROM departments
    WHERE department_name = 'Production'
);



/* =========================================================
   22. CORRELATED MAX SUBQUERY
   ========================================================= */

-- Highest paid employee in each department

SELECT employee_name,
       salary,
       department_id
FROM employees e
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees e2
    WHERE e.department_id = e2.department_id
);



/* =========================================================
   23. DELETE USING SUBQUERY
   ========================================================= */

-- Delete low priced products

DELETE FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM
    (
        SELECT product_id
        FROM products
        WHERE list_price < 3000
    ) x
);



/* =========================================================
   24. UPDATE USING SUBQUERY
   ========================================================= */

-- Increase salary below average by 10%

UPDATE employees
SET salary = salary * 1.10
WHERE employee_id IN
(
    SELECT employee_id
    FROM
    (
        SELECT employee_id
        FROM employees
        WHERE salary <
        (
            SELECT AVG(salary)
            FROM employees
        )
    ) x
);



/* =========================================================
   25. INSERT USING SUBQUERY
   ========================================================= */

CREATE TABLE expensive_products
(
    product_id INT,
    product_name VARCHAR(100),
    list_price DECIMAL(10,2)
);

INSERT INTO expensive_products
(
    product_id,
    product_name,
    list_price
)
SELECT product_id,
       product_name,
       list_price
FROM products
WHERE list_price >
(
    SELECT AVG(list_price)
    FROM products
);



/* =========================================================
   26. MULTI COLUMN SUBQUERY
   ========================================================= */

-- Multi-column comparison

SELECT employee_name,
       department_id,
       salary
FROM employees
WHERE (department_id, salary) IN
(
    SELECT department_id,
           MAX(salary)
    FROM employees
    GROUP BY department_id
);



/* =========================================================
   27. DEEP NESTED SUBQUERY
   ========================================================= */

-- Customers who purchased electronics products

SELECT customer_name
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM sales_orders
    WHERE order_id IN
    (
        SELECT order_id
        FROM sales_order_details
        WHERE product_id IN
        (
            SELECT product_id
            FROM products
            WHERE category = 'Electronics'
        )
    )
);



/* =========================================================
   28. JOIN VS SUBQUERY
   ========================================================= */

-- SUBQUERY

SELECT product_name
FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM sales_order_details
);

-- JOIN

SELECT DISTINCT p.product_name
FROM products p
JOIN sales_order_details sod
ON p.product_id = sod.product_id;



/* =========================================================
   29. TOP N USING SUBQUERY
   ========================================================= */

-- Top 3 highest priced products

SELECT product_name,
       list_price
FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM
    (
        SELECT product_id
        FROM products
        ORDER BY list_price DESC
        LIMIT 3
    ) x
);



/* =========================================================
   30. COUNT SUBQUERY
   ========================================================= */

-- Departments having more than 1 employee

SELECT department_name
FROM departments
WHERE department_id IN
(
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 1
);



/* =========================================================
   QUICK REVISION
   =========================================================

   TYPE                         PURPOSE
   ------------------------------------------------
   Scalar Subquery              Returns one value
   Multi-row Subquery           Returns multiple rows
   Correlated Subquery          Depends on outer query
   Nested Subquery              Query inside query
   EXISTS                       Checks existence
   IN                           Matches values
   ANY/SOME                     Compare any value
   ALL                          Compare all values
   Derived Table                Temporary table
   Aggregate Subquery           AVG/MAX/MIN/SUM
   Multi-column Subquery        Multiple column match

   ========================================================= */









   
