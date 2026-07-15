-- Preview the raw data
SELECT * FROM "Sample - Superstore" LIMIT 5;

-- Check column names and data types
PRAGMA table_info("Sample - Superstore");

-- Confirm total row count
SELECT COUNT(*) FROM "Sample - Superstore";

-- Total sales and profit by product category
SELECT Category, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit
FROM "Sample - Superstore"
GROUP BY Category
ORDER BY total_sales DESC;

-- Average discount rate vs. profit margin by category
-- Finding: Furniture has the highest avg discount (17.4%) and lowest
-- profit margin (2.49%), despite similar sales to Office Supplies
SELECT Category,
       ROUND(AVG(Discount), 3) AS avg_discount,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM "Sample - Superstore"
GROUP BY Category
ORDER BY profit_margin_pct ASC;

-- Check the raw date format before parsing (M/D/YYYY, not zero-padded)
SELECT "Order Date" FROM "Sample - Superstore" LIMIT 5;

-- Monthly sales trend
-- Finding: consistent seasonal spike every November-December across all 4 years
SELECT 
  substr("Order Date", -4) AS year,
  printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER)) AS month,
  ROUND(SUM(Sales), 2) AS total_sales
FROM "Sample - Superstore"
GROUP BY year, month
ORDER BY year, month;

-- Top 10 customers ranked by total profit (window function: RANK)
SELECT "Customer Name",
       ROUND(SUM(Profit), 2) AS total_profit,
       RANK() OVER (ORDER BY SUM(Profit) DESC) AS profit_rank
FROM "Sample - Superstore"
GROUP BY "Customer Name"
ORDER BY profit_rank
LIMIT 10;

-- Monthly sales with running total (window function: SUM() OVER)
-- Shows cumulative revenue growth across the full 4-year period
SELECT 
  substr("Order Date", -4) AS year,
  printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER)) AS month,
  ROUND(SUM(Sales), 2) AS monthly_sales,
  ROUND(SUM(SUM(Sales)) OVER (ORDER BY substr("Order Date", -4), printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER))), 2) AS running_total
FROM "Sample - Superstore"
GROUP BY year, month
ORDER BY year, month;
