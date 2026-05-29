CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    amount DECIMAL(10, 2),
    order_date DATE
);

INSERT INTO
    orders (
        order_id,
        customer_name,
        product_name,
        quantity,
        amount,
        order_date
    )
VALUES (
        101,
        'Arun Kumar',
        'Laptop',
        1,
        75000.00,
        CURDATE()
    ),
    (
        102,
        'Priya Sharma',
        'Mobile',
        2,
        60000.00,
        CURDATE() - INTERVAL 5 DAY
    ),
    (
        103,
        'Rahul Verma',
        'Headphones',
        1,
        3000.00,
        CURDATE() - INTERVAL 10 DAY
    ),
    (
        104,
        'Sneha Reddy',
        'Monitor',
        1,
        15000.00,
        CURDATE() - INTERVAL 15 DAY
    ),

-- Previous Month
(
    105,
    'Vikram Singh',
    'Keyboard',
    2,
    4000.00,
    CURDATE() - INTERVAL 40 DAY
),
(
    106,
    'Anjali Gupta',
    'Mouse',
    3,
    1500.00,
    CURDATE() - INTERVAL 50 DAY
),

-- Previous Year
(
    107,
    'Karthik Raj',
    'Printer',
    1,
    12000.00,
    CURDATE() - INTERVAL 400 DAY
),
(
    108,
    'Meera Nair',
    'Scanner',
    1,
    8000.00,
    CURDATE() - INTERVAL 500 DAY
);

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    dob DATE,
    hire_date DATE
);

INSERT INTO
    employees
VALUES (
        1,
        'Arun Kumar',
        'IT',
        75000,
        '1995-05-15',
        '2024-01-10'
    ),
    (
        2,
        'Priya Sharma',
        'HR',
        65000,
        '1992-08-22',
        '2023-06-15'
    ),
    (
        3,
        'Rahul Verma',
        'Finance',
        70000,
        '1998-05-25',
        '2025-03-10'
    ),
    (
        4,
        'Sneha Reddy',
        'IT',
        90000,
        '1990-12-18',
        '2022-09-20'
    ),
    (
        5,
        'Vikram Singh',
        'Sales',
        55000,
        '1997-05-29',
        '2026-05-01'
    ),
    (
        6,
        'Anjali Gupta',
        'Marketing',
        60000,
        '1993-03-11',
        '2025-12-01'
    );

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

INSERT INTO
    customers
VALUES (
        1,
        'Arun Kumar',
        'Chennai',
        'India'
    ),
    (
        2,
        'Priya Sharma',
        'Mumbai',
        'India'
    ),
    (
        3,
        'Rahul Verma',
        'Delhi',
        'India'
    ),
    (
        4,
        'Sneha Reddy',
        'Hyderabad',
        'India'
    ),
    (
        5,
        'Vikram Singh',
        'Pune',
        'India'
    ),
    (
        6,
        'Anjali Gupta',
        'Bangalore',
        'India'
    ),
    (
        7,
        'Karthik Raj',
        'Coimbatore',
        'India'
    ),
    (
        8,
        'Meera Nair',
        'Kochi',
        'India'
    );

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO
    products
VALUES (
        1001,
        'Laptop',
        'Electronics',
        75000
    ),
    (
        1002,
        'Mobile',
        'Electronics',
        30000
    ),
    (
        1003,
        'Headphones',
        'Accessories',
        3000
    ),
    (
        1004,
        'Monitor',
        'Electronics',
        15000
    ),
    (
        1005,
        'Keyboard',
        'Accessories',
        2000
    ),
    (
        1006,
        'Mouse',
        'Accessories',
        500
    ),
    (
        1007,
        'Printer',
        'Office',
        12000
    ),
    (
        1008,
        'Scanner',
        'Office',
        8000
    );

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_amount DECIMAL(10, 2),
    sale_date DATETIME
);

INSERT INTO
    sales
VALUES (
        1,
        1001,
        75000,
        '2026-01-10 10:00:00'
    ),
    (
        2,
        1002,
        30000,
        '2026-02-15 12:00:00'
    ),
    (
        3,
        1003,
        3000,
        '2026-03-20 14:00:00'
    ),
    (
        4,
        1004,
        15000,
        '2026-04-05 16:00:00'
    ),
    (
        5,
        1005,
        2000,
        '2026-05-10 11:00:00'
    ),
    (
        6,
        1006,
        500,
        '2026-05-15 13:00:00'
    ),
    (
        7,
        1007,
        12000,
        '2026-05-20 15:00:00'
    ),
    (
        8,
        1008,
        8000,
        '2026-06-01 17:00:00'
    );

-- Common Date Queries You Can Run Immediately
-- Today's Orders
SELECT * FROM orders WHERE DATE(order_date) = CURDATE();

Last 7 Days Orders
SELECT *
FROM orders
WHERE
    order_date >= CURDATE() - INTERVAL 7 DAY;

Current Month Orders
SELECT *
FROM orders
WHERE
    MONTH(order_date) = MONTH(CURDATE())
    AND YEAR(order_date) = YEAR(CURDATE());

Employee Age
SELECT emp_name, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM employees;

Employee Experience
SELECT emp_name, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience
FROM employees;

Birthday This Month
SELECT *
FROM employees
WHERE
    MONTH(dob) = MONTH(CURDATE());

Latest Order Per Customer
SELECT customer_id, MAX(order_date) latest_order
FROM orders
GROUP BY
    customer_id;

Monthly Sales Report
SELECT
    YEAR(sale_date) AS year_no,
    MONTH(sale_date) AS month_no,
    SUM(sale_amount) AS total_sales
FROM sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date);

Quarterly Sales Report
SELECT
    YEAR(sale_date) AS year_no,
    QUARTER(sale_date) AS quarter_no,
    SUM(sale_amount) AS total_sales
FROM sales
GROUP BY
    YEAR(sale_date),
    QUARTER(sale_date);

These four tables (employees, customers, orders, sales) are sufficient to practice nearly every MySQL Date/Time function, filtering, grouping, reporting, joins, CTEs, window functions, and interview scenario related to dates.

/*----------------------------------------------------------
1. CURRENT DATE & TIME
----------------------------------------------------------*/
-- SELECT CURDATE() AS current_date;

-- SELECT CURRENT_DATE() AS current_date;

-- SELECT CURTIME() AS current_time;
-- SELECT CURRENT_TIME() AS current_time;

SELECT NOW() AS current_datetime;

SELECT CURRENT_TIMESTAMP() AS current_datetime;

SELECT SYSDATE() AS system_datetime;

/*----------------------------------------------------------
2. EXTRACT DATE PARTS
----------------------------------------------------------*/
SELECT
    YEAR('2026-05-29') AS year_val,
    MONTH('2026-05-29') AS month_val,
    DAY('2026-05-29') AS day_val,
    QUARTER('2026-05-29') AS quarter_val,
    WEEK('2026-05-29') AS week_val,
    WEEKDAY('2026-05-29') AS weekday_num,
    DAYNAME('2026-05-29') AS day_name,
    MONTHNAME('2026-05-29') AS month_name,
    DAYOFMONTH('2026-05-29') AS day_of_month,
    DAYOFYEAR('2026-05-29') AS day_of_year,
    DAYOFWEEK('2026-05-29') AS day_of_week;

/*----------------------------------------------------------
3. EXTRACT TIME PARTS
----------------------------------------------------------*/
SELECT
    HOUR('2026-05-29 15:30:45') AS hour_val,
    MINUTE('2026-05-29 15:30:45') AS minute_val,
    SECOND('2026-05-29 15:30:45') AS second_val,
    MICROSECOND('2026-05-29 15:30:45.123456') AS microsecond_val;

/*----------------------------------------------------------
4. DATE_FORMAT()
----------------------------------------------------------*/
SELECT DATE_FORMAT(NOW(), '%d-%m-%Y') AS dd_mm_yyyy;

SELECT DATE_FORMAT(NOW(), '%d/%m/%Y') AS slash_format;

SELECT DATE_FORMAT(NOW(), '%M %d, %Y') AS month_format;

SELECT DATE_FORMAT(NOW(), '%W') AS day_name;

SELECT DATE_FORMAT(NOW(), '%h:%i:%s %p') AS time_12hr;

-- FORMAT REFERENCE
-- %Y = 2026
-- %y = 26
-- %m = 05
-- %M = May
-- %d = 29
-- %W = Friday
-- %H = 15
-- %h = 03
-- %i = Minutes
-- %s = Seconds
-- %p = AM/PM

/*----------------------------------------------------------
5. DATE ADD
----------------------------------------------------------*/
SELECT DATE_ADD(CURDATE(), INTERVAL 5 DAY);

SELECT DATE_ADD(CURDATE(), INTERVAL 2 WEEK);

SELECT DATE_ADD(CURDATE(), INTERVAL 2 MONTH);

SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);

SELECT DATE_ADD(NOW(), INTERVAL 10 HOUR);

SELECT DATE_ADD(NOW(), INTERVAL 30 MINUTE);

SELECT DATE_ADD(NOW(), INTERVAL 45 SECOND);

/*----------------------------------------------------------
6. DATE SUBTRACT
----------------------------------------------------------*/
SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY);

SELECT DATE_SUB(CURDATE(), INTERVAL 2 WEEK);

SELECT DATE_SUB(CURDATE(), INTERVAL 2 MONTH);

SELECT DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT DATE_SUB(NOW(), INTERVAL 10 HOUR);

SELECT DATE_SUB(NOW(), INTERVAL 30 MINUTE);

/*----------------------------------------------------------
7. DATE DIFFERENCE
----------------------------------------------------------*/
SELECT DATEDIFF('2026-12-31', '2026-05-29') AS days_diff;

/*----------------------------------------------------------
8. TIMESTAMP DIFFERENCE
----------------------------------------------------------*/
SELECT TIMESTAMPDIFF(YEAR, '2015-01-01', CURDATE()) AS years_diff;

SELECT TIMESTAMPDIFF(
        MONTH, '2025-01-01', CURDATE()
    ) AS months_diff;

SELECT TIMESTAMPDIFF(DAY, '2025-01-01', CURDATE()) AS days_diff;

SELECT TIMESTAMPDIFF(
        HOUR, '2026-05-28 10:00:00', NOW()
    ) AS hours_diff;

SELECT TIMESTAMPDIFF(
        MINUTE, '2026-05-28 10:00:00', NOW()
    ) AS minutes_diff;

/*----------------------------------------------------------
9. LAST DAY OF MONTH
----------------------------------------------------------*/
SELECT LAST_DAY('2026-05-15');

/*----------------------------------------------------------
10. MAKE DATE
----------------------------------------------------------*/
SELECT MAKEDATE(2026, 150);

/*----------------------------------------------------------
11. STRING TO DATE
----------------------------------------------------------*/
SELECT STR_TO_DATE('29-05-2026', '%d-%m-%Y');

SELECT STR_TO_DATE('05/29/2026', '%m/%d/%Y');

/*----------------------------------------------------------
12. EXTRACT DATE ONLY
----------------------------------------------------------*/
SELECT DATE(NOW());

/*----------------------------------------------------------
13. EXTRACT TIME ONLY
----------------------------------------------------------*/
SELECT TIME(NOW());

/*----------------------------------------------------------
14. UNIX TIMESTAMP
----------------------------------------------------------*/
SELECT UNIX_TIMESTAMP();

SELECT UNIX_TIMESTAMP('2026-05-29 15:30:45');

/*----------------------------------------------------------
15. FROM UNIX TIMESTAMP
----------------------------------------------------------*/
SELECT FROM_UNIXTIME(1780050000);

/*----------------------------------------------------------
16. TIME DIFFERENCE
----------------------------------------------------------*/
SELECT TIMEDIFF('18:00:00', '09:30:00');

/*----------------------------------------------------------
17. ADD TIME
----------------------------------------------------------*/
SELECT ADDTIME('10:00:00', '02:30:00');

/*----------------------------------------------------------
18. SUBTRACT TIME
----------------------------------------------------------*/
SELECT SUBTIME('10:00:00', '02:00:00');

/*----------------------------------------------------------
19. FIRST DAY OF CURRENT MONTH
----------------------------------------------------------*/
SELECT DATE_FORMAT(CURDATE(), '%Y-%m-01');

/*----------------------------------------------------------
20. LAST DAY OF CURRENT MONTH
----------------------------------------------------------*/
SELECT LAST_DAY(CURDATE());

/*----------------------------------------------------------
21. FIRST DAY OF CURRENT YEAR
----------------------------------------------------------*/
SELECT MAKEDATE(YEAR(CURDATE()), 1);

/*----------------------------------------------------------
22. DATE COMPARISON EXAMPLES
----------------------------------------------------------*/

-- Today
SELECT * FROM orders WHERE DATE(order_date) = CURDATE();

-- Yesterday
SELECT *
FROM orders
WHERE
    DATE(order_date) = CURDATE() - INTERVAL 1 DAY;

-- Last 7 Days
SELECT * FROM orders WHERE order_date >= CURDATE() - INTERVAL 7 DAY;

-- Last 30 Days
SELECT * FROM orders WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

-- Current Month
SELECT *
FROM orders
WHERE
    MONTH(order_date) = MONTH(CURDATE())
    AND YEAR(order_date) = YEAR(CURDATE());

-- Current Year
SELECT * FROM orders WHERE YEAR(order_date) = YEAR(CURDATE());

-- Between Dates
SELECT *
FROM orders
WHERE
    order_date BETWEEN '2026-01-01' AND '2026-12-31';

/*----------------------------------------------------------
23. AGE CALCULATION
----------------------------------------------------------*/
SELECT emp_name, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM employees;

/*----------------------------------------------------------
24. EXPERIENCE CALCULATION
----------------------------------------------------------*/
SELECT emp_name, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience
FROM employees;

/*----------------------------------------------------------
25. CURRENT WEEK RECORDS
----------------------------------------------------------*/
SELECT *
FROM orders
WHERE
    YEARWEEK(order_date) = YEARWEEK(CURDATE());

/*----------------------------------------------------------
26. CURRENT MONTH RECORDS
----------------------------------------------------------*/
SELECT *
FROM orders
WHERE
    MONTH(order_date) = MONTH(CURDATE())
    AND YEAR(order_date) = YEAR(CURDATE());

/*----------------------------------------------------------
27. CURRENT QUARTER RECORDS
----------------------------------------------------------*/
SELECT *
FROM orders
WHERE
    QUARTER(order_date) = QUARTER(CURDATE())
    AND YEAR(order_date) = YEAR(CURDATE());

/*----------------------------------------------------------
28. BIRTHDAY THIS MONTH
----------------------------------------------------------*/
SELECT * FROM employees WHERE MONTH(dob) = MONTH(CURDATE());

/*----------------------------------------------------------
29. RECORDS OLDER THAN 1 YEAR
----------------------------------------------------------*/
SELECT * FROM orders WHERE order_date < CURDATE() - INTERVAL 1 YEAR;

/*----------------------------------------------------------
30. LATEST RECORD
----------------------------------------------------------*/
SELECT * FROM orders ORDER BY order_date DESC LIMIT 1;

/*----------------------------------------------------------
31. LATEST RECORD PER CUSTOMER
----------------------------------------------------------*/
SELECT customer_id, MAX(order_date) AS latest_order
FROM orders
GROUP BY
    customer_id;

/*----------------------------------------------------------
32. DATE + GROUP BY
----------------------------------------------------------*/
SELECT DATE(order_date) AS order_day, COUNT(*) AS total_orders
FROM orders
GROUP BY
    DATE(order_date);

/*----------------------------------------------------------
33. MONTHLY REPORT
----------------------------------------------------------*/
SELECT
    YEAR(order_date) AS year_no,
    MONTH(order_date) AS month_no,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);

/*----------------------------------------------------------
34. HOURLY REPORT
----------------------------------------------------------*/
SELECT HOUR(order_date) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY
    HOUR(order_date);

/*----------------------------------------------------------
35. DATE FUNCTIONS MOST ASKED IN INTERVIEWS
----------------------------------------------------------

NOW()
CURDATE()
CURTIME()

DATE()
TIME()

YEAR()
MONTH()
DAY()

DAYNAME()
MONTHNAME()

DATE_ADD()
DATE_SUB()

DATEDIFF()
TIMESTAMPDIFF()

DATE_FORMAT()
STR_TO_DATE()

LAST_DAY()

UNIX_TIMESTAMP()
FROM_UNIXTIME()

YEARWEEK()
QUARTER()

TIMEDIFF()
ADDTIME()
SUBTIME()

----------------------------------------------------------*/
