-- TASK 11: Friends with Higher Salary

-- Students Table
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(100)
);

INSERT INTO Students VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Belvet');

-- Friends Table
CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

INSERT INTO Friends VALUES  
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Packages Table
CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

INSERT INTO Packages VALUES
(1, 15.20),
(2, 20.50),
(3, 18.50),
(4, 10.00);

-- Final SQL Query

SELECT S.Name
FROM Students S
JOIN Friends F ON S.ID = F.ID
JOIN Packages SP ON S.ID = SP.ID
JOIN Packages FP ON F.Friend_ID = FP.ID
WHERE FP.Salary > SP.Salary
ORDER BY FP.Salary;


