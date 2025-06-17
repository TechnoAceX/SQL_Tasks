-- Tas2: Query to find students whose friends have higher salaries

-- Students table
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(100)
);

INSERT INTO Students (ID, Name) VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Friends table
CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

INSERT INTO Friends (ID, Friend_ID) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Packages table
CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

INSERT INTO Packages (ID, Salary) VALUES
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);

-- Query to find students whose friends have higher salaries
SELECT s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages p1 ON s.ID = p1.ID
JOIN Packages p2 ON f.Friend_ID = p2.ID
WHERE p2.Salary > p1.Salary
ORDER BY p2.Salary;

