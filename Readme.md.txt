# 🛍️ Superstore Sales Analysis

This project explores the "Sample Superstore" dataset using SQL, Python and Tableau to uncover insights related to sales performance, profitability, and customer behavior. The analysis identifies key problem areas and opportunities to improve business outcomes.

---

## 📈 Project Objective

Analyze regional, segment-based, and product-level data to:
- Identify underperforming categories and sub-categories
- Understand profitability trends across time and geography
- Evaluate customer segments and shipping performance
- Provide data-backed recommendations

---

## 🧰 Tools Used

- Python – for data cleaning, manipulation, and splitting the dataset into multiple CSV files.
- SQL Server — for querying and transforming the data  
- Tableau — for creating interactive visualizations and dashboards  
- Excel — source format of the dataset  

Dataset source: [Sample Superstore Dataset – Tableau Community](https://community.tableau.com/s/question/0D54T00000CWeX8SAL/sample-superstore-sales-excelxls)

---

🔄 Data Preprocessing
Data Splitting using Python:
I started by reading the original Sample Superstore dataset in CSV format using Python.
Then, I split the data into 4 separate CSV files based on logical segmentation (e.g., orders, products, customers, etc.), which I later imported into SQL Server for further analysis.

Python's pandas library was used for reading the CSV and performing the data splitting.

SQL Data Transformation:
After splitting the data, I imported each CSV into SQL Server to perform necessary transformations and aggregations. These steps prepared the data for deeper analysis, allowing me to explore trends, profitability, and other metrics at different levels (regional, segment-based, product-level).

---

## 📌 Key Insights

- 🪑 Tables sub-category have negative profit margins in most regions.
- 📉 The Central region’s Consumer segment is more than 3× less profitable than other in this segment.
- 🧭 The South region's Home Office segment also shows very low profitability compared to other regions in this segment.
- 🚚 Shipping times vary significantly by region and mode.
- 🧾 Removing loss-making sub-categories like Tables improves Furniture category profitability significantly.
- 📊 Some states consistently show negative profits, suggesting targeted interventions.

---

📊 Dashboards
1️⃣ Sales & Profit Dashboard
This dashboard provides a high-level overview of profitability across different dimensions.

Includes:

🗺️ Map of Total Profit by State – visualizes geographic profit distribution
📊 Top 5 Most Profitable States – ranked bar chart for easy comparison
📋 Highlighted Table of Profit by Sub-Category – color-coded for quick insights into which sub-categories perform best/worst
🧩 Pie Chart: Profit Percentage by Customer Segment
🧩 Pie Chart: Profit Percentage by Product Category

2️⃣ Trend & Performance Dashboard
This dashboard focuses on time-based and regional trends to evaluate performance over time.

Includes:

📈 Trend Line: Tables Sales Over Time
📈 Profit and Profit Margin Over the Years
📉 Profit Trends by Region




