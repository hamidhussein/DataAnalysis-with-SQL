-- 1.      Customer Segmentation by Purchase Frequency

-- Group customers into segments based on their purchase frequency, such as high, medium, and low frequency customers. This can help you identify your most loyal customers and those who need more attention.
SELECT
    CustomerID,
    CASE
        WHEN COUNT(InvoiceNo) > 10 THEN 'High'
        WHEN COUNT(InvoiceNo) > 5 THEN 'Medium'
        ELSE 'Low'
    END AS PurchaseFrequencySegment
FROM Retail
GROUP BY CustomerID;
-- 2. Average Order Value by Country

-- Calculate the average order value for each country to identify where your most valuable customers are located.
SELECT
    Country,
    AVG(Quantity * UnitPrice) AS AverageOrderValue
FROM Retail
GROUP BY Country;
-- 3. Customer Churn Analysis

--  Identify customers who haven't made a purchase in a specific period (e.g., last 6 months) to assess churn.
SELECT
    CustomerID,
    MAX(InvoiceDate) AS LastPurchaseDate,
    CASE
        WHEN MAX(InvoiceDate) < DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) THEN 'Churned'
        ELSE 'Active'
    END AS ChurnStatus
FROM Retail
GROUP BY CustomerID;
-- 4. Product Affinity Analysis

-- Determine which products are often purchased together by calculating the correlation between product purchases.
SELECT
    r1.StockCode AS Product1,
    r2.StockCode AS Product2,
    COUNT(*) AS PurchaseCount
FROM Retail r1
JOIN Retail r2 ON r1.InvoiceNo = r2.InvoiceNo AND r1.StockCode < r2.StockCode
GROUP BY r1.StockCode, r2.StockCode
ORDER BY PurchaseCount DESC;
-- 5. Time-based Analysis

--   Explore trends in customer behavior over time, such as monthly or quarterly sales patterns.

SELECT
    YEAR(InvoiceDate) AS SalesYear,
    MONTH(InvoiceDate) AS SalesMonth,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM Retail
GROUP BY SalesYear, SalesMonth
ORDER BY SalesYear, SalesMonth;












