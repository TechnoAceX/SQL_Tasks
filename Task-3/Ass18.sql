-- Task 18: Weighted Average Cost Month-wise
CREATE TABLE EmployeeCost (
    bu VARCHAR(20),
    month VARCHAR(20),
    employee_id INT,
    cost DECIMAL(10,2),
    weight DECIMAL(10,2)
);

INSERT INTO EmployeeCost VALUES
('HR', 'Jan', 1, 10000, 1),
('HR', 'Jan', 2, 15000, 2),
('HR', 'Feb', 1, 12000, 1),
('HR', 'Feb', 2, 18000, 2);

-- Weighted average = SUM(cost * weight) / SUM(weight)
SELECT bu, month,
       ROUND(SUM(cost * weight) / SUM(weight), 2) AS weighted_avg_cost
FROM EmployeeCost
GROUP BY bu, month;
