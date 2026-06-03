Snowflake Lab: ETL
Goal: Load a CSV file into a Snowflake table

Step-by-Step Instructions
1. Prepare the CSV file 
Open Notepad → paste the text below → save the file as employees.csv on your Desktop.
EMPLOYEE_ID,FIRST_NAME,DEPARTMENT,SALARY,START_DATE
101,Aisha,Marketing,75000,2025-01-10
102,Ravi,Engineering,95000,2025-02-15
103,Sofia,HR,68000,2025-03-01
104,Li,Finance,82000,2025-03-20
105,Omar,Sales,71000,2025-04-05

2. Log in to Snowflake and create a quick table
1. Go to https://app.snowflake.com and log in  
2. Left sidebar → Worksheets → + Worksheet
3. Copy-paste and run this once (this creates a fresh table for today’s lab):
CREATE OR REPLACE TABLE EMPLOYEES (
  EMPLOYEE_ID INT,
  FIRST_NAME STRING,
  DEPARTMENT STRING,
  SALARY NUMBER,
  START_DATE DATE
);

3. Open the table in the UI
- Left sidebar → Databases
- Expand your account → SNOWFLAKE_SAMPLE_DATA is not needed – instead:  
 → Click + Database at the top if you don’t see one → name it CSV_LAB → Create  
 → Expand CSV_LAB → PUBLIC → Tables 
 → Click the EMPLOYEES table you just created
4. Start the Load Data wizard 
Top-right corner → big blue button Load Data
5. Follow the wizard

6. Success 
You will see a green message instantly:  
Load completed successfully – 5 rows loaded

7. View your data (no SQL needed!) 
Stay on the same screen → click the Data Preview tab (or refresh)  
8. Bonus: Quick SQL check (optional)
Go back to your worksheet and run:
SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID;

Clean-up (optional)
DROP DATABASE IF EXISTS CSV_LAB;

