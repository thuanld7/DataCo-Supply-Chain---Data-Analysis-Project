# DataCo Supply Chain Analysis Project

## Overview
A comprehensive project analyzing a large supply chain dataset from DataCo Global, aiming to clean data, build a structured model, and derive actionable insights.

## Dataset
- Source: `DescriptionDataCoSupplyChain.csv` (~180 k rows)
- Domains: Customer, Product, Transaction, Shipping

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
Includes performance overview, delivery performance, and product & customer analysis. Available via Power BI.

