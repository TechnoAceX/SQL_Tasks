--  Task 14: Headcount by Sub-band with Percentage (No JOIN, Subquery, or Inner Query)

CREATE TABLE Employees (
    emp_id INT,
    sub_band VARCHAR(10)
);

INSERT INTO Employees VALUES
(1, 'A1'), (2, 'A1'), (3, 'A2'), (4, 'B1'), (5, 'B1'), (6, 'B1');

-- Using COUNT + GROUP BY with window function
SELECT sub_band,
       COUNT(*) AS headcount,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Employees
GROUP BY sub_band;
