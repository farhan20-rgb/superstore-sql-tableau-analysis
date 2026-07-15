# superstore-sql-tableau-analysis

## Business Question
How do sales, profit, and discounting patterns vary across product
categories, and what trends drive revenue over time?

## Dataset
Sample Superstore dataset (Kaggle) — ~10,000 retail orders (2014-2017)
including sales, profit, discount, category, region, and customer data.

## Method
- Loaded data into a SQLite database and queried it using SQL
  (joins, aggregations, CTEs, and window functions)
- Built an interactive dashboard in Tableau Public to visualize findings

## Key Findings

**1. Furniture has a profitability problem.**
Despite generating similar revenue to Office Supplies ($742K vs. $719K),
Furniture's profit is 7x lower ($18.5K vs. $122.5K), driven by a much
higher average discount rate (17.4% vs. 15.7%). Furniture's profit
margin sits at just 2.49%, compared to 17%+ for the other two categories.

**2. Clear seasonal sales pattern.**
Revenue consistently spikes every November across all four years in the
dataset, with January/February as the slowest months — a pattern
confirmed using a running-total window function in SQL.

**3. Top customers by profit.**
Using a `RANK()` window function, identified the top 10 most profitable
customers, led by Tamara Chand ($8,981) and Raymond Buch ($6,976).

## Tools
SQL (SQLite), Python, Tableau Public

## Dashboard
[View the interactive dashboard on Tableau Public](https://public.tableau.com/app/profile/farhan.syed2384/viz/SuperstoreSalesProfitabilityAnalysis_17840994817630/SuperstoreSalesProfitabilityAnalysis?publish=yes)

## Files
- `superstore_queries.sql` — all SQL queries used in the analysis
- `README.md` — this file
