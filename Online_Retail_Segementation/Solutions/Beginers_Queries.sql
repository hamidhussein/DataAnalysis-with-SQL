-- Beginner Queries.
USE onlineretail_info;
--  Define meta data in mysql workbench or any other SQL tool
 CREATE TABLE Retail(
   InvoiceNo   INTEGER  NOT NULL,
   StockCode   VARCHAR(16)  NOT NULL,
   Description VARCHAR(35), 
   Quantity    INTEGER,  
   InvoiceDate VARCHAR(35), 
   UnitPrice   NUMERIC(4,2), 
   CustomerID  NUMERIC,  
   Country     VARCHAR(14)
   
);
 --  What is the distribution of order values across all customers in the dataset?
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalOrderValue
FROM Retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalOrderValue DESC;



--      How many unique products has each customer purchased?
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProductsPurchased
FROM Retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY UniqueProductsPurchased DESC;



--      Which customers have only made TWO purchase from the company?
SELECT CustomerID, COUNT(InvoiceNo) AS PurchaseCount
FROM Retail
GROUP BY CustomerID
HAVING PurchaseCount = 2;


--      Which products are most commonly purchased together by customers in the datase
SELECT A.StockCode AS Product1, B.StockCode AS Product2, COUNT(*) AS PurchaseCount
FROM Retail A
JOIN Retail B ON A.InvoiceNo = B.InvoiceNo AND A.StockCode < B.StockCode
GROUP BY A.StockCode, B.StockCode
ORDER BY PurchaseCount DESC;
