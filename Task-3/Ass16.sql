-- Task 15: Top 5 Employees by Salary (Without ORDER BY)

CREATE TABLE Emp_Salary (
    emp_id INT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO Emp_Salary VALUES
(1, 'A', 80000), (2, 'B', 90000), (3, 'C', 100000),
(4, 'D', 95000), (5, 'E', 70000), (6, 'F', 60000);

-- Using DENSE_RANK without ORDER BY
SELECT emp_id, name, salary
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Emp_Salary
) AS ranked
WHERE rnk <= 5;

