--checking for duplicates over all the records
with
    duplicate_orders AS (
        SELECT *, ROW_NUMBER() OVER (
                PARTITION BY
                    "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", "Customer ID", "Customer Name", "Segment", "Country", "City", "State", "Postal Code", "Region", "Product ID", "Category", "Sub-Category", "Product Name", "Sales", "Quantity", "Discount", "Profit"
            ) as row_num
        from orders
    )
select *
from duplicate_orders
where
    row_num > 1;

with
    duplicate_returns as (
        Select *, ROW_NUMBER() over (
                PARTITION BY
                    "Returned", "Order ID"
            ) as row_num
        from returns
    )
select *
from duplicate_returns
where
    row_num > 1;
--no duplicates found over the records of the two main tables
#check for possible duplicates in main columns
SELECT DISTINCT COUNT(*), "Row ID"
from orders
GROUP BY "Row ID"
HAVING COUNT(*)>1;
--row_id is unique possible primary key
##checking for incosistent formats in order table
##Leading/trailing whitespace
SELECT *
FROM orders
WHERE "Order ID" <> TRIM ("Order ID")
        OR "Ship Mode" <> TRIM("Ship Mode")
        OR "Customer ID"<> TRIM("Customer ID")
        OR "Customer Name" <>  TRIM("Customer Name")
        OR "Segment" <> TRIM ("Segment")
        OR "Country" <> TRIM ("Country")
        OR "City" <> TRIM ("City")
        OR "State" <> TRIM ("State")
        OR "Category" <> TRIM ("Category")
        OR "Region" <> TRIM ("Region")
        OR "Product ID" <> TRIM ("Product ID")
        OR "Sub-Category" <> TRIM ("Sub-Category")
        OR "Product Name" <> TRIM ("Product Name");
---16 records have white space or trailing records in one of the above columns
select DISTINCT
    count(*) as total,
    "Segment"
from orders
GROUP BY
    "Segment";

select DISTINCT "Sub-Category" from orders;

SELECT "Order Date" FROM orders WHERE "Order Date"::TEXT ~ '^\d+$';

select "Ship Date" from orders where "Ship Date"::TEXT ~ '^\d+$';
--all records are in correct unix timestamp for both the order date and ship date
SELECT
    COUNT(*) FILTER (
        WHERE
            "Row ID" IS NULL
    ) AS null_ID,
    COUNT(*) FILTER (
        WHERE
            "Order Date" IS NULL
    ) AS null_order,
    COUNT(*) FILTER (
        WHERE
            "Order Date" IS NULL
    ) AS null_odate,
    COUNT(*) FILTER (
        WHERE
            "Ship Date" IS NULL
    ) AS null_sdate,
    COUNT(*) FILTER (
        WHERE
            "Ship Mode" IS NULL
    ) AS null_mode,
    COUNT(*) FILTER (
        WHERE
            "Customer ID" IS NULL
    ) AS null_cID,
    COUNT(*) FILTER (
        WHERE
            "Customer Name" IS NULL
    ) AS null_cname,
    COUNT(*) FILTER (
        WHERE
            "Segment" IS NULL
    ) AS null_segment,
    COUNT(*) FILTER (
        WHERE
            "Country" IS NULL
    ) AS null_country,
    COUNT(*) FILTER (
        WHERE
            "City" IS NULL
    ) AS null_city,
    COUNT(*) FILTER (
        WHERE
            "State" IS NULL
    ) AS null_state,
    COUNT(*) FILTER (
        WHERE
            "Postal Code" IS NULL
    ) AS null_code,
    COUNT(*) FILTER (
        WHERE
            "Region" IS NULL
    ) AS null_region,
    COUNT(*) FILTER (
        WHERE
            "Product ID" IS NULL
    ) AS null_pID,
    COUNT(*) FILTER (
        WHERE
            "Category" IS NULL
    ) AS null_category,
    COUNT(*) FILTER (
        WHERE
            "Sub-Category" IS NULL
    ) AS null_scategory,
    COUNT(*) FILTER (
        WHERE
            "Product Name" IS NULL
    ) AS null_pname,
    COUNT(*) FILTER (
        WHERE
            "Sales" IS NULL
    ) AS null_sales,
    COUNT(*) FILTER (
        WHERE
            "Quantity" IS NULL
    ) AS null_quantity,
    COUNT(*) FILTER (
        WHERE
            "Discount" IS NULL
    ) AS null_discount,
    COUNT(*) FILTER (
        WHERE
            "Profit" IS NULL
    ) AS null_profit
FROM orders;
--no null or missing values
SELECT COUNT(*) FILTER (
        WHERE
            "Returned" IS NULL
    ) AS null_return, COUNT(*) FILTER (
        WHERE
            "Order ID" IS NULL
    ) AS null_rID
FROM returns;
-- no missing values from the returns table
SELECT *
FROM orders
WHERE
    "Quantity" < 0
    OR "Discount" < 0
    OR "Sales" < 0;
--no negative values

## All check have been done and we only have trailing or whitespace which we will correct
##create orders_staging table
CREATE TABLE IF NOT EXISTS orders_staging AS TABLE orders WITH NO DATA;

INSERT into orders_staging select * from orders;

UPDATE orders_staging
SET
    "Order ID" = TRIM("Order ID"),
    "Ship Mode" = TRIM("Ship Mode"),
    "Customer ID" = TRIM("Customer ID"),
    "Customer Name" = TRIM("Customer Name"),
    "Segment" = TRIM("Segment"),
    "Country" = TRIM("Country"),
    "City" = TRIM("City"),
    "State" = TRIM("State"),
    "Category" = TRIM("Category"),
    "Region" = TRIM("Region"),
    "Product ID" = TRIM("Product ID"),
    "Sub-Category" = TRIM("Sub-Category"),
    "Product Name" = TRIM("Product Name");
## check if the whitespace are stiil there
SELECT *
FROM orders_staging
WHERE "Order ID" <> TRIM ("Order ID")
        OR "Ship Mode" <> TRIM("Ship Mode")
        OR "Customer ID"<> TRIM("Customer ID")
        OR "Customer Name" <>  TRIM("Customer Name")
        OR "Segment" <> TRIM ("Segment")
        OR "Country" <> TRIM ("Country")
        OR "City" <> TRIM ("City")
        OR "State" <> TRIM ("State")
        OR "Category" <> TRIM ("Category")
        OR "Region" <> TRIM ("Region")
        OR "Product ID" <> TRIM ("Product ID")
        OR "Sub-Category" <> TRIM ("Sub-Category")
        OR "Product Name" <> TRIM ("Product Name");

select * from orders_staging limit 10;

select * from orders LIMIT 10;

select * from returns limit 10;

select * from managers;