-- Scalar & Table-Valued UDFs

-- Objective: Build and test scalar and table-valued UDFs for modular SQL logic.

-- Steps
-- Create or reuse SalesDB.
-- Ensure Orders table exists with data.
-- Create scalar UDF for tax calculation:
-- CREATE FUNCTION fn_GetTax(@Amount DECIMAL(10,2))
-- RETURNS DECIMAL(10,2)
-- AS
-- BEGIN
--     RETURN @Amount * 0.1;
-- END;
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ProductName VARCHAR(100),
    Amount DECIMAL(10, 2),
    OrderDate DATE
);

INSERT INTO
    Orders (
        CustomerName,
        ProductName,
        Amount,
        OrderDate
    )
VALUES (
        'Ravi Kumar',
        'Laptop',
        50000,
        '2025-01-05'
    ),
    (
        'Priya Sharma',
        'Mouse',
        800,
        '2025-01-06'
    ),
    (
        'Amit Singh',
        'Keyboard',
        1500,
        '2025-01-07'
    ),
    (
        'Sneha Gupta',
        'Monitor',
        12000,
        '2025-01-08'
    ),
    (
        'Rahul Verma',
        'Headphones',
        2500,
        '2025-01-09'
    ),
    (
        'Anjali Rao',
        'Tablet',
        18000,
        '2025-01-10'
    ),
    (
        'Karan Mehta',
        'Printer',
        7000,
        '2025-01-11'
    ),
    (
        'Pooja Patel',
        'Camera',
        35000,
        '2025-01-12'
    ),
    (
        'Vikram Nair',
        'SSD',
        4500,
        '2025-01-13'
    ),
    (
        'Neha Joshi',
        'Smartphone',
        28000,
        '2025-01-14'
    );

SELECT * FROM Orders;

DELIMITER $$

-- CREATE FUNCTION fn_GetTax
-- (
--     Amount DECIMAL(10,2)
-- )
-- RETURNS DECIMAL(10,2)
-- DETERMINISTIC
-- BEGIN

--     RETURN Amount * 0.10;

-- END;

CREATE FUNCTION fn_GetTax(Amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN Amount * 0.10;
END;

SELECT OrderID, Amount, fn_GetTax (Amount) AS Tax FROM Orders;
-- Test the function:

-- SELECT OrderID, Amount, dbo.fn_GetTax (Amount) AS Tax FROM Orders;

-- Add another scalar UDF for discount:

-- Scalar Function - Discount
-- 5% discount if Amount > 1000
-- DELIMITER $$

CREATE FUNCTION fn_GetDiscount
(
    Amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE DiscountAmt DECIMAL(10,2);

    IF Amount > 1000 THEN
        SET DiscountAmt = Amount * 0.05;
    ELSE
        SET DiscountAmt = 0;
    END IF;

    RETURN DiscountAmt;

END;

SELECT fn_GetDiscount (1500);

-- DELIMITER;
-- CREATE FUNCTION fn_GetDiscount(@Amount DECIMAL(10,2))
-- RETURNS DECIMAL(10,2)
-- AS
-- BEGIN
--     RETURN CASE WHEN @Amount>1000 THEN @Amount*0.05 ELSE 0 END;
-- END;

-- Validate output:

-- SELECT dbo.fn_GetDiscount (1500);

-- Create table-valued UDF:

-- CREATE FUNCTION fn_FilterOrders(@MinAmount DECIMAL(10,2))
-- RETURNS TABLE
-- AS
-- RETURN
-- (SELECT * FROM Orders WHERE Amount>@MinAmount);

-- Test table-valued UDF:

-- SELECT * FROM dbo.fn_FilterOrders (700);

-- Add column Tax via scalar UDF in result:

-- SELECT OrderID, Amount, dbo.fn_GetTax (Amount) AS Tax
-- FROM dbo.fn_FilterOrders (500);

-- Combine tax and discount calculations.
-- Modify scalar UDF to use variable tax slabs.
-- Create a multi-statement table-valued UDF for category grouping.
-- Insert logs to verify execution sequence.
-- Check function determinism with SCHEMABINDING.
-- Validate performance using SET STATISTICS TIME ON.
--  Expected Outcome:

-- Ability to modularize logic with reusable functions for calculations and filtered queries.\

-- Apply Discount Function
SELECT
    OrderID,
    Amount,
    fn_GetDiscount (Amount) AS Discount
FROM Orders;
-- Step 6: Combine Tax and Discount
SELECT
    OrderID,
    Amount,
    fn_GetTax (Amount) AS Tax,
    fn_GetDiscount (Amount) AS Discount,
    Amount + fn_GetTax (Amount) - fn_GetDiscount (Amount) AS FinalAmount
FROM Orders;
-- Step 7: Simulate Table-Valued Function Using View

-- MySQL does not support:

-- RETURNS TABLE

-- Create a View instead:

CREATE VIEW vw_FilterOrders AS SELECT * FROM Orders;

-- Filter Orders Above 700
SELECT * FROM vw_FilterOrders WHERE Amount > 700;
-- Equivalent of fn_FilterOrders(700)
SELECT * FROM Orders WHERE Amount > 700;
-- Step 8: Tax on Filtered Orders

-- Equivalent to:

SELECT OrderID, Amount, dbo.fn_GetTax (Amount)
FROM dbo.fn_FilterOrders (500);

-- MySQL:

SELECT OrderID, Amount, fn_GetTax (Amount) AS Tax
FROM Orders
WHERE
    Amount > 500;

-- Step 9: Variable Tax Slabs
-- Business Requirement
-- Amount	Tax
-- <=1000	5%
-- <=10000	10%
-- >10000	18%
-- DELIMITER $$

CREATE FUNCTION fn_GetTaxSlab
(
    Amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE Tax DECIMAL(10,2);

    IF Amount <= 1000 THEN
        SET Tax = Amount * 0.05;

    ELSEIF Amount <= 10000 THEN
        SET Tax = Amount * 0.10;

    ELSE
        SET Tax = Amount * 0.18;

    END IF;

    RETURN Tax;

END

-- DELIMITER;

-- Test Tax Slabs
SELECT
    OrderID,
    Amount,
    fn_GetTaxSlab (Amount) AS Tax
FROM Orders;

-- Step 10: Category Grouping Example Add Category Column:

ALTER TABLE Orders ADD Category VARCHAR(50);

-- Update Categories:

UPDATE Orders
SET
    Category = 'Electronics'
WHERE
    ProductName IN (
        'Laptop',
        'Tablet',
        'Camera',
        'Smartphone'
    );

UPDATE Orders
SET
    Category = 'Accessories'
WHERE
    ProductName IN (
        'Mouse',
        'Keyboard',
        'Headphones',
        'SSD'
    );

UPDATE Orders
SET
    Category = 'Peripherals'
WHERE
    ProductName IN ('Printer', 'Monitor');

-- Category Analytics
SELECT
    Category,
    COUNT(*) AS TotalOrders,
    SUM(Amount) AS Revenue,
    AVG(Amount) AS AvgAmount
FROM Orders
GROUP BY
    Category;

-- Interview Questions for Freshers
-- Easy
-- Difference between Function and Procedure?
-- What is a Scalar Function?
-- What is a Deterministic Function?
-- Medium
-- Can a Function update a table in MySQL?
-- Why use functions instead of repeating logic?
-- Advanced
-- Why doesn't MySQL support Table-Valued Functions?
-- When should Views be used instead?
-- Performance impact of scalar functions on large tables?

-- This dataset and scripts are sufficient to demonstrate Scalar Functions, business calculations, reusable logic, and the MySQL alternative to Table-Valued Functions.
