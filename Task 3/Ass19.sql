-- Task 19: Average Salary Error with '0' Removed

CREATE TABLE EMPLOYEES (
    emp_id INT,
    salary INT
);

INSERT INTO EMPLOYEES VALUES
(1, 1000),
(2, 2000),
(3, 3000);

-- Query
SELECT CEIL(AVG(salary) - AVG(CAST(REPLACE(CAST(salary AS VARCHAR), '0', '') AS INT))) AS avg_diff
FROM EMPLOYEES;
