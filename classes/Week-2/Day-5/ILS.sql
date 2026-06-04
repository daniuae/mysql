Snowflake: End-to-End Analysis

What You Will Do:
1. Load a real CSV file  
2. Explore & clean data 
3. Write 5 easy SQL queries  
4. Build a dashboard  
Step-by-Step :
Step 1 – Create Your Lab Database & Table 
Open a new worksheet and run this once:
CREATE OR REPLACE DATABASE COFFEE_LAB;
CREATE OR REPLACE SCHEMA DATA;
USE DATABASE COFFEE_LAB;
USE SCHEMA DATA;

CREATE OR REPLACE TABLE SALES (
  SALE_DATE DATE,
  STORE STRING,
  PRODUCT STRING,
  QUANTITY INT,
  PRICE NUMBER(10,2),
  CUSTOMER_AGE INT
);

Step 2 – Load Real Data
1. Create CSV
  (or copy-paste below into Notepad → save)
SALE_DATE,STORE,PRODUCT,QUANTITY,PRICE,CUSTOMER_AGE
2025-01-01,London,Latte,2,4.50,28
2025-01-01,Paris,Espresso,1,3.20,35
2025-01-02,London,Cappuccino,3,4.80,42
2025-01-02,Berlin,Latte,1,4.20,19
2025-01-03,Paris,Americano,2,3.50,55
2025-01-03,London,Latte,4,4.50,31
2025-01-04,Berlin,Cappuccino,2,4.60,27
2025-01-05,Paris,Latte,3,4.30,38

2. In Snowflake → Left sidebar → Databases → COFFEE_LAB → DATA → Tables  
  → Click table SALES → top-right blue button Load Data 
  → Follow wizard:  
  - Warehouse → COMPUTE_WH → Next  
  - Drag & drop coffee_sales.csv → Next  
  - Format → CSV + check “First row contains column names” → Next  
  - Load → Append → Load  
  Green message: “8 rows loaded”
Step 3 – Explore & Clean with Clicks
Click the SALES table → Data Preview tab  
→ Click column CUSTOMER_AGE → Profile  
You instantly see min=19, max=55, average, etc. – no SQL
Step 5 – Your First Analysis Queries
Run one by one in a worksheet:
Total sales amount
SELECT SUM(QUANTITY * PRICE) AS TOTAL_REVENUE FROM SALES;

Sales by product
SELECT PRODUCT, SUM(QUANTITY * PRICE) AS REVENUE
FROM SALES
GROUP BY PRODUCT
ORDER BY REVENUE DESC;

Sales by store
SELECT STORE, COUNT(*) AS TRANSACTIONS, SUM(QUANTITY * PRICE) AS REVENUE
FROM SALES
GROUP BY STORE
ORDER BY REVENUE DESC;

Average customer age per store
SELECT STORE, ROUND(AVG(CUSTOMER_AGE)) AS AVG_AGE
FROM SALES
GROUP BY STORE;

Best selling day
SELECT SALE_DATE, SUM(QUANTITY * PRICE) AS DAILY_SALES
FROM SALES
GROUP BY SALE_DATE
ORDER BY DAILY_SALES DESC
LIMIT 1;

Step 4 – Build a Dashboard with Drag & Drop
1. Left sidebar → Dashboards → + Dashboard → name it “Coffee Sales Dashboard”  
2. Click + Tile → Choose Table → SALES  
3. Add these tiles by clicking + Tile → Chart:

4. Drag corners to resize → click Done
Step 5 – Share Your Dashboard 
Click Share → Enable sharing → Copy link  
Anyone with the link (even without Snowflake account) can view it.

