



-- -- Creating Card Holder Table

if OBJECT_ID('bronze.card_holder','U')  is not null

	drop table bronze.card_holder ;

go 


create table bronze.card_holder (

	id		Int ,
	name	Nvarchar(50)

) ;


-- -- Crating Credit Card Table


if OBJECT_ID('bronze.credit_card','U')  is not null

	drop table bronze.credit_card ;

go 

create table bronze.credit_card (
	
	-- The values in the card column are very large numbers So, using a numeric or string type is safer.
	card				Nvarchar(50) ,
	id_card_holder		Int

) ;

-- -- Crating Merchant Table

if OBJECT_ID('bronze.merchant','U')  is not null

	drop table bronze.merchant ;

go 

CREATE TABLE bronze.merchant  (
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    id_merchant_category INT NOT NULL
);

-- -- Crating Merchant Category Table


if OBJECT_ID('bronze.merchant_category','U')  is not null

	drop table bronze.merchant_category ;

go 

create table bronze.merchant_category(

	id		Int ,
	name	Nvarchar(50)  NOT NULL


) ;

-- -- Crating Transactions Table

if OBJECT_ID('bronze.transactions','U')  is not null
	drop table bronze.transactions ;

go 

CREATE TABLE bronze.transactions (

    id              Int ,
    transaction_dt  TIMESTAMP NOT NULL,
    amount          NUMERIC(10,2),
    card            NUMERIC(20,0),
    id_merchant     Int,

);