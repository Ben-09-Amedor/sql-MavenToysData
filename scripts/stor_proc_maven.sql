/*
===============================================================================
Stored Procedure: Load maven (Source -> maven)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'maven' schema from external CSV files. 
    It performs the following actions:
    - Truncates the maven tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC maven.load_maven;
===============================================================================
*/
CREATE OR ALTER PROCEDURE maven.load_maven AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading data into maven Layer';
		PRINT '================================================';

				-- inserting data into product table
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: maven.products';
		TRUNCATE TABLE maven.products;
		PRINT '>> Inserting Data Into: maven.products';
		BULK INSERT maven.products
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_5\Maven Toys Data\products.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


		-- loading data into inventory table
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: maven.inventory';
		TRUNCATE TABLE maven.inventory;
		PRINT '>> Inserting Data Into: maven.inventory';
		BULK INSERT maven.inventory
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_5\Maven Toys Data\inventory.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



	-- loading data into maven sales
	SET @start_time = GETDATE();
		PRINT '>> Truncating Table: maven.sales';
		TRUNCATE TABLE maven.sales;
		PRINT '>> Inserting Data Into: maven.sales';
		BULK INSERT maven.products
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_5\Maven Toys Data\sales.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: maven.store';
		TRUNCATE TABLE maven.stores;
		PRINT '>> Inserting Data Into: maven.products';
		BULK INSERT maven.stores
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_5\Maven Toys Data\stores.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		
   SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
