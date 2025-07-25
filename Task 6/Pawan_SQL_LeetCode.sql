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

-- 6. Question: Rising Temperature
-- https://leetcode.com/problems/rising-temperature/
SELECT w1.id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;

-- 7. Question: Classes More Than 5 Students
-- https://leetcode.com/problems/classes-more-than-5-students/
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- 8. Question: Employees Earning More Than Their Managers
-- https://leetcode.com/problems/employees-earning-more-than-their-managers/
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

-- 9. Question: Duplicate Emails
-- https://leetcode.com/problems/duplicate-emails/
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- 10. Question: Second Highest Salary
-- https://leetcode.com/problems/second-highest-salary/
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- 11. Question: Nth Highest Salary
-- https://leetcode.com/problems/nth-highest-salary/
-- (For N = 1, as example)
SELECT DISTINCT salary AS NthHighestSalary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 0;

-- 12. Question: Not Boring Movies
-- https://leetcode.com/problems/not-boring-movies/
SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

-- 13. Question: Project Employees I
-- https://leetcode.com/problems/project-employees-i/
SELECT project_id, employee_id
FROM Project
WHERE (project_id, employee_id) IN (
  SELECT project_id, employee_id
  FROM Project
  GROUP BY project_id, employee_id
);

-- 14. Question: Average Time of Process per Machine
-- https://leetcode.com/problems/average-time-of-process-per-machine/
SELECT machine_id, ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM Activity
WHERE activity_type = 'end'
GROUP BY machine_id;

-- 15. Question: Calculate Special Bonus
-- https://leetcode.com/problems/calculate-special-bonus/
SELECT employee_id,
       CASE WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary ELSE 0 END AS bonus
FROM Employees
ORDER BY employee_id;
