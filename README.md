# Retail Transaction Analysis using Python, SQL & Power BI

**Overview**

This Data Analyst project provides an in-depth analysis of a retail business's performance between May 2023 to April 2024. The dataset includes over 99,000 transactions with customer-level data such as revenue,price, and time of purchases. The dashboard is designed to help stakeholders monitor key performance indicators, track customer behavior, and identify business trends.

Dataset
Name: Retail_Transaction_Dataset.csv

Source: kaggle

Size: 99,000+ transactions

Columns include: CustomerID,ProductID, Quantity, Price, TransactionDate, PaymentMenthod, StoreLocation, ProductCategory, DiscoutApplied, TotalAmount

**Project Workflow:**

1. Data Cleaning in Python (Jupyter Notebook)
Handled missing values and duplicate entries.

Converted TransactionDate to datetime.

Extracted features: Month, Year, Weekday, Hour, and CustomerType.

Exported the cleaned dataset for SQL/PostgreSQL ingestion.

Skill Used: Pandas, Matplotlib, Regex

2. SQL Exploration & Queries (PostgreSQL)
Imported cleaned data into PostgreSQL.

Ran queries to:

Get monthly revenue trends

Count new vs. returning customers

Identify top 10 customers by spend

Compute daily and hourly performance

Skill Used: CTEs, CASE statements, GROUP BY, and window functions.

3. Power BI Visualization
Built interactive dashboards using:

KPI Cards: Total Revenue, Total Transactions, Unique Customers, Average basket Size

Bar/Line Charts: Sales by Weekday, Peak Hours

Donut Chart: Customer Type Split

MoM Revenue Cards using DATEADD and CALCULATE

Bookmark for deep analysis of customer behaviour and revenue analysis

DAX Measures for: MoM Revenue, Unique Customer Count, Customer Retention 

Skill Used: Power BI (Data Model, Relationships, DAX)

**Key Insights:**

Customer traffic peaks between 7PM and 9PM, with the highest activity aorund 7:30PM.

Majority of purchases occur on weekends.

Over 90% of customers are new, highlighting strong acquisition efforts but opportunities to improve retention.

Top 3 customers contribute significantly to total revenue.

Month-over-month trends reveal growth in revenue and customer traffic, with visible churn patterns.


