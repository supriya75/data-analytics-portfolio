--Monthly Sales trend
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
    SUM(Sales) AS monthly_sales
FROM superstore_sales
GROUP BY month
ORDER BY month;

-- Total Sales and Profit by Sub-Category
SELECT Sub_Category,
       SUM(Total_Sales) AS Total_Sales,
       SUM(Total_Profit) AS Total_Profit
FROM sales_data
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

-- Identify profitable and loss-making products
SELECT Sub_Category,
       Total_Sales,
       Total_Profit,
       CASE WHEN Total_Profit >= 0 THEN 'Profitable' ELSE 'Loss' END AS Profit_Status
FROM sales_data
ORDER BY Total_Profit DESC;

--Check How many duplicate rows exist:
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT(
        `Order_ID`, `Order_Date`, `Ship_Date`, `Customer_ID`, `Product_ID`, Sales, Profit
    )) AS unique_rows
FROM superstore_sales;


-- Overall Sales and Profit
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM superstore_sales;

