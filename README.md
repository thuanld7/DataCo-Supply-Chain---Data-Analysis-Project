# DataCo Supply Chain Analysis Project

## Full Project Walkthrough
For a detailed explanation of each step (data cleaning, modeling, and insights), read my Medium article: [DataCo Supply Chain – Data Analysis Project](https://medium.com/@thuankuner113/dataco-supply-chain-data-analysis-project-fc70429a7154)

## Overview
A comprehensive project analyzing a large supply chain dataset from DataCo Global, aiming to clean data, build a structured model, and derive actionable insights.

## Dataset
- Source: `DescriptionDataCoSupplyChain.csv` (~180 k rows)
- Domains: Customer, Product, Transaction, Shipping
- Download here: [Kaggle-DataCo SC Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)
## Tools
- Excel, SQL Server (via DBeaver/T-SQL), Power BI

## Workflow
1. Cleaned and normalized raw data  
2. Built dimension and fact tables (DimCustomer, DimProduct, DimStore, DimDate, FactTransaction)  
3. Explored key KPIs: revenue, profit margin, late delivery rate, top customers, product/category/country contribution via Pareto analysis  
4. Created a Power BI dashboard to visualize insights

## Key Insights & Recommendations
- **Avg. annual revenue**: $12M; **profit margin**: 10.8%; **late delivery**: 55%  
- **Top customer segment**: individual consumers (52% of profit)—targeted remarketing and VIP programs advised  
- **Product focus**: concentrate on categories generating 80% of profits (Fishing, Cleats, etc.); reduce low-margin inventory  
- **Shipping optimization**: minimize First Class shipping; favor Standard for cost and timeliness  
- **Regional strengths**: Europe and Latin America deliver most profit—strategic focus suggested

## Dashboard
Includes performance overview, delivery performance, and product & customer analysis. Available via Power BI [DataCo SC Dashboard](https://app.powerbi.com/view?r=eyJrIjoiYjZhYjBlMmUtNjQzNS00NDJmLWEzNTctMTI3YTM0YWJlYjNjIiwidCI6IjAzNjI5MGYxLWZlZjItNGI0MS1hZTU4LWNhOWY2ZTAxZDI4YiIsImMiOjEwfQ%3D%3D&source=post_page-----fc70429a7154---------------------------------------).

