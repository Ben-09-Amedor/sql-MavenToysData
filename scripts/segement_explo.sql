/*
===============================================================================
Segement Analysis
===============================================================================
Purpose:
    - To quantify data and segement results by specific dimensions.
    - For understanding data segementation by specified dimensions

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), 
    - GROUP BY, ORDER BY
===============================================================================
*/


	-- =================================================================================
	--				segementstores into three tiers base on profit margins
	-- ===============================================================================

	WITH base_query AS (
/*
----------------------------------------------------------------------------------
  1.	Base Query
----------------------------------------------------------------------------
*/
SELECT 
store_id,
total_cost,
total_sales
FROM diamond.ProductSales 
)


,store_aggregation AS (

/*
----------------------------------------------------------------------------------------------
	2.	Store Agregation: summarizes key metrics at store levels
----------------------------------------------------------------------------------------------
*/
SELECT
	store_id,
	SUM(total_cost) AS total_cost,
	SUM(total_sales) AS total_sales,
	(SUM(total_sales) - SUM(total_cost)) AS total_profits
FROM base_query
GROUP BY store_id

)
SELECT 
	store_id,
	total_cost,
	total_profits,
	CASE
		 WHEN total_profits > 100000 THEN 'Tier One Store'
		 WHEN total_profits BETWEEN 80000 AND 100000 THEN 'Tier Two Store'
		 ELSE 'Tier Three Store'
	END AS store_segement
	FROM store_aggregation
	ORDER BY store_id;


	
	-- =================================================================================
	--				Count of stores in three tiers base on profit margins
	-- ===============================================================================


		WITH store_sales AS(
		SELECT
		store_id,
		(SUM(total_sales) - SUM(total_cost)) AS total_profits
		FROM diamond.ProductSales
		GROUP BY store_id 
		)
		SELECT 
		store_segement,
		COUNT(store_id) AS number_of_stores
		FROM(
			SELECT 
				store_id,
				total_profits,
				CASE WHEN total_profits > 100000 THEN 'Tier One Store'
					 WHEN total_profits BETWEEN 80000 AND 100000 THEN 'Tier Two Store'
					 ELSE 'Tier Three Store'
				END AS store_segement
		FROM store_sales)t
		GROUP BY store_segement
		ORDER BY number_of_stores;


				-- =================================================================================
				--	segement stores into highly, adequate and poorly stocked
				-- ===============================================================================
	WITH base_query AS (
/*
----------------------------------------------------------------------------------
  1.	Base Query
----------------------------------------------------------------------------
*/
SELECT 
store_id,
store_name,
store_open_date,
stock_on_hand
FROM diamond.StoreInventory
)


,stock_aggregation AS (

/*
----------------------------------------------------------------------------------------------
	2.	Stock Agregation: summarizes key metrics at store levels
----------------------------------------------------------------------------------------------
*/
SELECT
	store_id,
	store_name,
	SUM(stock_on_hand) AS total_stocks,
	DATEDIFF(Year, store_open_date, GETDATE()) AS age_of_store
FROM base_query
GROUP BY store_id, store_name, DATEDIFF(Year, store_open_date, GETDATE())

)
SELECT 
	store_id,
	store_name,
	total_stocks,
	age_of_store,
	CASE 
		WHEN total_stocks  > 800 THEN 'Highly Stocked'
		WHEN total_stocks BETWEEN 500 AND 800 THEN 'Adequately stocked'
		ELSE 'Poorly Stocked'
	END AS stock_segementt
	FROM stock_aggregation
	ORDER BY store_id;






				-- =================================================================================
				--	Count of stores in highly, adequate and poorly stocked
				-- ===============================================================================


		WITH store_sales AS(
		SELECT
		store_id,
		SUM(stock_on_hand) AS total_stocks
		FROM diamond.storeInventory
		GROUP BY store_id 
		)
		SELECT 
		store_segement,
		COUNT(store_id) AS number_of_stores
		FROM(
			SELECT 
				store_id,
				total_stocks,
				CASE WHEN total_stocks  > 800 THEN 'Highly Stocked'
					 WHEN total_stocks BETWEEN 500 AND 800 THEN 'Adequately stocked'
					 ELSE 'Poorly Stocked'
				END AS stock_segement
		FROM store_sales)t
		GROUP BY store_segement
		ORDER BY number_of_stores DESC;

