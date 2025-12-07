# London Housing SQL Analysis (MySQL)

## Overview
This project analyzes London housing prices using MySQL.
The goal is to identify high-growth districts, compare prices across years,
and perform SQL-based time-series analysis.

Dataset Source: Kaggle – Housing Prices in London  
A synthetic `Year` column (2016–2020) was added to enable time-series analysis.

---

## Schema Design
- london_raw (raw imported CSV)
- location (districts)
- house_type (property types)
- listing (fact table with price & year)

---

## Key SQL Techniques Used
- Multi-table JOINs
- GROUP BY aggregations
- Time-series analysis
- Window functions (LAG)
- Growth % calculation
- Ranking (Top 5 districts)

---

## Main Insight
Identified the **Top 5 London districts by price growth between 2016 and 2020**.

---

## How to Run
1. Create database:
   ```sql
   CREATE DATABASE london_housing;
   USE london_housing;
