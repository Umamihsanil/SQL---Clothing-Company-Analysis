## Problem Statement
X Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer! The CEO has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.

## Avaliable Data
For this case study there is a total of 2 datasets, product details and product sales.

**Table 1: Product Details**

Contains all information about the entire range that company sells in their store.

**Table 2: Product Sales**

Contains product level information for all the transactions made for company including quantity, price, percentage discount, member status, a transaction ID and also the transaction timestamp.

## Installation
To get this project, you can clone it by running the following code:

    git clone https://github.com/Umamihsanil/SQL---Clothing-Company-Analysis.git

### Case Study Questions
The following questions can be considered key business questions and metrics that our team requires for their monthly reports. Each question can be answered using a single query, but as you are writing the SQL to solve each individual problem, keep in mind how you would generate all of these metrics in a single SQL script which our team can run each month.

### Question 1: **Sales Analysis**

1. What was the total quantity sold for all products?
2. What is the total generated revenue for all products before discounts?
3. What was the total discount amount for all products?

### Question 2: **Transaction Analysis**

1. How many unique transactions were there?
2. What is the average unique products purchased in each transaction?
3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4. What is the average discount value per transaction?
5. What is the percentage split of all transactions for members vs non-members?
6. What is the average revenue for member transactions and non-member transactions?

### Question 3: **Product Analysis**

1. What is the percentage split of total revenue by category?
2. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
3. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

## Project Organization

The directory structure of IndoMarket project looks like this:

    ├── README.md          <- The top-level README for developers using this project.
    │
    ├── create_database    <- The document will consist query to create the database.
    │
    └── clothing_company   <- Document consist of quary to answer the question.