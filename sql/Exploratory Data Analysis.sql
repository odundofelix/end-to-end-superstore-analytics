## 1. Uderstanding Data Model
#join all three
--Tables
--orders → transaction-level data (sales, discounts, profit, etc.)
--returns → returned orders (join on Order ID)
--managers → regional managers (join on Region)
SELECT o.*, r."Returned", m."Person" AS manager
FROM
    orders_staging o
    LEFT JOIN returns r ON o."Order ID" = r."Order ID"
    LEFT JOIN managers m ON o."Region" = m."Region";

##2. Descriptive analystic (Baseline Statistics)
--Sales overview
SELECT
    ROUND(SUM("Sales")::numeric, 2) AS total_sales,
    ROUND(SUM("Profit")::numeric, 2) AS total_profit,
    ROUND(
        AVG(("Discount") * 100)::numeric,
        2
    ) AS avg_discount_percent,
    COUNT(DISTINCT "Order ID") AS total_orders,
    COUNT(DISTINCT "Customer ID") AS unique_customers
FROM orders_staging;

--Yearly and Monthly Trends
SELECT DATE_PART('year', "Order Date") AS year, DATE_PART('month', "Order Date") AS month, ROUND(SUM("Sales")::numeric, 2) AS sales, ROUND(SUM("Profit")::numeric, 2) AS profit
FROM orders_staging
GROUP BY
    year,
    month
ORDER BY year, month;

##3. Diagnostic Analytics
--sales by category and subcategory
SELECT
    "Category",
    "Sub-Category",
    ROUND(SUM("Sales")::numeric, 2) AS sales,
    ROUND(SUM("Profit")::numeric, 2) AS profit
FROM orders_staging
GROUP BY
    "Category",
    "Sub-Category"
ORDER BY sales DESC;

--Regional and Manager Analysis
SELECT o."Region", m."Person" AS manager, ROUND(SUM(o."Sales")::numeric, 2) AS sales, ROUND(SUM(o."Profit")::numeric, 2) AS profit
FROM orders_staging o
    LEFT JOIN managers m ON o."Region" = m."Region"
GROUP BY
    o."Region",
    m."Person"
ORDER BY profit DESC;
--Segment and Customer Insights
SELECT
    "Segment",
    ROUND(SUM("Sales")::numeric, 2) AS sales,
    ROUND(SUM("Profit")::numeric, 2) AS profit,
    COUNT(DISTINCT "Customer ID") AS customers
FROM orders_staging
GROUP BY
    "Segment";
--Shipping Performance
SELECT
    "Ship Mode",
    ROUND(AVG("Sales")::numeric, 2) AS avg_sales,
    ROUND(AVG("Profit")::numeric, 2) AS avg_profit,
    ROUND(
        AVG(("Discount") * 100)::numeric,
        2
    ) AS avg_discount_percent,
    COUNT(*) AS total_orders
FROM orders_staging
GROUP BY
    "Ship Mode";

##4. Return and Loss Analysis
--Return rate
SELECT
    COUNT(r."Order ID") AS returned_orders,
    COUNT(DISTINCT o."Order ID") AS total_orders,
    ROUND(
        COUNT(r."Order ID")::decimal / COUNT(DISTINCT o."Order ID") * 100,
        2
    ) AS return_rate
FROM orders_staging o
    LEFT JOIN returns r ON o."Order ID" = r."Order ID";
--Profitability Impact of Returns
SELECT
    CASE
        WHEN r."Returned" IS NOT NULL THEN 'Returned'
        ELSE 'Not Returned'
    END AS return_status,
    ROUND(SUM(o."Sales")::numeric, 2) AS total_sales,
    ROUND(SUM(o."Profit")::numeric, 2) AS total_profit
FROM orders_staging o
    LEFT JOIN returns r ON o."Order ID" = r."Order ID"
GROUP BY
    return_status;

##5. Advanced Insights
--Delivery Efficiency
SELECT ROUND(
        AVG(
            EXTRACT(
                DAY
                FROM ("Ship Date" - "Order Date")
            )
        ), 2
    ) AS avg_ship_days
FROM orders_staging;
--Discount vs Profitability Correlation
SELECT ROUND(("Discount")::numeric, 2) AS discount_level, ROUND(AVG("Profit")::numeric, 2) AS avg_profit
FROM orders_staging
GROUP BY
    discount_level
ORDER BY discount_level;
--Top and Bottom products
SELECT
    "Product Name",
    ROUND(SUM("Profit")::numeric, 2) AS profit,
    ROUND(SUM("Sales")::numeric, 2) AS sales
FROM orders_staging
GROUP BY
    "Product Name"
ORDER BY profit DESC
LIMIT 10;
-- top 10 profitable

-- and lowest profit products
SELECT
    "Product Name",
    ROUND(SUM("Profit")::numeric, 2) AS profit,
    ROUND(SUM("Sales")::numeric, 2) AS sales
FROM orders_staging
GROUP BY
    "Product Name"
ORDER BY profit ASC
LIMIT 10;