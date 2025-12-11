/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'MavenToysData' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up q schemas 
    within the database named 'maven'.
	
WARNING:
    Running this script will drop the entire 'MavenToysData database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/





USE master;
GO

		IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'MavenToysData')

			BEGIN 
		ALTER DATABASE MavenToysData SET SINGLE_USER ROLLBACK IMMEDIATE
		DROP DATABASE MavenToysData;
		END;
		GO




		CREATE DATABASE MavenToysData;


		USE MavenToysData;

		-- create SChema maven
		CREATE SCHEMA maven;
		GO 

		CREATE SCHEMA diamond;

		GO


