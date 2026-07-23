# E-Commerce Analytics & Revenue Optimization Platform

> An end-to-end Business Intelligence and Data Analytics project that transforms large-scale e-commerce user behavior data into actionable business insights using **Python, SQL, Power BI, and Excel**.

![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)
![SQL](https://img.shields.io/badge/SQL-MySQL-orange?logo=mysql)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![Excel](https://img.shields.io/badge/Excel-Forecasting-green?logo=microsoft-excel)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

# Project Overview

Modern e-commerce platforms generate millions of customer interactions every day. Understanding customer behavior across the purchasing journey is essential for improving conversion rates, reducing cart abandonment, increasing customer retention, and maximizing revenue.

This project performs a complete analytical workflow starting from raw user behavior data and ending with interactive business dashboards and forecasting models.

The project integrates:

- Python for data preprocessing and statistical analysis
- SQL for analytical data modeling
- Power BI for interactive dashboards
- Excel for revenue forecasting and business scenario analysis

---

# Business Problem

The objective of this project is to answer critical business questions such as:

- Where do customers drop out of the purchase funnel?
- Which user actions contribute most to purchases?
- Which product categories generate the highest engagement?
- Which categories experience the highest cart abandonment?
- How effective is customer retention?
- What revenue can potentially be recovered from abandoned carts?

The insights generated from this project can help businesses optimize marketing strategies, improve customer experience, and increase revenue.

---

# Project Architecture

```
                    Raw User Behavior Dataset
                              │
                              ▼
                   Python Data Preprocessing
                              │
                              ▼
               Feature Engineering & Data Cleaning
                              │
                              ▼
               Exploratory Data Analysis (EDA)
                              │
                              ▼
               Statistical Hypothesis Testing
                              │
                              ▼
                     SQL Data Modeling
                              │
                              ▼
                  Analytical SQL Views
                              │
                              ▼
                Interactive Power BI Reports
                              │
                              ▼
               Excel Forecasting & Business Models
                              │
                              ▼
                  Business Recommendations
```

---

# Technology Stack

## Programming

- Python
- SQL

## Python Libraries

- Pandas
- NumPy
- SciPy

## Database

- MySQL

## Visualization

- Power BI

## Forecasting

- Microsoft Excel

---

# Repository Structure

```
Ecommerce-Funnel-Optimization
│
├── data/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── statistical_analysis.ipynb
│
├── powerbi/
│   ├── ecommerce_analytics.pbix
│   └── returnchain.pbix
│
├── sql/
│   ├── 01_setup.sql
│   ├── 02_views.sql
│   └── 03_powerbi_queries.sql
│
├── src/
│   ├── 01_sampling.py
│   ├── 02_cleaning.py
│   └── check_columns.py
│
├── requirements.txt
│
└── README.md
```

---

# Data Processing Pipeline

The preprocessing pipeline focuses on transforming raw clickstream data into an analysis-ready dataset.

The workflow includes:

- Data loading
- Missing value handling
- Duplicate removal
- Timestamp conversion
- Date and time feature extraction
- User-level aggregation
- Behavioral feature engineering
- Dataset validation

---

# Exploratory Data Analysis

The project performs exploratory analysis to understand customer purchasing behavior.

The analysis includes:

- Event distribution
- User activity patterns
- Purchase trends
- Category-level analysis
- Hourly activity analysis
- Conversion analysis
- Customer behavioral patterns

---

# Statistical Analysis

Instead of relying solely on descriptive analytics, this project validates business observations using statistical hypothesis testing.

The statistical analysis notebook includes:

- Hypothesis formulation
- Chi-Square Test of Independence
- Cramer's V Effect Size
- Customer behavior comparison
- Statistical significance testing
- Interpretation of analytical findings

The objective is to ensure that observed customer behavior patterns are statistically meaningful before deriving business conclusions.

---

# SQL Layer

The SQL layer transforms processed datasets into reusable analytical views for reporting.

The implementation includes:

## Database Setup

- Database creation
- Table creation
- Data preparation

## Analytical SQL Views

Business views have been created for reporting including:

- Funnel Analysis
- Customer Segmentation
- Category Performance
- Cart Abandonment
- Loyalty Analysis
- Conversion Metrics
- Hourly User Behavior

These SQL views serve as the primary data source for Power BI dashboards.

---

# Power BI Dashboards

The project includes multiple interactive dashboards designed to answer different business questions.

## 1. Funnel Analysis Dashboard

Provides an overview of customer movement through the purchasing funnel.

Key Metrics

- Total Viewers
- Total Favourites
- Cart Users
- Buyers
- Overall Conversion Rate
- Cart-to-Buy Conversion
- View-to-Favourite Conversion

---

## 2. User Behavior Dashboard

Analyzes customer engagement throughout the day.

Includes:

- Hourly conversion trends
- Hourly purchase distribution
- User segmentation
- Purchase behavior analysis

---

## 3. Cart Recovery Dashboard

Focuses on identifying revenue loss caused by cart abandonment.

Includes:

- Cart abandonment by category
- Estimated recovery revenue
- Abandonment percentage
- High-risk categories

---

## 4. Category Performance Dashboard

Evaluates product category performance.

Includes:

- Category views
- Purchases
- Conversion rates
- Category comparison

---

## 5. Customer Loyalty Dashboard

Analyzes repeat customer behavior.

Customer Segments

- No Purchase
- One-Time Buyers
- Repeat Customers
- Loyal Customers
- VIP Customers

---

# Key Dashboard Metrics

Current dashboard metrics include:

| Metric | Value |
|----------|--------:|
| Total Viewers | 372K |
| Cart Users | 145K |
| Buyers | 79K |
| Favourites | 68K |
| Overall Conversion | 21.15% |
| Cart → Buy Conversion | 54.18% |
| Cart Abandonments | 140K |
| Categories Analysed | 664 |
| Estimated Recovery Revenue | 296.5K |
| Total Users | 376K |

---

# Excel Forecasting

The project also includes Excel-based business forecasting.

Current implementation:

- Cart Recovery Revenue Forecast

The forecasting model estimates potential revenue recovery based on cart abandonment metrics and recovery assumptions.

---

# Business Insights

The project enables businesses to:

- Identify customer drop-off points within the purchasing funnel.
- Detect high-performing product categories.
- Measure customer conversion performance.
- Analyze hourly purchasing behavior.
- Understand customer loyalty distribution.
- Estimate revenue recoverable from abandoned carts.
- Support data-driven business decision making.

---

# Skills Demonstrated

This project demonstrates practical experience in:

- Data Cleaning
- Data Preprocessing
- Feature Engineering
- Exploratory Data Analysis
- Statistical Analysis
- Hypothesis Testing
- SQL Data Modeling
- SQL View Creation
- Business Intelligence
- Dashboard Development
- Customer Analytics
- Revenue Analytics
- Forecasting
- Business Reporting

---

# Installation

Clone the repository

```bash
git clone https://github.com/Raj-Aryan111/Ecommerce-Funnel-Optimization.git
```

Move into the project

```bash
cd Ecommerce-Funnel-Optimization
```

Create virtual environment

```bash
python -m venv venv
```

Activate environment

Windows

```bash
venv\Scripts\activate
```

Install dependencies

```bash
pip install -r requirements.txt
```

---

# Dataset

The repository does not include the original raw dataset because of its large size.

The project is built using the Taobao User Behavior Dataset. The preprocessing scripts included in this repository can be used to recreate the analytical datasets.

---

# Future Improvements

Planned enhancements include:

- Improve Power BI dashboard UI/UX
- Add executive summary dashboard
- Expand Excel forecasting models
- Add additional KPI monitoring
- Improve dashboard interactivity with advanced filters and drill-through analysis

---

# Author

**Raj Aryan**

GitHub: https://github.com/Raj-Aryan111

---

## If you found this project useful, consider giving it a ⭐ on GitHub.
