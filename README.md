# London Housing SQL Analysis (MySQL)

## 1. Project Overview

This project analyzes London housing prices using MySQL with a focus on:

- District-wise price comparison  
- Time-series price trend analysis  
- Identifying the top 5 districts by price growth over 5 years  
- Studying the effect of house type, size, bedrooms, and bathrooms on price  

The project simulates a real-world SQL data analytics workflow:
Raw CSV → Staging table → Normalized tables → Analysis queries → Insights.

---

## 2. Dataset

- Source: Kaggle – Housing Prices in London  
- Original File: London.csv  
- Processed File Used: London_with_years.csv  

The original dataset did not include a year column.  
To enable time-series analysis, a synthetic Year column was added:

- Years range from 2016 to 2020  
- Rows are evenly distributed across all 5 years  
- This enables realistic district-level growth analysis  

Note: The year values are synthetic, added for learning and analytical purposes.

---

## 3. Database Schema

### Tables Used

1. london_raw  
Staging table used to import the CSV directly.  
Contains all original dataset columns including the added Year column.

2. location  
Stores unique district/location data.  
Columns:
- location_id (Primary Key)  
- location_name  
- city_county  

3. house_type  
Stores unique house/property types.  
Columns:
- house_type_id (Primary Key)  
- type_name  

4. listing  
Main fact table used for analysis.  
Columns:
- listing_id (Primary Key)  
- raw_id  
- property_name  
- location_id (Foreign Key)  
- house_type_id (Foreign Key)  
- area_sqft  
- bedrooms  
- bathrooms  
- receptions  
- price  
- postal_code  
- year  

---

## 4. Project Folder Structure

london-housing-sql-project/
│
├── data/
│   └── London_with_years.csv
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_transform.sql
│   └── 03_analysis_queries.sql
│
└── README.md

---

## 5. How to Run This Project

### Step 1: Create Database

CREATE DATABASE london_housing;
USE london_housing;

---

### Step 2: Import CSV into london_raw

- Open MySQL Workbench  
- Right-click on the london_housing schema  
- Click Table Data Import Wizard  
- Select London_with_years.csv  
- Name the table: london_raw  
- Finish import  

---

### Step 3: Create Tables

Run:

sql/01_schema.sql

---

### Step 4: Transform & Load Clean Data

Run:

sql/02_transform.sql

This:
- Inserts unique house types  
- Inserts unique locations  
- Loads clean normalized data into the listing table  

---

### Step 5: Run Analysis Queries

Run:

sql/03_analysis_queries.sql

---

## 6. Key Analysis Performed

- Counted total number of listings  
- Computed min, max, and average property prices  
- Analyzed average price by:
  - District
  - House type
  - Bedrooms
  - Bathrooms
- Calculated price per square foot  
- Built district-wise time-series price trends  
- Computed year-over-year price growth using window functions  
- Identified the top 5 districts by 5-year price growth (2016–2020)  
- Ranked:
  - Top districts by average price
  - Top 3 properties per district
  - Top 5% luxury listings  
- Created views for reusable analytics  

---

## 7. Core Highlight

Identified the Top 5 London districts by price growth over a 5-year period (2016–2020) using time-series aggregation and window functions.

---

## 8. SQL Concepts Used

- Database schema design  
- Data normalization  
- Primary keys & foreign keys  
- Multi-table JOINs  
- Aggregation using:
  - AVG
  - SUM
  - COUNT
  - MIN
  - MAX
- Window functions:
  - LAG
  - ROW_NUMBER
  - RANK
  - NTILE  
- Time-series analysis  
- Ranking and segmentation  
- SQL Views  

---

## 9. Resume Description

London Housing SQL Analysis Project (MySQL)

- Designed a normalized relational database for London housing data  
- Imported and transformed a real-world Kaggle dataset using MySQL  
- Built analytical SQL queries using JOINs, window functions, and time-series aggregation  
- Identified the top 5 districts by housing price growth over 5 years  
- Documented and published the full SQL workflow on GitHub  

---

## 10. Future Improvements

- Add Python or Tableau visualizations  
- Build a dashboard for district-wise growth  
- Add monthly or quarterly time tracking  
- Apply outlier detection on luxury listings  

---

## 11. Author

Meenakshi Shibu  

