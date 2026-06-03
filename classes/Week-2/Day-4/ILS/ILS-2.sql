Snowflake Compute


 Step-by-Step


Step 1 – See the Warehouse You Are Currently Using


1. Look at the top-right corner of Snowflake

   You will see something like: COMPUTE_WH ▼ (XS)  

   This is your current warehouse (the “engine” running your queries).



2. In a worksheet, run this :

SELECT CURRENT_WAREHOUSE(), CURRENT_USER();
 You will see COMPUTE_WH in the results.



Step 2 – Create Your First Own Warehouse 
1. Left sidebar → Admin → Warehouses  

2. Top-right → blue button + Warehouse  



Fill the form exactly like this :









Click Create Warehouse  

You will see a green message: “Warehouse MY_TINY_WH successfully created”



Step 3 – Create a Second Bigger Warehouse 
Repeat the same steps, but use these values:







Click Create Warehouse



Step 4 – Switch Warehouse from the Top Bar 
1. Top-right corner → click the dropdown next to your current warehouse  

2. Choose MY_TINY_WH  

   The bar instantly changes to: MY_TINY_WH ▼ (XS)



Run this again in any worksheet:

SELECT CURRENT_WAREHOUSE();
 Result: MY_TINY_WH



Step 5 Resize:


1. Go back to Admin → Warehouses  

2. Find MY_BIG_WH → click the three dots ⋯ → Edit  

3. Change Size from Small → Large  

4. Click Save



Step 6 – Run a Query on Tiny vs Big Warehouse
We will run a simple “fake big” query to feel the difference.



In a worksheet, run this exact query twice:



This generates ~100 million rows (but runs fast on Snowflake)

SELECT SEQ4() AS N, RAND() AS R
FROM TABLE(GENERATOR(ROWCOUNT => 100000000));
First time (while MY_TINY_WH is selected):



Now switch warehouse (top-right dropdown) → MY_BIG_WH (Large)  

Run the exact same query again:



Step 7 – Suspend a Warehouse to Stop Credits


1. Go to Admin → Warehouses  

2. Find MY_TINY_WH → click three dots ⋯ → Suspend  

   Status changes to “Suspended” and credits stop burning.



Do nothing for 60 seconds → both warehouses auto-suspend (because we set Auto Suspend = 60)



Step 8 – Resume Automatically 
Just run any query again (e.g., SELECT 1;).  

Watch the top bar: the warehouse automatically wakes up in 2–3 seconds and runs your query.



 Summary – What You Learned





