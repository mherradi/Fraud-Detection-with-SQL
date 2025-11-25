

-------  > Creating Card Holder Table


if object_id('silver.card_holder','U') is not null

	drop table silver.card_holder ;

go

create table silver.card_holder (

	id		int ,
	name	Nvarchar(50) ,
	dwh_create_date		Datetime2 Default GETDATE()

) ;

-------  > Creating Credit Card Table



	
if OBJECT_ID('silver.credit_card','U') is not null

	drop table silver.credit_card ;

go 

create table silver.credit_card (
	
	card				varchar(25) ,
	id_card_holder		Int ,
	dwh_create_date		Datetime2 Default GETDATE()

) ;


-------  > Creating Merchant Table

if OBJECT_ID('silver.merchant' ,'U') is not null 

	drop table silver.merchant ;

go 

create table silver.merchant (

	id						Int ,
    name					Nvarchar(255)  ,
    id_merchant_category	Int ,
	dwh_create_date		Datetime2 Default GETDATE()

) ;



-------  > Creating Merchant Category Table

if OBJECT_ID('silver.merchant_category','U') is not null

	drop table silver.merchant_category ;

go 


create table silver.merchant_category (

	id		Int ,
	name	Nvarchar(50)  ,
	dwh_create_date		Datetime2 Default GETDATE()

) ;



-------  > Creating Transactions Table


if OBJECT_ID('silver.transactions','U') is not null

	drop table silver.transactions ;

go

create table silver.transactions(


    id				Int ,
    transaction_dt  DateTime NOT NULL,
    amount          NUMERIC(10,2),
    card            Varchar(25),
    id_merchant     Int ,
	dwh_create_date		Datetime2 Default GETDATE()

) ;