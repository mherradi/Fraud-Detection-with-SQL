#  Fraud Detection with SQL

In this independent SQL project idea, we'll work with multiple CSV files to create a database schema and database, then query your new database to identify potentially fraudulent transactions. Fraud is everywhere these days, and while there are emerging technologies that employ machine learning and artificial intelligence to detect fraud, many instances still require strong data analytics to find abnormal charges. You'll apply SQL skills to analyze historical credit card transactions and consumption patterns in order to identify possible fraudulent transactions.

&nbsp;
&nbsp;

## 📖 Project Requirements and Objectives 

### 🧩 Data Warehouse Construction - Data Engineering Phase

#### Objective
Design, build, and populate a SQL data warehouse that stores and structures all relevant data for subsequent fraud detection analytics.

#### Specifications
- **Data Sources**: Import data from multiple CSV files to create a database schema and database.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
&nbsp;
&nbsp;
### 📊 Data Warehouse Construction - Data Engineering Phase

#### Objective
Perform analytical queries and visualizations to detect and report potentially fraudulent transactions. 

#### Specifications
- Find the top 100 highest transactions during early morning hours (7-9 AM)
- Count transactions less than $2.00 per cardholder to check for hacked cards
- Identify the top 5 merchants prone to being hacked with small transactions
- Create views for reusable queries
- Create a report for fraudulent transactions of top customers using Python and data visualization libraries
- Analyze outlier/anomalous transactions using techniques like standard deviation and interquartile range


## 🧱 Data Warehouse Architecture Decision: 
&nbsp;
&nbsp;
For this project, I decided to implement the Medallion Data Architecture (Bronze → Silver → Gold) to structure the data warehouse and analytical workflow. This layered design enables a clear separation between raw data ingestion, data cleaning and enrichment, and analytical reporting.

<img width="1374" height="782" alt="Fraud Data Warehouse drawio" src="https://github.com/user-attachments/assets/67cec9ee-f760-4f4d-8d6a-110cebdfaa6b" />

&nbsp;

- The Bronze layer stores raw transactional data exactly as received from source files, preserving full data lineage. 
- The Silver layer refines and normalizes this data by applying transformations, data quality checks, and integrity constraints, preparing it for analysis. 
- The Gold layer aggregates and models the cleaned data into business-ready views that support fraud detection analytics and reporting.


