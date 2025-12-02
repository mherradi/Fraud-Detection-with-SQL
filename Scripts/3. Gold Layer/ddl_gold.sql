/*
===================================================================================================================================
DDL Script: Create Gold Views
===================================================================================================================================
Script Purpose:
This script creates views for the Gold layer in the data warehouse.
The Gold layer represents the final dimension and fact tables (Star Schema)

Each view performs transformations and combines data from the Silver layer
to produce a clean, enriched, and business-ready dataset.

Usage:
- These views can be queried directly for analytics and reporting.
===================================================================================================================================
*/





/*-------------------------------------------- Create Dimension Credit Cards Table  --------------------------------------------*/


if OBJECT_ID('gold.dim_cards','V') is not null

	drop view gold.dim_cards ;

go 

create view gold.dim_cards as  

select 
	
	ROW_NUMBER() over (order by cc.card  ) as card_key ,
	cc.card as card_id ,
	cc.id_card_holder as holder_id ,
	ch.name as holder_name

from 
	silver.credit_card as cc 
		
Left Join 
	silver.card_holder as ch
	
On 
	cc.id_card_holder = ch.id ;










/*-------------------------------------------- Create Dimension Merchant Table  --------------------------------------------*/


if OBJECT_ID('gold.dim_merchant','V') is not null

	drop view gold.dim_merchant ;

go 


create view gold.dim_merchant as  

select
	ROW_NUMBER() over (order by m.id) as merchant_key ,
	m.id merchant_id,
	m.name merchant_name ,
	m.id_merchant_category  category_id ,
	c.name category_name

from 
	silver.merchant m

Left Join
	silver.merchant_category c

On
	m.id_merchant_category = c.id ;






/*-------------------------------------------- Create Fact Transaction  Table  -------------------------------------------*/

/*- =======================================================================================================================

Note : Matching the full card number is impossible because of the scientific rounds to the last 4 digits

===========================================================================================================================*/


If OBJECT_ID('gold.fact_transactions','V') is not null

	drop view gold.fact_transactions ;

go


create view gold.fact_transactions as 

select 
	trans.id transaction_id ,
	trans.transaction_dt transaction_date ,
	trans.amount ,
	cd.card_key ,
	m.merchant_key

from	
	 silver.transactions as trans


Left Join
	gold.dim_cards cd 

On
	trans.card = cd.card_id

Left Join
	gold.dim_merchant m

On
	trans.id_merchant = m.merchant_id ;







