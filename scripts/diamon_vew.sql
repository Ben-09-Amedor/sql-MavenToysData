
/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the diamond layer in the maven. 
    The Diamond layer represents the final  tables for analysis.

    Each view performs transformations and combines data from the maven layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Table: diamond.ProductSales'
-- =============================================================================
IF OBJECT_ID('diamond.ProductSales', 'V') IS NOT NULL
    DROP VIEW diamond.ProductSales;
GO

        CREATE VIEW diamond.ProductSales AS
        SELECT 
        s.sales_id,
        s.store_id,
        s.product_id,
        s.sales_date,
        p.product_name,
        product_category,
        CAST(REPLACE(p.product_cost, '$', '') AS DECIMAL(10,2 )) AS product_cost,
        CAST(REPLACE(p.product_price, '$', '') AS DECIMAL(10,2)) AS product_price,
        s.units,
        (CAST(REPLACE(p.product_cost, '$', '') AS DECIMAL(10,2 )) * s.units) AS total_cost, -- computed to find total cost
        (CAST(REPLACE(p.product_price, '$', '') AS DECIMAL(10,2 )) * s.units) AS total_sales -- computed to find total sales/revenue
        FROM maven.sales s
        LEFT JOIN maven.products p
         ON s.product_id = p.product_id;




-- =============================================================================
-- Create Table: diamond.ProductSales'
-- =============================================================================

IF OBJECT_ID('diamond.StoreInventory', 'V') IS NOT NULL
    DROP VIEW diamond.StoreInventory;
GO

        CREATE VIEW diamond.StoreInventory AS

         SELECT 
         i.store_id,
         i.product_id,
         st.store_name,
         st.store_open_date,
         st.store_city,
         st.store_location,
         i.stock_on_hand
         FROM maven.inventory I
        LEFT JOIN maven.stores st
        ON i.store_id = st.store_id;
