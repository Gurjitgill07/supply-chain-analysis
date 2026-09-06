-- Supply Chain Delivery Performance Analysis
-- Author: Gurjit Singh Gill
-- Tool: DB Browser for SQLite
-- Dataset: 180,000+ supply chain orders


-- total orders in the dataset
SELECT 
    COUNT(*) AS total_orders
FROM orders;


-- overall late delivery risk rate
SELECT 
    ROUND(AVG(Late_delivery_risk) * 100, 2) AS late_delivery_risk_pct
FROM orders;

-- result: 54.83% of orders have late delivery risk


-- delivery status breakdown
SELECT 
    Delivery_Status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY Delivery_Status
ORDER BY total_orders DESC;

-- only 17.84% shipped on time


-- late delivery risk by shipping mode
SELECT 
    Shipping_Mode,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 2) AS late_delivery_risk_pct
FROM orders
GROUP BY Shipping_Mode
ORDER BY late_delivery_risk_pct DESC;

-- first class shipping has worst late delivery rate at 95.32%
-- standard class is most reliable at 38% late rate


-- on time vs late orders by shipping mode
SELECT 
    Shipping_Mode,
    Delivery_Status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY Shipping_Mode, Delivery_Status
ORDER BY Shipping_Mode, total_orders DESC;


-- top 10 regions with highest late delivery risk
SELECT 
    Order_Region,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 2) AS late_delivery_risk_pct
FROM orders
GROUP BY Order_Region
ORDER BY late_delivery_risk_pct DESC
LIMIT 10;


-- late delivery risk by product category
SELECT 
    Category_Name,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 2) AS late_delivery_risk_pct
FROM orders
GROUP BY Category_Name
ORDER BY late_delivery_risk_pct DESC;


-- monthly order volume trend
SELECT 
    STRFTIME('%Y-%m', Order_Date) AS month,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 2) AS late_delivery_risk_pct
FROM orders
GROUP BY month
ORDER BY month ASC;
