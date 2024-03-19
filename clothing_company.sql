use clothing_company;

## Question 1: Sales Analysis
-- 1. What was the total quantity sold for all products?
SELECT SUM(qty)
FROM product_sales;

-- 2. What is the total generated revenue for all products before discounts?
SELECT SUM(qty*price) AS generated_revenue
FROM product_sales;

-- 3. What was the total discount amount for all products?
SELECT SUM(qty*price*discount/100) AS total_discount
FROM product_sale;

## Question 2: Transaction Analysis
-- 1. How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id) AS total_transaction
FROM product_sales;

-- 2. What is the average unique products purchased in each transaction?
SELECT ROUND(COUNT(prod_id)/COUNT(DISTINCT (txn_id)),0) AS avg_sales
FROM product_sales;

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH revenue AS (SELECT txn_id, sum((qty*price) - ((qty*price*discount)/100)) AS rev,
        NTILE(100) OVER(ORDER BY sum((qty*price)-((qty*price*discount)/100))) AS percentile
        FROM product_sales
        GROUP BY txn_id)

SELECT MAX(rev), percentile
FROM revenue
WHERE percentile in(25,50,75)
GROUP BY percentile;

-- 4. What is the average discount value per transaction?
SELECT txn_id, ROUND(AVG(qty*price*discount/100),2) AS avg_disc_value
FROM product_sales
GROUP BY txn_id;

-- 5. What is the percentage split of all transactions for members vs non-members?
SELECT ROUND(COUNT(DISTINCT txn_id)/(SELECT COUNT(DISTINCT txn_id) FROM product_sales)*100,2) AS split_percentage,
		member
FROM product_sales
GROUP BY member;

-- 6. What is the average revenue for member transactions and non-member transactions?
SELECT member,
	   ROUND(AVG((qty*price)-(qty*price*discount/100)),2) AS avg_revenue
FROM product_sales
GROUP BY member;

## Question 3: Product Analysis
-- 1. What is the percentage split of total revenue by category?
WITH table_join AS (SELECT *
					FROM product_sales
					LEFT JOIN product_details ON product_sales.prod_id = product_details.product_id)

SELECT category_name,
	   ROUND(SUM ((qty*price)-(qty*price*discount/100)) / (SELECT SUM((qty*price) - (qty*price*discount/100)) FROM table_join) * 100, 2) AS avg_rev
FROM table_join
GROUP BY category_name;

/*-- 2.What is the total transaction “penetration” for each product?
(hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)*/

WITH tab_prod AS (SELECT prod_id, COUNT(DISTINCT(txn_id)) AS total_prod 
					FROM product_sales s 
					LEFT JOIN product_details d
					ON s.prod_id = d.product_id
					GROUP BY prod_id),
                
	total_trans AS (SELECT COUNT(DISTINCT(txn_id)) AS total_trans 
					FROM product_sales)

SELECT prod_id,
		total_prod/total_trans as penetration 
FROM tab_prod
CROSS JOIN total_trans;

-- 3. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
SELECT ps1.prod_id AS product_1,
		ps2.prod_id AS product_2,
		ps3.prod_id AS product_3,
        COUNT(*) AS trans_count
FROM product_sales ps1
JOIN product_sales ps2 USING (txn_id)
JOIN product_sales ps3 USING (txn_id)
WHERE ps1.prod_id != ps2.prod_id AND ps2.prod_id != ps3.prod_id AND ps1.prod_id != ps3.prod_id
GROUP BY 1,2,3
ORDER BY trans_count DESC;