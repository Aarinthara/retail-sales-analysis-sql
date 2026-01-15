# 🛒 Retail Sales SQL Analysis Project

## 📌 Project Overview
This project is an **end-to-end SQL-based retail analytics case study** focused on data cleaning, exploratory data analysis (EDA), and business-driven insights.

The objective of this project is to use **SQL** to analyze retail transaction data, improve data quality, and answer real-world business questions related to **sales performance, customer behavior, and product insights**.

---

## 📂 Dataset Description
The analysis is performed on a retail database containing the following tables:

- **sales_transaction** – transaction-level sales data  
- **product_inventory** – product details including price and category  
- **customer_profiles** – customer demographic and profile information  

---

## 🧹 Data Cleaning & Preparation
The following data quality issues were identified and fixed using SQL:

- Removed **duplicate records** from sales transactions  
- Corrected **incorrect product prices** by matching inventory data  
- Handled **NULL and empty values** in customer location fields  
- Standardized **date formats** using `STR_TO_DATE()`  
- Converted string dates into proper **DATE data types**

---

## 🔍 Exploratory Data Analysis (EDA)
Key analyses performed in this project include:

### 📊 Sales Analysis
- Total sales and total units sold by **product**
- Category-wise sales performance
- Identification of **top revenue-generating products**
- Low-performing products based on sales volume
- Monthly and overall **sales trends**
- Growth rate of sales over time

### 👥 Customer Analysis
- Customer purchase frequency analysis
- Identification of **high-frequency and repeat customers**
- Segmentation of customers into:
  - High purchase frequency
  - Occasional customers
  - Repeat buyers
- Customer loyalty indicators

### 🏷️ Product & Category Insights
- Product category performance comparison
- High-sales vs low-sales product identification
- Category contribution to total revenue

---

## 🛠️ SQL Concepts Used
- `JOIN` (INNER JOIN)
- `GROUP BY` & `HAVING`
- Aggregate functions (`SUM`, `COUNT`, `AVG`)
- Subqueries
- Data type conversion
- Data cleaning using `UPDATE` and `ALTER`
- Ordering and ranking results

---

## 📸 Project Screenshots
This repository includes **SQL query execution screenshots** showing:
- Data cleaning steps
- Query logic
- Result outputs for each analysis

(Stored inside the `images/` folder)

---

## 🎯 Key Takeaways
- Improved data quality leads to more reliable insights
- SQL can be effectively used for **end-to-end analytics**, not just querying
- Customer segmentation helps identify high-value customers
- Product and category-level analysis supports better business decisions

---

## 🚀 Tools Used
- MySQL
- MySQL Workbench
- GitHub for version control and project documentation

---

## 📌 Author
**Aarinthara Babu (Aari)**  
Aspiring Data Analyst | SQL | Excel | Power BI  
