-- Task4:- Step 1: Create Tables

CREATE TABLE Contests (
    contest_id INT,
    hacker_id INT,
    name VARCHAR(100)
);

CREATE TABLE Colleges (
    college_id INT,
    contest_id INT
);

CREATE TABLE Challenges (
    challenge_id INT,
    college_id INT
);

CREATE TABLE View_Stats (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
);

CREATE TABLE Submission_Stats (
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

-- Step 2: Insert Sample Data

-- Contests
INSERT INTO Contests VALUES
(66406, 17973, 'Rose'),
(66556, 79153, 'Angela'),
(94828, 80275, 'Frank');

-- Colleges
INSERT INTO Colleges VALUES
(11219, 66406),
(32473, 66556),
(56685, 94828);

-- Challenges
INSERT INTO Challenges VALUES
(47127, 11219),
(75516, 11219),
(60292, 32473),
(72974, 56685);

-- View_Stats
INSERT INTO View_Stats VALUES
(47127, 111, 56),
(75516, 41, 15),
(60292, 0, 0),
(72974, 75, 11);

-- Submission_Stats
INSERT INTO Submission_Stats VALUES
(47127, 111, 39),
(75516, 150, 38),
(72974, 68, 24),
(72974, 82, 14),
(60292, 0, 0);


 -- Step 3: Final SQL Query (Main Task)
SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    COALESCE(SUM(ss.total_submissions), 0) AS total_submissions,
    COALESCE(SUM(ss.total_accepted_submissions), 0) AS total_accepted_submissions,
    COALESCE(SUM(vs.total_views), 0) AS total_views,
    COALESCE(SUM(vs.total_unique_views), 0) AS total_unique_views
FROM Contests c
JOIN Colleges col ON c.contest_id = col.contest_id
JOIN Challenges ch ON ch.college_id = col.college_id
LEFT JOIN Submission_Stats ss ON ss.challenge_id = ch.challenge_id
LEFT JOIN View_Stats vs ON vs.challenge_id = ch.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
    COALESCE(SUM(ss.total_submissions), 0) +
    COALESCE(SUM(ss.total_accepted_submissions), 0) +
    COALESCE(SUM(vs.total_views), 0) +
    COALESCE(SUM(vs.total_unique_views), 0) > 0
ORDER BY c.contest_id;


