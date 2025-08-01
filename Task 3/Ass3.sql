-- Task 3: Symmetric Pairs


-- Step 1: Create the Table
CREATE TABLE Functions (
    X INT,
    Y INT
);


-- Step 2: Insert the Sample Data
INSERT INTO Functions (X, Y) VALUES
(20, 20),
(20, 20),
(20, 21),
(23, 22),
(22, 23),
(21, 20);


-- Step 3: Query to Find Symmetric Pairs
SELECT DISTINCT f1.X, f1.Y
FROM Functions f1
JOIN Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
ORDER BY f1.X;
