CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
    BEGIN TRY

        PRINT '==========================================================================================================';
        PRINT 'Clean & Load Tables Into SILVER Layer';
        PRINT '==========================================================================================================';

        DECLARE 
            @start_time DATETIME, 
            @end_time DATETIME,
            @start_batch DATETIME,
            @end_batch DATETIME;

        SET @start_batch = GETDATE();


        /* =============================================== card_holder =============================================== */

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Clean and Load: silver.card_holder';
        PRINT '----------------------------------------------------------------------------------------------------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.card_holder;

        INSERT INTO silver.card_holder (id, name)
        SELECT id, name
        FROM bronze.card_holder;

        SET @end_time = GETDATE();
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
        PRINT '***********************************************************************************************************';



        /* =============================================== credit_card =============================================== */

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Clean and Load: silver.credit_card';
        PRINT '----------------------------------------------------------------------------------------------------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.credit_card;

        INSERT INTO silver.credit_card (card, id_card_holder)
        SELECT 
            SUBSTRING(CONVERT(VARCHAR(25), CONVERT(DECIMAL(38,0), card)), 1, 4) AS card,
            id_card_holder
        FROM bronze.credit_card;

        SET @end_time = GETDATE();
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
        PRINT '***********************************************************************************************************';



        /* =============================================== merchant =============================================== */

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Clean and Load: silver.merchant';
        PRINT '----------------------------------------------------------------------------------------------------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.merchant;

        INSERT INTO silver.merchant (id, name, id_merchant_category)
        SELECT id, name, id_merchant_category
        FROM bronze.merchant;

        SET @end_time = GETDATE();
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
        PRINT '***********************************************************************************************************';



        /* =============================================== merchant_category =============================================== */

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Clean and Load: silver.merchant_category';
        PRINT '----------------------------------------------------------------------------------------------------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.merchant_category;

        INSERT INTO silver.merchant_category (id, name)
        SELECT id, name
        FROM bronze.merchant_category;

        SET @end_time = GETDATE();
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
        PRINT '***********************************************************************************************************';



        /* =============================================== transactions =============================================== */

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Clean and Load: silver.transactions';
        PRINT '----------------------------------------------------------------------------------------------------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.transactions;

        INSERT INTO silver.transactions (
            id, transaction_dt, amount, card, id_merchant
        )
        SELECT
            id,
            transaction_dt,
            amount,
            SUBSTRING(CONVERT(VARCHAR(25), CONVERT(DECIMAL(38,0), card)), 1, 4),
            id_merchant
        FROM bronze.transactions;

        SET @end_time = GETDATE();
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
        PRINT '***********************************************************************************************************';


        /* =============================================== Final Batch Duration =============================================== */

        SET @end_batch = GETDATE();

        PRINT '----------------------------------------------------------------------------------------------------------';
        PRINT 'Total Batch Duration : ' + CAST(DATEDIFF(SECOND, @start_batch, @end_batch) AS NVARCHAR) + ' seconds.';
        PRINT '----------------------------------------------------------------------------------------------------------';


    END TRY

    BEGIN CATCH
        PRINT '==============================================================================================';
        PRINT '❌ ERROR During Loading SILVER Layer ❌';
        PRINT 'Message : ' + ERROR_MESSAGE();
        PRINT 'Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR(50));
        PRINT 'Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
        PRINT 'Line      : ' + CAST(ERROR_LINE() AS NVARCHAR);
        PRINT '==============================================================================================';
    END CATCH



END;


exec silver.load_silver ;
