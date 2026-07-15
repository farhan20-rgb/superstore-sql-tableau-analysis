SELECT * FROM "Sample - Superstore" LIMIT 5;
PRAGMA table_info("Sample - Superstore");
SELECT COUNT(*) FROM "Sample - Superstore";

SELECT Category, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit
FROM "Sample - Superstore"
GROUP BY Category
ORDER BY total_sales DESC;

SELECT Category,
       ROUND(AVG(Discount), 3) AS avg_discount,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM "Sample - Superstore"
GROUP BY Category
ORDER BY profit_margin_pct ASC;

SELECT "Order Date" FROM "Sample - Superstore" LIMIT 5;

SELECT 
  substr("Order Date", -4) AS year,
  printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER)) AS month,
  ROUND(SUM(Sales), 2) AS total_sales
FROM "Sample - Superstore"
GROUP BY year, month
ORDER BY year, month;

SELECT "Customer Name",
       ROUND(SUM(Profit), 2) AS total_profit,
       RANK() OVER (ORDER BY SUM(Profit) DESC) AS profit_rank
FROM "Sample - Superstore"
GROUP BY "Customer Name"
ORDER BY profit_rank
LIMIT 10;

SELECT 
  substr("Order Date", -4) AS year,
  printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER)) AS month,
  ROUND(SUM(Sales), 2) AS monthly_sales,
  ROUND(SUM(SUM(Sales)) OVER (ORDER BY substr("Order Date", -4), printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) AS INTEGER))), 2) AS running_total
FROM "Sample - Superstore"
GROUP BY year, month
ORDER BY year, month;