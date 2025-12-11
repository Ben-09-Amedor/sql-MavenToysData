/*
===============================================================================
DDL Script: Create mavenes
===============================================================================
Script Purpose:
    This script creates tables in the 'maven schema dropping exiting table 
    if they already exist.
	  Run this script to re-define the DDL structure of 'maven Table
===============================================================================
*/


IF OBJECT_ID ('maven.products', 'U') IS NULL
 DROP  TABLE maven.products;
  GO;

  CREATE TABLE maven.products (
   product_id				NVARCHAR(10),
   product_name				NVARCHAR(50),
   product_category			NVARCHAR(50),
   product_cost				NVARCHAR(10),
   product_price			NVARCHAR(10),

   )
   GO;

IF OBJECT_ID ('maven.inventory', 'U') IS NULL
 DROP  TABLE maven.inventory;
  GO;

   CREATE TABLE maven.inventory(
   store_id					NVARCHAR(10),
   product_id				NVARCHAR(10),
   stock_on_hand			INT,

   )
   GO;

   IF OBJECT_ID ('maven.sales', 'U') IS NULL
 DROP  TABLE maven.sales;
  GO;
   CREATE TABLE maven.sales(
   sales_id					NVARCHAR(10),
   sales_date				DATE,
   store_id					NVARCHAR(10),
   product_id				NVARCHAR(10),
   units					INT

   )
   GO;


   IF OBJECT_ID ('maven.store', 'U') IS NULL
 DROP  TABLE maven.stores;
  GO;

   CREATE TABLE maven.stores(
   store_id					NVARCHAR(10),
   store_name				NVARCHAR(50),
   store_city				NVARCHAR(50),
   store_location			NVARCHAR(50),
   store_open_date			NVARCHAR(50)

   )

   GO;
