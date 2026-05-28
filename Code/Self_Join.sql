USE testdb;
/* =========================================================
   DATABASE SETUP
   ========================================================= */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

/* =========================================================
   INSERT SAMPLE DATA
   ========================================================= */
/* =========================================================
   INSERT INTO CUSTOMERS
   ========================================================= */
 
INSERT INTO customers
(
    customer_id,
    customer_name,
    city,
    country
)
VALUES
(1,'Arun Kumar','Chennai','India'),
(2,'Priya Sharma','Mumbai','India'),
(3,'Rahul Verma','Delhi','India'),
(4,'Sneha Reddy','Hyderabad','India'),
(5,'Vikram Singh','Pune','India');



/* =========================================================
   INSERT INTO PRODUCTS
   ========================================================= */

INSERT INTO products
(
    product_id,
    product_name,
    category,
    price
)
VALUES
(101,'Laptop','Electronics',75000),
(102,'Mobile','Electronics',30000),
(103,'Chair','Furniture',5000),
(104,'Desk','Furniture',12000),
(105,'Headphones','Electronics',2500);



/* =========================================================
   INSERT INTO ORDERS
   ========================================================= */

INSERT INTO orders
(
    order_id,
    customer_id,
    order_date
)
VALUES
(1001,1,'2025-01-10'),
(1002,2,'2025-01-12'),
(1003,1,'2025-02-15'),
(1004,3,'2025-02-20'),
(1005,4,'2025-03-01'),
(1006,5,'2025-03-10'),
(1007,2,'2025-03-15');



/* =========================================================
   INSERT INTO ORDER_DETAILS
   ========================================================= */

INSERT INTO order_details
(
    order_detail_id,
    order_id,
    product_id,
    quantity
)
VALUES
(1,1001,101,1),
(2,1001,105,2),
(3,1002,102,1),
(4,1002,105,1),
(5,1003,103,4),
(6,1003,104,1),
(7,1004,101,1),
(8,1005,102,2),
(9,1005,105,3),
(10,1006,103,2),
(11,1007,101,1),
(12,1007,102,1);






CREATE TABLE employees1 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT
);
INSERT INTO employees1 VALUES
(1, 'Arun Kumar',   'Management', 120000, NULL),
(2, 'Priya Sharma', 'IT',          80000, 1),
(3, 'Rahul Verma',  'IT',          75000, 2),
(4, 'Sneha Reddy',  'HR',          70000, 1),
(5, 'Vikram Singh', 'HR',          65000, 4),
(6, 'Neha Patel',   'Finance',     90000, 1),
(7, 'Karan Mehta',  'Finance',     60000, 6);

SELECT * FROM  employees1 E;

--Example 1 — Employee and Their Manager

SELECT 
    E.employee_name AS Employee,
    M.employee_name AS Manager
FROM employees1 E
LEFT JOIN employees1 M
ON E.manager_id = M.employee_id;

--Example 2 — Employees Reporting to Arun Kumar

SELECT 
    E.employee_name AS Employee,
    M.employee_name AS Manager
FROM employees1 E
JOIN employees1 M
ON E.manager_id = M.employee_id
WHERE M.employee_name = 'Arun Kumar';


-- Example 3 — Employees Earning More Than Their Managers

SELECT 
    E.employee_name AS Employee,
    E.salary AS Employee_Salary,
    M.employee_name AS Manager,
    M.salary AS Manager_Salary
FROM employees1 E
JOIN employees1 M
ON E.manager_id = M.employee_id
WHERE E.salary > M.salary limit 10;


-- Example 4 — Find Co-workers Reporting to Same Manager

SELECT 
    A.employee_name AS Employee1,
    B.employee_name AS Employee2,
    A.manager_id
FROM employees A
JOIN employees B
ON A.manager_id = B.manager_id
WHERE A.employee_id < B.employee_id;

-- Common Self Join Scenarios
-- 	Scenario	Usage
-- 	Employee → Manager	Organization hierarchy
-- 	Student → Mentor	Academic systems
-- 	Product → Parent Product	E-commerce
-- 	Category → Parent Category	Menu hierarchy
-- 	Friend relationships	Social media
-- 	Comparing rows in same table	Analytics
-- A Self Join is a join where a table is joined with itself using aliases to compare rows within the same table.
