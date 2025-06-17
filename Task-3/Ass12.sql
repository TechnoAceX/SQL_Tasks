-- Task 12: Ratio of Job Family Cost – India vs International

CREATE TABLE JobCosts (
    job_family VARCHAR(50),
    region VARCHAR(20),  -- 'India' or 'International'
    cost DECIMAL(10,2)
);

INSERT INTO JobCosts VALUES
('Engineering', 'India', 100000),
('Engineering', 'International', 300000),
('Sales', 'India', 50000),
('Sales', 'International', 150000);

-- Query
SELECT job_family,
       ROUND(SUM(CASE WHEN region = 'India' THEN cost ELSE 0 END) * 100.0 / SUM(cost), 2) AS India_Percentage,
       ROUND(SUM(CASE WHEN region = 'International' THEN cost ELSE 0 END) * 100.0 / SUM(cost), 2) AS International_Percentage
FROM JobCosts
GROUP BY job_family;

