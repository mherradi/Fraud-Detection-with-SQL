/* 
================================================================================================
Create Database and Schemas
================================================================================================

Script Purpose:
	This script creates a new database named 'FraudDetection' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'bronze' ,' silver' ,and 'gold' .

WARNING:
	Running this script will drop the entire • DataWarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.

*/

-- -- Use Master Capabilites
use master ;

-- -- Checking before Creating a Database

if exists(select 1 from sys.databases where name = 'FraudDetection')

begin
	-- If a database named FraudDetection exists, disconnect everyone using it and delete it safely

	alter database FraudDetection set single_user with rollback immediate ;
	Drop database  FraudDetection ;

end ;

-- -- Creating Fraud Detection Database
create database FraudDetection ;

-- -- Start Using Fraud Detection Database
use FraudDetection ;

-- -- Creating the needed schema 

create schema bronze ;
go ;
create schema silver ;
go ;
create schema gold ;
go ;
