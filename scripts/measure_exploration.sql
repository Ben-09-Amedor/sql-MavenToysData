/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM()
===============================================================================
*/


		 -- find total products
SELECT COUNT(product_id) AS total_products FROM diamond.ProductSales;


		-- find total cost
SELECT SUM(total_cost) AS total_cost FROM diamond.ProductSales;

		-- find total revenue/sales
SELECT SUM(total_sales) AS total_cost FROM diamond.ProductSales;

		-- find the current sales date
SELECT MAX(sales_date) AS rescent_sales FROM diamond.ProductSales;

		-- find the first sales
SELECT MIN(sales_date) AS oldest_sales FROM diamond.ProductSales;

			-- find total stocks on hand
SELECT SUM(stock_on_hand) AS total_stock FROM diamond.StoreInventory;

		-- find recent openned store
SELECT MAX(store_open_date) AS rescently_openned FROM diamond.StoreInventory;

			--oldest stor
SELECT MIN(store_open_date) AS rescently_openned FROM diamond.StoreInventory;

		
