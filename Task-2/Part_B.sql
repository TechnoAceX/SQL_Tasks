-- Q1: Customers who purchased more than 5 products in a single order

SELECT 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
GROUP BY c.FirstName, c.LastName, c.EmailAddress, f.SalesOrderNumber
HAVING SUM(f.OrderQuantity) > 5;

-- Q2: Customers who have placed more than 3 orders

SELECT 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress,
    COUNT(DISTINCT f.SalesOrderNumber) AS TotalOrders
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
GROUP BY c.FirstName, c.LastName, c.EmailAddress
HAVING COUNT(DISTINCT f.SalesOrderNumber) > 3;

-- Q3: Customers who placed orders in 2010

SELECT DISTINCT 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
WHERE LEFT(CAST(f.OrderDateKey AS VARCHAR), 4) = '2010';

-- Q4: Top 5 customers by total purchase amount

SELECT TOP 5 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress,
    SUM(f.SalesAmount) AS TotalSpent
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
GROUP BY c.FirstName, c.LastName, c.EmailAddress
ORDER BY TotalSpent DESC;

-- Q5: Products which were never sold

SELECT 
    p.ProductKey, 
    p.EnglishProductName
FROM dbo.DimProduct p
LEFT JOIN dbo.FactInternetSales f ON p.ProductKey = f.ProductKey
WHERE f.ProductKey IS NULL;

-- Q6: Total quantity sold for each product

SELECT 
    p.EnglishProductName, 
    SUM(f.OrderQuantity) AS TotalQuantitySold
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName;

-- Q7: Product name and revenue generated

SELECT 
    p.EnglishProductName, 
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY Revenue DESC;

-- Q8: Countries and the number of customers from each

SELECT 
    g.EnglishCountryRegionName AS Country,
    COUNT(DISTINCT c.CustomerKey) AS NumberOfCustomers
FROM dbo.DimCustomer c
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName
ORDER BY NumberOfCustomers DESC;

-- Q9: Orders where total quantity > 100

SELECT 
    f.SalesOrderNumber, 
    SUM(f.OrderQuantity) AS TotalQuantity
FROM dbo.FactInternetSales f
GROUP BY f.SalesOrderNumber
HAVING SUM(f.OrderQuantity) > 100;
