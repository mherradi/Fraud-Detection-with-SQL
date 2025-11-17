
/*
===============================================================================================
Stored Procedure: Load Bronze Layer (Source Files -> Bronze Layer)
===============================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the `BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:

None.

This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;

*/

create or alter procedure bronze.load_bronze as

begin

	Declare @Start_time Datetime , @End_time Datetime , @batch_start_time Datetime , @batch_end_time Datetime ;
	
	begin try 

		set @batch_start_time = GETDATE() ;

		Print '==============================================================================================' ;
		Print 'Loading Bronze Layer Tables' ;
		Print '==============================================================================================' ;


		Print '----------------------------------------------------------------------------------------------' ;
		Print 'Loading Data From Card Holder File' ;
		Print '----------------------------------------------------------------------------------------------' ;


		--- > Empty card_holder table before start Loading

		Set @Start_time = GETDATE() ;

		Print '>> Truncating Card Holder Table : bronze.card_holder ';

		Truncate Table  bronze.card_holder ;

		---> Loading the whole data into the card_holder Table

		Print '>> Inserting Data  Into : bronze.card_holder ';

		Bulk Insert  bronze.card_holder

		From 'C:\Users\elect\OneDrive\Bureau\SQL Workspace\2. Fraud Detection with SQL\Data\card_holder.csv'
		
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			-- The file was saved with Unix-style line endings where '\n' = '0x0A', even though you're on Windows.
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);

		Set @End_time = GETDATE() ; 

		Print 'Loading Duration : ' + Cast( DateDiff(second , @Start_time , @End_time) as Nvarchar ) + ' seconds.';

		Print '**********************************************************************************************' ;



		Print '----------------------------------------------------------------------------------------------' ;
		Print 'Loading Data From Credit Card File' ;
		Print '----------------------------------------------------------------------------------------------' ;


		--- > Empty credit_card table before start Loading

		Set @Start_time = GETDATE() ;
		
		Print '>> Truncating Credit Card Table : bronze.credit_card ';

		truncate table bronze.credit_card ;

		---> Loading the whole data into the card_holder Table

		bulk insert  bronze.credit_card 

		from 'C:\Users\elect\OneDrive\Bureau\SQL Workspace\2. Fraud Detection with SQL\Data\credit_card.csv'

		with (

			firstrow = 2 ,
			fieldterminator = ',' ,
			rowterminator =  '0x0a',
			tablock

		) ;

		Set @End_time = GETDATE() ;

		Print 'Loading Duration : ' + Cast( DateDiff(second , @Start_time , @End_time) as Nvarchar ) + ' seconds.';

		Print '**********************************************************************************************' ;




		Print '----------------------------------------------------------------------------------------------' ;
		Print 'Loading Data From Merchant File Using GUI' ;
		Print '----------------------------------------------------------------------------------------------' ;

		-- > Loading the whole data into the merchant Table

		-- Load via SSMS Import Wizard Regard technical Problems


		Print '**********************************************************************************************' ;




		Print '----------------------------------------------------------------------------------------------' ;
		Print 'Loading Data From Merchant Category File ' ;
		Print '----------------------------------------------------------------------------------------------' ;

		--- > Empty merchant_category table before start Loading

		Set @Start_time = GETDATE() ;

		Print '>> Truncating Merchant Category Table : bronze.merchant_category ';

		truncate table bronze.merchant_category ;


		---> Loading the whole data into the merchant_category Table

		BULK INSERT  bronze.merchant_category 
		FROM 'C:\Users\elect\OneDrive\Bureau\SQL Workspace\2. Fraud Detection with SQL\Data\merchant_category.csv'
		WITH (
			FIELDTERMINATOR = ',',      
			ROWTERMINATOR = '0x0a',      -- Line break (use 0x0a on Linux)
			FIRSTROW = 2,               
			FIELDQUOTE = '"',           -- Handles quoted fields with commas
			TABLOCK                     
		);


		Set @End_time = GETDATE() ;

		Print 'Loading Duration : ' + Cast( DateDiff(second , @Start_time , @End_time) as Nvarchar ) + ' seconds.';

		Print '**********************************************************************************************' ;




		Print '----------------------------------------------------------------------------------------------' ;
		Print 'Loading Data From Transactions File ' ;
		Print '----------------------------------------------------------------------------------------------' ;

		--- > Empty transactions table before start Loading

		Print '>> Truncating Transactions Table : bronze.merchant_category ';

		set @Start_time = GETDATE() ;

		truncate table bronze.transactions ;

		---> Loading the whole data into the transactions Table

		bulk insert  bronze.transactions 

		from 'C:\Users\elect\OneDrive\Bureau\SQL Workspace\2. Fraud Detection with SQL\Data\transaction.csv'

		with (

			firstrow = 2 ,
			fieldterminator = ',' ,
			rowterminator =  '0x0a',
			tablock

		) ;


		set @End_time = GETDATE() ;

		print 'Loading Duration : ' + cast(datediff(second , @Start_time , @End_time) as nvarchar) + ' seconds.' ;

		Print '**********************************************************************************************' ;


		set @batch_end_time = GETDATE() ;


		Print '==============================================================================================' ;

		Print 'Batch Loading Duration : ' + Cast( DateDiff(second , @batch_start_time , @batch_end_time) as Nvarchar ) + ' seconds.' ;
		
		Print '==============================================================================================' ;

	end try 

	begin catch
		Print '==============================================================================================' ;
		Print 'An Error Occured During Loading Bronze Layer:' ;
		Print 'Error Message : ' + Error_Message() ;
		Print 'Error Number   :' + Cast(Error_Number() as Nvarchar(50));
		Print '==============================================================================================' ;

	end catch

end



EXEC bronze.load_bronze;









