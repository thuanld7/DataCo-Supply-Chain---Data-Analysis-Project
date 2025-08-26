-- Data Cleaning & Normalization

SELECT TOP 10 * 
FROM DataCoSC_Raw

-- Create a copy table similar to the Raw version
SELECT *
INTO DataCoSC
FROM DataCoSC_Raw;

SELECT * 
FROM DataCoSC;

-- 1. Remove Duplicates

WITH duplicate_cte AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY transaction_type,shipping_days_real,shipping_days_scheduled,profit_per_order,
           sales_per_customer,delivery_status,is_late,category_id,category_name,customer_city,customer_country,customer_first_name,
           customer_id,customer_last_name,customer_segment,customer_state,customer_street,department_id,department_name,latitude,
           longitude,market,order_city,order_country,order_customer_id,order_date,order_id,order_item_cardprod_id,order_item_discount,
           order_item_discount_rate,order_item_id,order_item_product_price,order_item_profit_ratio,order_item_quantity,
           order_total_product_price,order_discounted_price,order_profit,order_region,order_state,order_status,product_card_id,
           product_category_id,product_name,product_price,product_status,shipping_date,shipping_mode ORDER BY(SELECT NULL)) AS rn
    FROM DataCoSC
)
DELETE FROM duplicate_cte WHERE rn > 1;

-- 2. Standardize data

-- Checking extra right/left space
SELECT customer_first_name
FROM DataCoSC
WHERE  DATALENGTH(customer_first_name) <>  DATALENGTH(LTRIM(RTRIM(customer_first_name)));

SELECT customer_last_name
FROM DataCoSC
WHERE  DATALENGTH(customer_last_name) <>  DATALENGTH(LTRIM(RTRIM(customer_last_name)));

SELECT customer_street
FROM DataCoSC
WHERE  DATALENGTH(customer_street) <>  DATALENGTH(LTRIM(RTRIM(customer_street)));

UPDATE DataCoSC
SET customer_street = LTRIM(RTRIM(customer_street));

SELECT product_name
FROM DataCoSC
WHERE  DATALENGTH(product_name) <>  DATALENGTH(LTRIM(RTRIM(product_name)));

UPDATE DataCoSC
SET product_name = LTRIM(RTRIM(product_name));

SELECT department_name
FROM DataCoSC
WHERE  DATALENGTH(department_name) <>  DATALENGTH(LTRIM(RTRIM(department_name)));

UPDATE DataCoSC
SET department_name = LTRIM(RTRIM(department_name));

-- Checking extra spaces between words
SELECT *
FROM DataCoSC
WHERE customer_street LIKE '%  %'
ORDER BY customer_street

UPDATE DataCoSC
SET customer_first_name = REPLACE(LTRIM(RTRIM(customer_first_name)), '  ', ' ');

SELECT *
FROM DataCoSC
WHERE category_name LIKE '%  %'
ORDER BY category_name;

UPDATE DataCoSC
SET category_name = REPLACE(LTRIM(RTRIM(category_name)), '  ', ' ');

SELECT *
FROM DataCoSC
WHERE order_region LIKE '%  %'
ORDER BY order_region;

UPDATE DataCoSC
SET order_region = REPLACE(LTRIM(RTRIM(order_region)), '  ', ' ');

-- Change country name to common form (EE. UU. to US, ...)
SELECT DISTINCT customer_country
FROM DataCoSC
ORDER BY customer_country;

UPDATE DataCoSC
SET customer_country = 'US'
WHERE customer_country = 'EE. UU.';

SELECT DISTINCT order_country
FROM DataCoSC
ORDER BY order_country;

UPDATE DataCoSC SET order_country = 'Afghanistan' WHERE order_country = 'Afganist?n';
UPDATE DataCoSC SET order_country = 'Germany' WHERE order_country = 'Alemania';
UPDATE DataCoSC SET order_country = 'Saudi Arabia' WHERE order_country = 'Arabia Saud?';
UPDATE DataCoSC SET order_country = 'Algeria' WHERE order_country = 'Argelia';
UPDATE DataCoSC SET order_country = 'Azerbaijan' WHERE order_country = 'Azerbaiy?n';
UPDATE DataCoSC SET order_country = 'Belgium' WHERE order_country = 'B?lgica';
UPDATE DataCoSC SET order_country = 'Bangladesh' WHERE order_country = 'Banglad?s';
UPDATE DataCoSC SET order_country = 'Bahrain' WHERE order_country = 'Bar?in';
UPDATE DataCoSC SET order_country = 'Benin' WHERE order_country = 'Ben?n';
UPDATE DataCoSC SET order_country = 'Belarus' WHERE order_country = 'Bielorrusia';
UPDATE DataCoSC SET order_country = 'Bosnia and Herzegovina' WHERE order_country = 'Bosnia y Herzegovina';
UPDATE DataCoSC SET order_country = 'Botswana' WHERE order_country = 'Botsuana';
UPDATE DataCoSC SET order_country = 'Brazil' WHERE order_country = 'Brasil';
UPDATE DataCoSC SET order_country = 'Bhutan' WHERE order_country = 'But?n';
UPDATE DataCoSC SET order_country = 'Cambodia' WHERE order_country = 'Camboya';
UPDATE DataCoSC SET order_country = 'Cameroon' WHERE order_country = 'Camer?n';
UPDATE DataCoSC SET order_country = 'South Korea' WHERE order_country = 'Corea del Sur';
UPDATE DataCoSC SET order_country = 'Ivory Coast' WHERE order_country = 'Costa de Marfil';
UPDATE DataCoSC SET order_country = 'Croatia' WHERE order_country = 'Croacia';
UPDATE DataCoSC SET order_country = 'Denmark' WHERE order_country = 'Dinamarca';
UPDATE DataCoSC SET order_country = 'Egypt' WHERE order_country = 'Egipto';
UPDATE DataCoSC SET order_country = 'UAE' WHERE order_country = 'Emiratos ?rabes Unidos';
UPDATE DataCoSC SET order_country = 'Slovakia' WHERE order_country = 'Eslovaquia';
UPDATE DataCoSC SET order_country = 'Slovenia' WHERE order_country = 'Eslovenia';
UPDATE DataCoSC SET order_country = 'Spain' WHERE order_country = 'Espa?a';
UPDATE DataCoSC SET order_country = 'US' WHERE order_country = 'Estados Unidos';
UPDATE DataCoSC SET order_country = 'Ethiopia' WHERE order_country = 'Etiop?a';
UPDATE DataCoSC SET order_country = 'France' WHERE order_country = 'Francia';
UPDATE DataCoSC SET order_country = 'Gabon' WHERE order_country = 'Gab?n';
UPDATE DataCoSC SET order_country = 'Greece' WHERE order_country = 'Grecia';
UPDATE DataCoSC SET order_country = 'Guadeloupe' WHERE order_country = 'Guadalupe';
UPDATE DataCoSC SET order_country = 'French Guiana' WHERE order_country = 'Guayana Francesa';
UPDATE DataCoSC SET order_country = 'Haiti' WHERE order_country = 'Hait?';
UPDATE DataCoSC SET order_country = 'Hungary' WHERE order_country = 'Hungr?a';
UPDATE DataCoSC SET order_country = 'Iran' WHERE order_country = 'Ir?n';
UPDATE DataCoSC SET order_country = 'Iraq' WHERE order_country = 'Irak';
UPDATE DataCoSC SET order_country = 'Ireland' WHERE order_country = 'Irlanda';
UPDATE DataCoSC SET order_country = 'Italy' WHERE order_country = 'Italia';
UPDATE DataCoSC SET order_country = 'Japan' WHERE order_country = 'Jap?n';
UPDATE DataCoSC SET order_country = 'Jordan' WHERE order_country = 'Jordania';
UPDATE DataCoSC SET order_country = 'Kazakhstan' WHERE order_country = 'Kazajist?n';
UPDATE DataCoSC SET order_country = 'Kenya' WHERE order_country = 'Kenia';
UPDATE DataCoSC SET order_country = 'Kyrgyzstan' WHERE order_country = 'Kirguist?n';
UPDATE DataCoSC SET order_country = 'Lebanon' WHERE order_country = 'L?bano';
UPDATE DataCoSC SET order_country = 'Libya' WHERE order_country = 'Libia';
UPDATE DataCoSC SET order_country = 'Lithuania' WHERE order_country = 'Lituania';
UPDATE DataCoSC SET order_country = 'Luxembourg' WHERE order_country = 'Luxemburgo';
UPDATE DataCoSC SET order_country = 'Mexico' WHERE order_country = 'M?xico';
UPDATE DataCoSC SET order_country = 'Malaysia' WHERE order_country = 'Malasia';
UPDATE DataCoSC SET order_country = 'Morocco' WHERE order_country = 'Marruecos';
UPDATE DataCoSC SET order_country = 'Martinique' WHERE order_country = 'Martinica';
UPDATE DataCoSC SET order_country = 'Moldova' WHERE order_country = 'Moldavia';
UPDATE DataCoSC SET order_country = 'Myanmar' WHERE order_country = 'Myanmar (Birmania)';
UPDATE DataCoSC SET order_country = 'Niger' WHERE order_country = 'N?ger';
UPDATE DataCoSC SET order_country = 'New Zealand' WHERE order_country = 'Nueva Zelanda';
UPDATE DataCoSC SET order_country = 'Oman' WHERE order_country = 'Om?n';
UPDATE DataCoSC SET order_country = 'Netherlands' WHERE order_country = 'Pa?ses Bajos';
UPDATE DataCoSC SET order_country = 'Pakistan' WHERE order_country = 'Pakist?n';
UPDATE DataCoSC SET order_country = 'Panama' WHERE order_country = 'Panam?';
UPDATE DataCoSC SET order_country = 'Papua New Guinea' WHERE order_country = 'Pap?a Nueva Guinea';
UPDATE DataCoSC SET order_country = 'Peru' WHERE order_country = 'Per?';
UPDATE DataCoSC SET order_country = 'Poland' WHERE order_country = 'Polonia';
UPDATE DataCoSC SET order_country = 'UK' WHERE order_country = 'Reino Unido';
UPDATE DataCoSC SET order_country = 'Central African Republic' WHERE order_country = 'Rep?blica Centroafricana';
UPDATE DataCoSC SET order_country = 'Czech Republic' WHERE order_country = 'Rep?blica Checa';
UPDATE DataCoSC SET order_country = 'Gambia' WHERE order_country = 'Rep?blica de Gambia';
UPDATE DataCoSC SET order_country = 'Republic of the Congo' WHERE order_country = 'Rep?blica del Congo';
UPDATE DataCoSC SET order_country = 'DR Congo' WHERE order_country = 'Rep?blica Democr?tica del Congo';
UPDATE DataCoSC SET order_country = 'Dominican Republic' WHERE order_country = 'Rep?blica Dominicana';
UPDATE DataCoSC SET order_country = 'Romania' WHERE order_country = 'Rumania';
UPDATE DataCoSC SET order_country = 'Russia' WHERE order_country = 'Rusia';
UPDATE DataCoSC SET order_country = 'Western Sahara' WHERE order_country = 'S?hara Occidental';
UPDATE DataCoSC SET order_country = 'Sierra Leone' WHERE order_country = 'Sierra Leona';
UPDATE DataCoSC SET order_country = 'Singapore' WHERE order_country = 'Singapur';
UPDATE DataCoSC SET order_country = 'Syria' WHERE order_country = 'Siria';
UPDATE DataCoSC SET order_country = 'Eswatini' WHERE order_country = 'Suazilandia';
UPDATE DataCoSC SET order_country = 'Sudan' WHERE order_country = 'Sud?n';
UPDATE DataCoSC SET order_country = 'South Sudan' WHERE order_country = 'Sud?n del Sur';
UPDATE DataCoSC SET order_country = 'South Africa' WHERE order_country = 'SudAfrica';
UPDATE DataCoSC SET order_country = 'Sweden' WHERE order_country = 'Suecia';
UPDATE DataCoSC SET order_country = 'Switzerland' WHERE order_country = 'Suiza';
UPDATE DataCoSC SET order_country = 'Suriname' WHERE order_country = 'Surinam';
UPDATE DataCoSC SET order_country = 'Tunisia' WHERE order_country = 'T?nez';
UPDATE DataCoSC SET order_country = 'Thailand' WHERE order_country = 'Tailandia';
UPDATE DataCoSC SET order_country = 'Taiwan' WHERE order_country = 'Taiw?n';
UPDATE DataCoSC SET order_country = 'Tajikistan' WHERE order_country = 'Tayikist?n';
UPDATE DataCoSC SET order_country = 'Trinidad and Tobago' WHERE order_country = 'Trinidad y Tobago';
UPDATE DataCoSC SET order_country = 'Turkmenistan' WHERE order_country = 'Turkmenist?n';
UPDATE DataCoSC SET order_country = 'Turkey' WHERE order_country = 'Turqu?a';
UPDATE DataCoSC SET order_country = 'Ukraine' WHERE order_country = 'Ucrania';
UPDATE DataCoSC SET order_country = 'Uzbekistan' WHERE order_country = 'Uzbekist?n';
UPDATE DataCoSC SET order_country = 'Djibouti' WHERE order_country = 'Yibuti';
UPDATE DataCoSC SET order_country = 'Zimbabwe' WHERE order_country = 'Zimbabue';
UPDATE DataCoSC SET order_country = 'Belize' WHERE order_country = 'Belice';
UPDATE DataCoSC SET order_country = 'Cyprus' WHERE order_country = 'Chipre';
UPDATE DataCoSC SET order_country = 'Philippines' WHERE order_country = 'Filipinas';
UPDATE DataCoSC SET order_country = 'Finland' WHERE order_country = 'Finlandia';
UPDATE DataCoSC SET order_country = 'Equatorial Guinea' WHERE order_country = 'Guinea Ecuatorial';
UPDATE DataCoSC SET order_country = 'Lesotho' WHERE order_country = 'Lesoto';
UPDATE DataCoSC SET order_country = 'Norway' WHERE order_country = 'Noruega';
UPDATE DataCoSC SET order_country = 'Rwanda' WHERE order_country = 'Ruanda';

-- Combine customer's first and last name into a full name
ALTER TABLE DataCoSC
ADD customer_name NVARCHAR(255);

UPDATE DataCoSC
SET customer_name = LTRIM(RTRIM(ISNULL(customer_first_name, ''))) + ' ' + LTRIM(RTRIM(ISNULL(customer_last_name, '')));

ALTER TABLE DataCoSC
DROP COLUMN customer_first_name, customer_last_name;

-- Standardize data types in date columns
ALTER TABLE DataCoSC
ALTER COLUMN order_date DATE;

ALTER TABLE DataCoSC
ALTER COLUMN shipping_date DATE;

-- Next, we split the pivot table into Dim and Fact tables
-- DimCustomer
SELECT DISTINCT customer_id,
				customer_name,
				customer_segment,
				customer_country,
				customer_state,
				customer_city,
				customer_street
INTO DimCustomer
FROM DataCoSC;

SELECT *
FROM DimCustomer;

-- DimProduct
SELECT DISTINCT product_card_id,
				product_name,
				product_price,
				product_status,
				category_id,
				category_name
INTO DimProduct
FROM DataCoSC;

SELECT *
FROM DimProduct;

-- DimStore
SELECT  ROW_NUMBER() OVER(ORDER BY department_id, market, order_region, order_state, order_country, order_city) AS location_id,
		latitude,
		longitude,
		department_id,
		department_name,
		market,
		order_region,
		order_state,
		order_country,
		order_city
INTO DimStore
FROM (SELECT DISTINCT
        latitude,
        longitude,
        department_id,
        department_name,
        market,
        order_city,
        order_country,
        order_region,
        order_state
    FROM DataCoSC) as TEMP;

SELECT *
FROM DimStore;

-- DimDate
DECLARE @StartDate DATE, @EndDate DATE;

SELECT 
    @StartDate = MIN(order_date),
    @EndDate   = MAX(shipping_date)
FROM DataCoSC;

WITH DateRange AS (
    SELECT @StartDate AS DateValue
    UNION ALL
    SELECT DATEADD(day, 1, DateValue)
    FROM DateRange
    WHERE DateValue < @EndDate
)
SELECT 
    DateValue AS [date],                      
    YEAR(DateValue) AS [year],
    DATEPART(QUARTER, DateValue) AS [quarter],
    MONTH(DateValue) AS [month],
    DATENAME(MONTH, DateValue) AS [month_name],
    DATEPART(WEEK, DateValue) AS [weeknumber],
    DAY(DateValue) AS [day],
    DATENAME(WEEKDAY, DateValue) AS [day_name]
INTO DimDate
FROM DateRange
OPTION (MAXRECURSION 0);

SELECT *
FROM DimDate;

-- FactTransaction
SELECT
    dtc.order_id,
    dtc.order_date,
    dtc.shipping_date,
    dtc.shipping_mode,
    dtc.shipping_days_scheduled,
    dtc.shipping_days_real,
    dtc.delivery_status,
    dtc.is_late,
    dtc.transaction_type,
    dtc.order_status,
    dtc.order_customer_id,
    ds.location_id,
    dtc.order_item_cardprod_id,
    dtc.order_item_id,
    dtc.order_item_product_price,
    dtc.order_item_quantity,
    dtc.order_total_product_price,
    dtc.order_item_discount,
    dtc.order_item_discount_rate,
    dtc.order_discounted_price,
    dtc.order_item_profit_ratio,
    dtc.order_profit
INTO FactTransaction
FROM DataCoSC AS dtc
LEFT JOIN DimStore AS ds
    ON dtc.latitude = ds.latitude
   AND dtc.longitude = ds.longitude
   AND dtc.department_id = ds.department_id
   AND dtc.market = ds.market
   AND dtc.order_region = ds.order_region
   AND dtc.order_state = ds.order_state
   AND dtc.order_country = ds.order_country
   AND dtc.order_city = ds.order_city;

SELECT *
FROM FactTransaction;

-- Exploratory Data Analysis
-- Total order volume, average revenue, average profit and average profit ratio, late delivery rate
SELECT 	COUNT(DISTINCT order_id) AS Total_order_volume,
		ROUND(SUM(order_total_product_price), 2) AS Total_Revenue,
		ROUND(SUM(order_profit), 2) AS Total_Profit,
		ROUND(SUM(order_profit)*1.0/SUM(order_total_product_price), 2) AS AvgProfitRatio,
		ROUND(SUM(is_late)*1.0/COUNT(*), 2) AS Late_delivery_rate
FROM FactTransaction;

-- Revenue by year and quarter
SELECT 
	d.year,
	d.quarter,
	ROUND(SUM(ft.order_total_product_price), 2) AS Revenue,
	ROUND(SUM(ft.order_profit), 2) AS Profit,
	ROUND(SUM(ft.order_profit)*1.0/SUM(ft.order_total_product_price), 2) AS ProfitMargin
FROM FactTransaction ft
JOIN DimDate d ON ft.order_date = d.date
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- Late delivery rates
SELECT 
    is_late,
    COUNT(*) AS NumOrders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS LatePercent
FROM FactTransaction
GROUP BY is_late;

-- Average delivery time
SELECT 
    AVG(shipping_days_real) AS AvgShippingDays,
    AVG(shipping_days_scheduled) AS AvgScheduledDays
FROM FactTransaction;

-- Number and revenue of orders by customer segment
SELECT 
    c.customer_segment,
    COUNT(DISTINCT ft.order_id) AS NumOrders,
    ROUND(SUM(ft.order_total_product_price), 0) AS Revenue
FROM FactTransaction ft
JOIN DimCustomer c ON ft.order_customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY Revenue DESC;

-- Number and revenue of orders by shipping mode
SELECT 
    shipping_mode,
    COUNT(DISTINCT order_id) AS NumOrders,
    ROUND(SUM(order_total_product_price), 0) AS Revenue
FROM FactTransaction
GROUP BY shipping_mode
ORDER BY Revenue DESC;

-- Identify VIP customer groups
SELECT
    dc.customer_id,
    dc.customer_name,
    ROUND(SUM(ft.order_total_product_price), 2) AS TotalSpent,
    ROUND(SUM(ft.order_profit), 2) AS TotalProfit,
    COUNT(DISTINCT ft.order_id) AS TotalOrders
FROM FactTransaction ft
JOIN DimCustomer dc
    ON ft.order_customer_id = dc.customer_id
GROUP BY dc.customer_id, dc.customer_name
HAVING ROUND(SUM(ft.order_profit), 2) >= 1500
ORDER BY TotalProfit DESC;

-- Percentage contribution of each market
SELECT
    market,
    Revenue,
    Profit,
    ROUND(Revenue * 100.0 / SUM(Revenue) OVER (), 1) AS RevenuePercent
FROM (
    SELECT 
        s.market,
        ROUND(SUM(ft.order_total_product_price), 0) AS Revenue,
        ROUND(SUM(ft.order_profit), 0) AS Profit
    FROM FactTransaction ft
    JOIN DimStore s ON ft.location_id = s.location_id
    GROUP BY s.market
) t
ORDER BY Revenue DESC;

-- Top Product according to Pareto law (80-20) by Profit
WITH ProductRevenue AS (
SELECT 
    dp.product_name,
    dp.category_name,
    ROUND(SUM(ft.order_profit), 0) AS TotalProfit
FROM FactTransaction ft
JOIN DimProduct dp 
    ON ft.order_item_cardprod_id = dp.product_card_id
GROUP BY dp.product_name, dp.category_name
),
Ranked AS (
    SELECT 
        product_name,
        category_name,
        TotalProfit,
        SUM(TotalProfit) OVER () AS GrandTotal,
        SUM(TotalProfit) OVER (ORDER BY TotalProfit DESC) AS CumProfit
    FROM ProductRevenue
)
SELECT *
FROM (
    SELECT 
        product_name,
        category_name,
        TotalProfit,
        ROUND(TotalProfit * 100.0 / GrandTotal, 2) AS PercentOfTotal,
        ROUND(CumProfit * 100.0 / GrandTotal, 2) AS CumPercent
    FROM Ranked
) t
WHERE CumPercent <= 80
ORDER BY TotalProfit DESC;

-- Top Category according to Pareto law (80-20) by Profit
WITH CategoryRevenue AS (
    SELECT 
        dp.category_name,
        ROUND(SUM(ft.order_profit), 0) AS TotalProfit
    FROM FactTransaction ft
    JOIN DimProduct dp
        ON ft.order_item_cardprod_id = dp.product_card_id
    GROUP BY dp.category_name
),
Ranked AS (
    SELECT 
        category_name,
        TotalProfit,
        SUM(TotalProfit) OVER () AS GrandTotal,
        SUM(TotalProfit) OVER (ORDER BY TotalProfit DESC) AS CumProfit
    FROM CategoryRevenue
)
SELECT *
FROM (
    SELECT 
        category_name,
        TotalProfit,
        ROUND(TotalProfit * 100.0 / GrandTotal, 2) AS PercentOfTotal,
        ROUND(CumProfit * 100.0 / GrandTotal, 2) AS CumPercent
    FROM Ranked
) t
WHERE CumPercent <= 80
ORDER BY TotalProfit DESC;

-- Top Country according to Pareto law (80-20) by Profit
WITH ProductRevenue AS (
SELECT 
    ds.market,
    ds.order_country,
    ROUND(SUM(ft.order_profit), 2) AS TotalProfit
FROM FactTransaction ft
JOIN DimStore ds
    ON ft.location_id = ds.location_id
GROUP BY ds.market, ds.order_country
),
Ranked AS (
    SELECT 
        market,
        order_country,
        TotalProfit,
        SUM(TotalProfit) OVER () AS GrandTotal,
        SUM(TotalProfit) OVER (ORDER BY TotalProfit DESC) AS CumProfit
    FROM ProductRevenue
)
SELECT *
FROM (
    SELECT 
        market,
        order_country,
        TotalProfit,
        ROUND(TotalProfit * 100.0 / GrandTotal, 2) AS PercentOfTotal,
        ROUND(CumProfit * 100.0 / GrandTotal, 2) AS CumPercent
    FROM Ranked
) t
WHERE CumPercent <= 80
ORDER BY TotalProfit DESC;

SELECT *
FROM FactTransaction;