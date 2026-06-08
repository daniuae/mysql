# Retail Sales Data Warehouse Project

## Project Overview

In this project, I built a **Retail Sales Data Warehouse** using **Snowflake** to support business intelligence and analytical reporting. The project involved designing a scalable data warehouse, developing ETL pipelines, performing SQL-based analytics, and creating visual dashboards to generate business insights.

---

## Objectives

* Build a centralized data warehouse for retail sales data.
* Clean and transform raw transactional data.
* Design a dimensional model using a Star Schema.
* Enable efficient analytical querying.
* Visualize key business metrics and trends.

---

## Technologies Used

| Category             | Tools/Technologies  |
| -------------------- | ------------------- |
| Data Warehouse       | Snowflake           |
| Programming Language | Python              |
| Data Processing      | Pandas              |
| SQL Analytics        | Snowflake SQL       |
| Visualization        | Matplotlib, Seaborn |
| Data Modeling        | Star Schema         |

---

## ETL Process

### 1. Data Extraction

Raw sales data was collected from source files containing transactional retail information.

### 2. Data Cleaning & Transformation

Using **Pandas**, the data was cleaned and standardized by:

* Handling missing (NULL) values
* Removing duplicate records
* Correcting inconsistent data formats
* Standardizing date formats
* Validating customer and product information
* Preparing data for dimensional modeling

### Sample Transformation Activities

```python
import pandas as pd

df = pd.read_csv("sales_data.csv")

# Remove duplicates
df = df.drop_duplicates()

# Handle null values
df.fillna("Unknown", inplace=True)

# Convert date column
df["sale_date"] = pd.to_datetime(df["sale_date"])
```

---

## Data Warehouse Design

A **Star Schema** was implemented to optimize analytical queries and reporting performance.

### Fact Table

#### Fact_Sales

| Column      |
| ----------- |
| Sales_ID    |
| Customer_ID |
| Product_ID  |
| Store_ID    |
| Date_ID     |
| Quantity    |
| Unit_Price  |
| Revenue     |

---

### Dimension Tables

#### Dim_Customer

| Column        |
| ------------- |
| Customer_ID   |
| Customer_Name |
| Gender        |
| City          |
| State         |

#### Dim_Product

| Column       |
| ------------ |
| Product_ID   |
| Product_Name |
| Category     |
| Brand        |

#### Dim_Date

| Column  |
| ------- |
| Date_ID |
| Date    |
| Month   |
| Quarter |
| Year    |

#### Dim_Store

| Column     |
| ---------- |
| Store_ID   |
| Store_Name |
| City       |
| Region     |

---

## Star Schema Diagram

```text
                    Dim_Customer
                          |
                          |
Dim_Product ---- Fact_Sales ---- Dim_Store
                          |
                          |
                       Dim_Date
```

---

## Data Loading into Snowflake

The transformed datasets were loaded into Snowflake tables using Python and Snowflake connectors.

### Loading Process

1. Create Snowflake database and schema.
2. Create Fact and Dimension tables.
3. Load transformed CSV files.
4. Validate record counts.
5. Perform quality checks.

---

## SQL Analytics

### Monthly Revenue Analysis

```sql
SELECT
    d.year,
    d.month,
    SUM(f.revenue) AS total_revenue
FROM Fact_Sales f
JOIN Dim_Date d
ON f.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
```

---

### Top Selling Products

```sql
SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity
FROM Fact_Sales f
JOIN Dim_Product p
ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 10;
```

---

### Regional Sales Performance

```sql
SELECT
    s.region,
    SUM(f.revenue) AS revenue
FROM Fact_Sales f
JOIN Dim_Store s
ON f.store_id = s.store_id
GROUP BY s.region
ORDER BY revenue DESC;
```

---

### Customer Purchase Analysis

```sql
SELECT
    c.customer_name,
    COUNT(*) AS total_orders,
    SUM(f.revenue) AS lifetime_value
FROM Fact_Sales f
JOIN Dim_Customer c
ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;
```

---

## Data Visualization

### Monthly Revenue Trend

```python
import matplotlib.pyplot as plt

monthly_sales.plot(
    x="month",
    y="revenue",
    kind="line"
)

plt.title("Monthly Revenue Trend")
plt.show()
```

### Product Performance Analysis

```python
import seaborn as sns

sns.barplot(
    data=top_products,
    x="product_name",
    y="sales"
)
```

### Regional Sales Distribution

```python
sns.boxplot(
    data=regional_sales,
    x="region",
    y="revenue"
)
```

---

## Business Insights Generated

The project provided insights such as:

* Monthly revenue growth trends
* Best-selling products and categories
* Top-performing regions and stores
* Customer purchasing patterns
* Customer lifetime value analysis
* Seasonal sales fluctuations

---

## Challenges Faced

* Handling inconsistent source data
* Managing missing values
* Designing an optimized dimensional model
* Ensuring data quality during ETL
* Writing efficient analytical SQL queries

---

## Key Learnings

Through this project, I gained hands-on experience in:

* Data Warehousing Concepts
* Dimensional Modeling
* Star Schema Design
* ETL Development
* Data Cleaning and Transformation
* Snowflake Data Warehouse
* SQL Analytics
* Business Intelligence Reporting
* Data Visualization using Python

---

## Conclusion

This project successfully demonstrated the end-to-end implementation of a modern Retail Sales Data Warehouse using Snowflake. From data extraction and transformation to dimensional modeling, analytical querying, and visualization, the project provided practical experience in building scalable data engineering and business intelligence solutions. It strengthened my understanding of ETL pipelines, data warehouse architecture, SQL analytics, and dashboard-driven decision making.
