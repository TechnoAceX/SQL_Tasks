-- 1. Question: Recyclable and Low Fat Products
-- https://leetcode.com/problems/recyclable-and-low-fat-products/
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- 2. Question: Customers Who Never Order
-- https://leetcode.com/problems/customers-who-never-order/
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders);

-- 3. Question: Employee Bonus
-- https://leetcode.com/problems/employee-bonus/
SELECT name, bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE bonus < 1000 OR bonus IS NULL;

-- 4. Question: Find Customer Referee
-- https://leetcode.com/problems/find-customer-referee/
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

-- 5. Question: Fix Names in a Table
-- https://leetcode.com/problems/fix-names-in-a-table/
SELECT user_id,
       CONCAT(UPPER(LEFT(name,1)), LOWER(SUBSTRING(name,2))) AS name
FROM Users;
