CREATE DATABASE RETAIL_SALES;
USE RETAIL_SALES;
SELECT * FROM RETAIL_SALES_ANALYSIS;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE SALE_DATE= "2022-11-05";

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022:
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY= "CLOTHING"
AND QUANTIY>3
AND SALE_DATE BETWEEN "2022-11-01" AND "2022-11-30";

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT SUM(TOTAL_SALE), CATEGORY
FROM RETAIL_SALES_ANALYSIS
GROUP BY CATEGORY;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT AVG(AGE)
FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY= "BEAUTY";

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE TOTAL_SALE>1000;

-- ALTER TABLE RETAIL_SALES_ANALYSIS
-- CHANGE COLUMN `ï»¿transactions_id` TRANSACTIONS_ID INT;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT COUNT(TRANSACTIONS_ID), CATEGORY,GENDER
FROM RETAIL_SALES_ANALYSIS
GROUP BY CATEGORY, GENDER;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    EXTRACT(YEAR FROM SALE_DATE) AS SALE_YEAR,
    EXTRACT(MONTH FROM SALE_DATE) AS SALE_MONTH,
    AVG(TOTAL_SALE) AS AVG_SALE,
    MAX(SUM(TOTAL_SALE)) OVER (PARTITION BY EXTRACT(YEAR FROM SALE_DATE)) AS BEST_SALE
FROM RETAIL_SALES_ANALYSIS
GROUP BY EXTRACT(YEAR FROM SALE_DATE), EXTRACT(MONTH FROM SALE_DATE)
ORDER BY SALE_YEAR, SALE_MONTH;

-- Write a SQL query to find the top 5 customers based on the highest total sales :
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES_ANALYSIS
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_SALES DESC LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS CUST_ID
FROM RETAIL_SALES_ANALYSIS
GROUP BY CATEGORY;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales_ANALYSIS
GROUP BY shift;

-- END OF PROJECT
