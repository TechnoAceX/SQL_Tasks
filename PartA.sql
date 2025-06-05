-- 1. List all customers.
SELECT c.CustomerKey, c.FirstName, c.LastName, c.EmailAddress, c.Phone, c.DateFirstPurchase
FROM dbo.DimCustomer c;

-- 2. List all customers whose last name ends with 'N'.
SELECT c.CustomerKey, c.FirstName, c.LastName
FROM dbo.DimCustomer c
WHERE c.LastName LIKE '%N';


-- 3. List all customers who live in Berlin or London.
SELECT c.CustomerKey, c.FirstName, c.LastName, g.City, g.StateProvinceName, g.EnglishCountryRegionName
FROM dbo.DimCustomer c
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
WHERE g.City IN ('Berlin', 'London');


-- 4. List all customers who live in the UK or USA.
SELECT c.CustomerKey, c.FirstName, c.LastName, g.EnglishCountryRegionName
FROM dbo.DimCustomer c
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
WHERE g.EnglishCountryRegionName IN ('United Kingdom', 'United States');


-- 5. List all products sorted by product name.
SELECT ProductKey, EnglishProductName, Color, StandardCost, ListPrice
FROM dbo.DimProduct
ORDER BY EnglishProductName;


-- 6. List all products where the product name starts with 'A'.
SELECT ProductKey, EnglishProductName, Color, StandardCost, ListPrice
FROM dbo.DimProduct
WHERE EnglishProductName LIKE 'A%';


-- 7. List customers who have ever placed an order.
SELECT DISTINCT c.CustomerKey, c.FirstName, c.LastName
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey;


-- 8. List customers who live in London and have bought 'Chai'.
SELECT DISTINCT c.CustomerKey, c.FirstName, c.LastName
FROM dbo.DimCustomer c
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
WHERE g.City = 'London'
  AND p.EnglishProductName LIKE '%Chai%';


-- 9. List customers who never placed an order.
SELECT c.CustomerKey, c.FirstName, c.LastName
FROM dbo.DimCustomer c
LEFT JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
WHERE f.SalesOrderNumber IS NULL;


-- 10. List customers who ordered 'Tofu'.
SELECT DISTINCT c.CustomerKey, c.FirstName, c.LastName
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
WHERE p.EnglishProductName LIKE '%Tofu%';


-- 11. Get details of the first order in the system.
SELECT TOP 1 *
FROM dbo.FactInternetSales
ORDER BY OrderDateKey ASC;


-- 12. Get the date with the most expensive order(s).
SELECT TOP 1 OrderDateKey, SUM(SalesAmount) AS TotalSales
FROM dbo.FactInternetSales
GROUP BY OrderDateKey
ORDER BY TotalSales DESC;


-- 13. Get OrderID and average quantity of items for each order.
SELECT SalesOrderNumber AS OrderID, AVG(OrderQuantity) AS AvgQuantity
FROM dbo.FactInternetSales
GROUP BY SalesOrderNumber;


-- 14. Get OrderID, minimum quantity, and maximum quantity for each order.
SELECT SalesOrderNumber AS OrderID, MIN(OrderQuantity) AS MinQuantity, MAX(OrderQuantity) AS MaxQuantity
FROM dbo.FactInternetSales
GROUP BY SalesOrderNumber;


-- 15. Get a list of all managers and number of employees reporting to them.
SELECT 
    m.EmployeeKey AS ManagerKey,
    m.FirstName + ' ' + m.LastName AS ManagerName,
    COUNT(e.EmployeeKey) AS NumberOfEmployeesReporting
FROM dbo.DimEmployee e
JOIN dbo.DimEmployee m ON e.ParentEmployeeKey = m.EmployeeKey
GROUP BY m.EmployeeKey, m.FirstName, m.LastName
ORDER BY NumberOfEmployeesReporting DESC;


-- 16. Get OrderID and total quantity for each order where total quantity > 300.
SELECT SalesOrderNumber AS OrderID, SUM(OrderQuantity) AS TotalQuantity
FROM dbo.FactInternetSales
GROUP BY SalesOrderNumber
HAVING SUM(OrderQuantity) > 300;


-- 17. List all orders placed on or after December 31, 1996.
SELECT *
FROM dbo.FactInternetSales
WHERE OrderDateKey >= 19961231;


-- 18. List all orders shipped to Canada.
SELECT f.*
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
WHERE g.EnglishCountryRegionName = 'Canada';


-- 19. List all orders with order total greater than 200.
SELECT SalesOrderNumber, SUM(SalesAmount) AS OrderTotal
FROM dbo.FactInternetSales
GROUP BY SalesOrderNumber
HAVING SUM(SalesAmount) > 200;


-- 20. List countries and total sales made in each country.
SELECT g.EnglishCountryRegionName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName;


-- 21. List customer contact names and number of orders they placed.
SELECT c.FirstName + ' ' + c.LastName AS ContactName, COUNT(DISTINCT f.SalesOrderNumber) AS NumberOfOrders
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
GROUP BY c.FirstName, c.LastName;


-- 22. List customer contact names who have placed more than 3 orders.
SELECT c.FirstName + ' ' + c.LastName AS ContactName
FROM dbo.DimCustomer c
JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
GROUP BY c.FirstName, c.LastName
HAVING COUNT(DISTINCT f.SalesOrderNumber) > 3;


-- 23. Which products were ordered between 1/1/1997 and 1/1/1998?
SELECT DISTINCT p.ProductKey, p.EnglishProductName
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
WHERE f.OrderDateKey BETWEEN 19970101 AND 19980101;


-- 24. List employee first name, last name and their supervisor's first name, last name.
SELECT e.EmployeeKey, e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName,
       m.FirstName AS SupervisorFirstName, m.LastName AS SupervisorLastName
FROM dbo.DimEmployee e
LEFT JOIN dbo.DimEmployee m ON e.ParentEmployeeKey = m.EmployeeKey;


-- 25. Total sales conducted by each employee (via reseller sales)
SELECT e.EmployeeKey, e.FirstName, e.LastName, 
       SUM(r.SalesAmount) AS TotalSales
FROM dbo.FactResellerSales r
JOIN dbo.DimEmployee e ON r.EmployeeKey = e.EmployeeKey
GROUP BY e.EmployeeKey, e.FirstName, e.LastName
ORDER BY TotalSales DESC;



-- 26. List employees whose first name contains the character 'a'.
SELECT EmployeeKey, FirstName, LastName
FROM dbo.DimEmployee
WHERE FirstName LIKE '%a%';


-- 27. List managers who have more than four people reporting to them.
SELECT m.EmployeeKey AS ManagerKey, m.FirstName + ' ' + m.LastName AS ManagerName,
       COUNT(e.EmployeeKey) AS NumberOfReports
FROM dbo.DimEmployee e
JOIN dbo.DimEmployee m ON e.ParentEmployeeKey = m.EmployeeKey
GROUP BY m.EmployeeKey, m.FirstName, m.LastName
HAVING COUNT(e.EmployeeKey) > 4;


-- 28. List orders and product names.
SELECT f.SalesOrderNumber, p.EnglishProductName
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey;


-- 29. List orders placed by the best customer.
WITH CustomerSales AS (
  SELECT CustomerKey, SUM(SalesAmount) AS TotalSales
  FROM dbo.FactInternetSales
  GROUP BY CustomerKey
),
BestCustomer AS (
  SELECT TOP 1 CustomerKey
  FROM CustomerSales
  ORDER BY TotalSales DESC
)
SELECT f.*
FROM dbo.FactInternetSales f
JOIN BestCustomer bc ON f.CustomerKey = bc.CustomerKey;


-- 30. List orders placed by customers who do not have a fax number.
SELECT f.SalesOrderNumber, f.OrderDateKey, c.FirstName, c.LastName
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
WHERE c.Phone IS NULL OR c.Phone = '';


-- 31. List postal codes where the product 'Tofu' was shipped.
SELECT DISTINCT g.PostalCode
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
WHERE p.EnglishProductName LIKE '%Tofu%';


-- 32. List product names that were shipped to France.
SELECT DISTINCT p.EnglishProductName
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
WHERE g.EnglishCountryRegionName = 'France';


-- 33. List of Product Names and Categories available in the system.
SELECT p.EnglishProductName AS ProductName,
       pc.EnglishProductCategoryName AS CategoryName
FROM dbo.DimProduct p
LEFT JOIN dbo.DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY CategoryName, ProductName;


-- 34. List products that were never ordered.
SELECT p.ProductKey, p.EnglishProductName
FROM dbo.DimProduct p
LEFT JOIN dbo.FactInternetSales f ON p.ProductKey = f.ProductKey
WHERE f.SalesOrderNumber IS NULL;


-- 35. List products where units in stock are less than 10 and units on order are 0.
SELECT ProductKey, EnglishProductName, SafetyStockLevel, ReorderPoint
FROM dbo.DimProduct
WHERE SafetyStockLevel < 100 AND ReorderPoint = 0;


-- 36. List top 10 countries by sales.
SELECT TOP 10 g.EnglishCountryRegionName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName
ORDER BY TotalSales DESC;


-- 37. Number of orders each employee has taken for customers with CustomerIDs between 'AW00011000' and 'AW00011020'
SELECT c.CustomerAlternateKey, COUNT(f.SalesOrderNumber) AS TotalOrders
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
WHERE c.CustomerAlternateKey BETWEEN 'AW00011000' AND 'AW00011020'
GROUP BY c.CustomerAlternateKey;


-- 38. Order date of the most expensive order.
SELECT TOP 1 OrderDateKey, SUM(SalesAmount) AS TotalSales
FROM dbo.FactInternetSales
GROUP BY OrderDateKey
ORDER BY TotalSales DESC;


-- 39. Product name and total revenue from that product.
SELECT p.EnglishProductName, SUM(f.SalesAmount) AS TotalRevenue
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalRevenue DESC;


-- 40. Supplier ID and number of products offered.
SELECT pc.EnglishProductCategoryName AS Category,
       COUNT(p.ProductKey) AS ProductCount
FROM dbo.DimProduct p
JOIN dbo.DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN dbo.DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName
ORDER BY ProductCount DESC;


-- 41. Top ten customers based on their total business (sales amount).
SELECT TOP 10 c.CustomerKey, c.FirstName, c.LastName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName
ORDER BY TotalSales DESC;


-- 42. What is the total revenue of the company?
SELECT SUM(SalesAmount) AS TotalRevenue
FROM dbo.FactInternetSales;
