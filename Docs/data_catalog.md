# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

---

### 1. **gold.dim_cards**
- **Purpose:** Dimension table containing standardized credit card identifiers and cardholder information.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                                |
|------------------|---------------|----------------------------------------------------------------------------------------------------------- |
| card_key         | BIGINT        | Surrogate primary key for the card dimension. Used in fact tables.                                         |
| card_id          | VARCHAR       | Cleaned credit-card number normalized from scientific format.                                              |
| holder_id        | INT           | Natural key linking to the card holder.                                                                    |
| holder_name      | NVARCHAR      | Name of the card holder.                                                                                   |

---

### 2. **gold.dim_products**
- **Purpose:** Merchant dimension including merchant category information.
- **Columns:**

| Column Name         | Data Type     | Description                                                                                             |
|---------------------|---------------|-------------------------------------------------------------------------------------------------------- |
| merchant_key        | BIGINT        | Surrogate primary key for the merchant dimension.                                                       |
| merchant_id         | INT           | Natural key from the source merchant table.                                                             |
| merchant_name       | NVARCHAR      | Name of the merchant.                                                                                   |
| category_id         | NVARCHAR      | Merchant category ID.                                                                                   |
| category_name       | NVARCHAR      | Merchant category name (e.g., “Grocery”, “Electronics”).                                                |

---

### 3. **gold.fact_transactions**
- **Purpose:** Fact table with transactional events such as payments, purchases, transfers.
- **Columns:**

| Column Name         | Data Type     | Description                                                                                             |
|---------------------|---------------|-------------------------------------------------------------------------------------------------------- |
| transaction_id      | INT           | Unique identifier of the transaction                                                                    |
| transaction_date    | DATETIME      | Timestamp when the transaction occurred.(e.g., 2018-01-01 23:15:10.000).                                |
| amount              | NUMERIC       | Transaction monetary value. (e.g., 6.22).                                                               |
| card_key            | BIGINT        | Foreign key to gold.dim_cards.card_key.                                                                 |              
| merchant_key        | BIGINT        | Foreign key to gold.dim_merchant.merchant_key.                                                          |
