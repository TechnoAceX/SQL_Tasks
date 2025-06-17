-- Task 5: Query for daily unique hackers and max submitter


-- STEP 1: Create required tables
CREATE TABLE Hackers (
    hacker_id INT,
    name VARCHAR(100)
);

CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT,
    hacker_id INT,
    score INT
);

-- Insert Hackers
INSERT INTO Hackers (hacker_id, name) VALUES
(20703, 'Angela'),
(36396, 'Frank'),
(40074, 'Patrick'),
(43902, 'Lisa'),
(45440, 'Kimberly'),
(50273, 'Bonnie'),
(61533, 'Michael'),
(76487, 'Rose'),
(82439, 'Angela'),
(90006, 'Frank'),
(90404, 'Angela'),
(79722, 'Michael');

-- Insert Submissions
INSERT INTO Submissions (submission_date, submission_id, hacker_id, score) VALUES
('2016-03-01', 1, 20703, 0),
('2016-03-01', 2, 36396, 0),
('2016-03-01', 3, 40074, 0),
('2016-03-01', 4, 43902, 0),
('2016-03-02', 5, 79722, 0),
('2016-03-02', 6, 20703, 0),
('2016-03-03', 7, 45440, 0),
('2016-03-03', 8, 49050, 0),
('2016-03-03', 9, 50273, 0),
('2016-03-03',10, 20703, 0),
('2016-03-03',11, 20703, 0),
('2016-03-04',12, 61533, 0),
('2016-03-05',13, 76487, 0),
('2016-03-05',14, 82439, 0),
('2016-03-05',15, 90006, 0),
('2016-03-05',16, 90404, 0),
('2016-03-06',17, 36396, 0),
('2016-03-06',18, 20703, 0),
('2016-03-06',19, 20703, 0);

-- STEP 2: Final Query
SELECT
    s.submission_date,
    COUNT(DISTINCT s.hacker_id) AS unique_hackers,
    hs.hacker_id,
    h.name
FROM Submissions s
JOIN Hackers h ON s.hacker_id = h.hacker_id
JOIN (
    SELECT
        submission_date,
        hacker_id
    FROM (
        SELECT
            submission_date,
            hacker_id,
            RANK() OVER (PARTITION BY submission_date ORDER BY COUNT(*) DESC, hacker_id ASC) AS rnk
        FROM Submissions
        GROUP BY submission_date, hacker_id
    ) ranked
    WHERE rnk = 1
) hs ON s.submission_date = hs.submission_date AND s.hacker_id = hs.hacker_id
JOIN Hackers h2 ON hs.hacker_id = h2.hacker_id
GROUP BY s.submission_date, hs.hacker_id, h.name
ORDER BY s.submission_date;
