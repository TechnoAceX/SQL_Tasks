-- Task 1 – Group Consecutive Tasks as Projects

-- Drop table if it already exists
IF OBJECT_ID('Projects', 'U') IS NOT NULL
    DROP TABLE Projects;

-- Create the table
CREATE TABLE Projects (
    Task_ID INT,
    Start_Date DATE,
    End_Date DATE
);

-- Insert the sample data
INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(2, '2015-10-01', '2015-10-02'),
(3, '2015-10-02', '2015-10-03'),
(4, '2015-10-03', '2015-10-04'),
(6, '2015-10-13', '2015-10-14'),
(7, '2015-10-14', '2015-10-15'),
(8, '2015-10-28', '2015-10-29'),
(9, '2015-10-30', '2015-10-31');

-- Use ROW_NUMBER and identify breaks in continuity
WITH OrderedTasks AS (
    SELECT *,
        ROW_NUMBER() OVER (ORDER BY Start_Date) AS rn
    FROM Projects
),
GroupedTasks AS (
    SELECT *,
        DATEADD(DAY, -rn, CAST(Start_Date AS DATETIME)) AS grp
    FROM OrderedTasks
),
ProjectGroups AS (
    SELECT 
        MIN(Start_Date) AS Project_Start,
        MAX(End_Date) AS Project_End,
        DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)) AS Duration
    FROM GroupedTasks
    GROUP BY grp
)
SELECT 
    Project_Start,
    Project_End
FROM ProjectGroups
ORDER BY 
    Duration DESC,
    Project_Start;

