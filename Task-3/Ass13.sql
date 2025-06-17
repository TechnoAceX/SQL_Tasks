-- Task 13: BU Cost-Revenue Ratio Month-wise

CREATE TABLE BU_Data (
    bu_name VARCHAR(50),
    month VARCHAR(20),
    cost DECIMAL(10,2),
    revenue DECIMAL(10,2)
);

INSERT INTO BU_Data VALUES
('Finance', 'Jan', 10000, 50000),
('Finance', 'Feb', 12000, 60000),
('Tech', 'Jan', 20000, 80000),
('Tech', 'Feb', 18000, 72000);

-- Query
SELECT bu_name, month,
       ROUND(cost / revenue, 2) AS cost_to_revenue_ratio
FROM BU_Data;
