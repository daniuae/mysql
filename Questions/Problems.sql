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

INSERT INTO customers VALUES
(1,'Arun Kumar','Chennai','India'),
(2,'Priya Sharma','Mumbai','India'),
(3,'Rahul Verma','Delhi','India'),
(4,'Sneha Reddy','Hyderabad','India'),
(5,'Vikram Singh','Pune','India');

INSERT INTO products VALUES
(101,'Laptop','Electronics',75000),
(102,'Mobile','Electronics',30000),
(103,'Chair','Furniture',5000),
(104,'Desk','Furniture',12000),
(105,'Headphones','Electronics',2500);

INSERT INTO orders VALUES
(1001,1,'2025-01-10'),
(1002,2,'2025-01-12'),
(1003,1,'2025-02-15'),
(1004,3,'2025-02-20'),
(1005,4,'2025-03-01'),
(1006,5,'2025-03-10'),
(1007,2,'2025-03-15');

INSERT INTO order_details VALUES
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



/* =========================================================
   PROBLEM 1
   =========================================================
   Find the TOP 3 customers who spent the highest amount.

   REQUIREMENTS:
   - Use JOINS
   - Use AGGREGATE FUNCTIONS
   - Use GROUP BY
   - Use ORDER BY
   - Calculate total spending
*/

-- EXPECTED OUTPUT FORMAT

/*
+-------------+---------------+--------------+
| customer_id | customer_name | total_amount |
+-------------+---------------+--------------+
| 2           | Priya Sharma  | 107500       |
| 1           | Arun Kumar    | 104000       |
| 4           | Sneha Reddy   | 67500        |
+-------------+---------------+--------------+
*/



/* =========================================================
   PROBLEM 2
   =========================================================
   Find customers whose total purchase amount is
   greater than the average customer spending.

   REQUIREMENTS:
   - Use SUBQUERY
   - Use AGGREGATE FUNCTIONS
   - Use HAVING
   - Use JOINS
*/

-- EXPECTED OUTPUT FORMAT

/*
+-------------+---------------+--------------+
| customer_id | customer_name | total_amount |
+-------------+---------------+--------------+
| 1           | Arun Kumar    | 104000       |
| 2           | Priya Sharma  | 107500       |
+-------------+---------------+--------------+
*/



/* =========================================================
   PROBLEM 3
   =========================================================
   Find the latest order placed by each customer.

   REQUIREMENTS:
   - Use WINDOW FUNCTION
   - Use ROW_NUMBER()
   - Use PARTITION BY
*/

-- EXPECTED OUTPUT FORMAT

/*
+-------------+---------------+----------+------------+
| customer_id | customer_name | order_id | order_date |
+-------------+---------------+----------+------------+
| 1           | Arun Kumar    | 1003     | 2025-02-15 |
| 2           | Priya Sharma  | 1007     | 2025-03-15 |
| 3           | Rahul Verma   | 1004     | 2025-02-20 |
| 4           | Sneha Reddy   | 1005     | 2025-03-01 |
| 5           | Vikram Singh  | 1006     | 2025-03-10 |
+-------------+---------------+----------+------------+
*/



/* =========================================================
   PROBLEM 4
   =========================================================
   Find product category-wise sales amount.

   REQUIREMENTS:
   - Use GROUP BY
   - Use SUM()
   - Use ORDER BY
   - Use MULTIPLE JOINS
*/

-- EXPECTED OUTPUT FORMAT

/*
+-------------+--------------+
| category    | total_sales  |
+-------------+--------------+
| Electronics | 250000       |
| Furniture   | 44000        |
+-------------+--------------+
*/



/* =========================================================
   PROBLEM 5
   =========================================================
   Find the second highest spending customer.

   REQUIREMENTS:
   - Use DENSE_RANK()
   - Use WINDOW FUNCTION
   - Use SUBQUERY/CTE
*/

-- EXPECTED OUTPUT FORMAT

/*
+-------------+---------------+--------------+
| customer_id | customer_name | total_amount |
+-------------+---------------+--------------+
| 1           | Arun Kumar    | 104000       |
+-------------+---------------+--------------+
*/












/* =========================================================
   SOLUTION 1
   TOP 3 CUSTOMERS BY TOTAL SPENDING
   ========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * od.quantity) AS total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_amount DESC
LIMIT 3;


/*
EXPLANATION:
1. JOIN combines all related tables.
2. SUM() calculates total spending.
3. GROUP BY creates customer-wise summary.
4. ORDER BY sorts highest spender first.
5. LIMIT 3 returns top 3 customers.
*/



/* =========================================================
   SOLUTION 2
   CUSTOMERS SPENDING ABOVE AVERAGE
   ========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * od.quantity) AS total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(p.price * od.quantity) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            SUM(p.price * od.quantity) AS customer_total
        FROM orders o
        JOIN order_details od
            ON o.order_id = od.order_id
        JOIN products p
            ON od.product_id = p.product_id
        GROUP BY o.customer_id
    ) avg_table
);


/*
EXPLANATION:
1. Inner subquery calculates each customer's spending.
2. Outer AVG() finds average spending.
3. HAVING filters customers greater than average.
4. HAVING is used because aggregate function is involved.
*/



/* =========================================================
   SOLUTION 3
   LATEST ORDER FOR EACH CUSTOMER
   ========================================================= */

SELECT
    customer_id,
    customer_name,
    order_id,
    order_date
FROM
(
    SELECT
        c.customer_id,
        c.customer_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER
        (
            PARTITION BY c.customer_id
            ORDER BY o.order_date DESC
        ) AS rn
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
) x
WHERE rn = 1;


/*
EXPLANATION:
1. ROW_NUMBER() gives ranking inside each customer group.
2. PARTITION BY resets numbering for each customer.
3. ORDER BY DESC gives latest order rank = 1.
4. Outer query filters only latest order.
*/



/* =========================================================
   SOLUTION 4
   CATEGORY-WISE SALES
   ========================================================= */

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
JOIN orders o
    ON od.order_id = o.order_id
GROUP BY p.category
ORDER BY total_sales DESC;


/*
EXPLANATION:
1. JOIN connects products and order tables.
2. SUM() calculates category sales.
3. GROUP BY creates category summary.
4. ORDER BY sorts highest sales category first.
*/



/* =========================================================
   SOLUTION 5
   SECOND HIGHEST SPENDING CUSTOMER
   ========================================================= */

WITH customer_sales AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * od.quantity) AS total_amount
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.customer_name
),
ranked_sales AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               ORDER BY total_amount DESC
           ) AS ranking
    FROM customer_sales
)

SELECT
    customer_id,
    customer_name,
    total_amount
FROM ranked_sales
WHERE ranking = 2;


/*
EXPLANATION:
1. First CTE calculates customer sales.
2. DENSE_RANK() ranks spending amounts.
3. Highest spender gets rank 1.
4. Second highest gets rank 2.
5. Final query filters rank = 2.
*/
