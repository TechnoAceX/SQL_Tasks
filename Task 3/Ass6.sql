-- TASK 6: Manhattan Distance between Two Points
-- Create table
CREATE TABLE STATION (
    ID INT,
    LAT_N DECIMAL(10,6),
    LONG_W DECIMAL(10,6)
);

-- Sample Data
INSERT INTO STATION (ID, LAT_N, LONG_W) VALUES
(1, 23.5, 67.1),
(2, 25.6, 65.3),
(3, 22.1, 69.2),
(4, 21.9, 64.5);

-- Query
SELECT ROUND(
    ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)),
    4
) AS Manhattan_Distance
FROM STATION;
