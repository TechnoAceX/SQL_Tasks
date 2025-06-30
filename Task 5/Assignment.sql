-- 1. Create Required Tables

CREATE TABLE StudentDetails (
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(100),
    GPA DECIMAL(4,2),
    Branch VARCHAR(10),
    Section VARCHAR(10)
);

CREATE TABLE SubjectDetails (
    SubjectId VARCHAR(10) PRIMARY KEY,
    SubjectName VARCHAR(100),
    MaxSeats INT,
    RemainingSeats INT
);

CREATE TABLE StudentPreference (
    StudentId INT,
    SubjectId VARCHAR(10),
    Preference INT,
    PRIMARY KEY (StudentId, Preference)
);

CREATE TABLE Allotments (
    SubjectId VARCHAR(10),
    StudentId INT
);

CREATE TABLE UnallotedStudents (
    StudentId INT PRIMARY KEY
);

-- 2. Inserting Sample Data (From PDF)

-- StudentDetails
INSERT INTO StudentDetails VALUES
(159103036, 'Mohit Agarwal', 8.9, 'CCE', 'A'),
(159103037, 'Rohit Agarwal', 5.2, 'CCE', 'A'),
(159103038, 'Shohit Garg', 7.1, 'CCE', 'B'),
(159103039, 'Mrinal Malhotra', 7.9, 'CCE', 'A'),
(159103040, 'Mehreet Singh', 5.6, 'CCE', 'A'),
(159103041, 'Arjun Tehlan', 9.2, 'CCE', 'B');

-- SubjectDetails
INSERT INTO SubjectDetails VALUES
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 119),
('PO1493', 'Basics of Financial Markets', 90, 90),
('PO1494', 'Eco philosophy', 60, 50),
('PO1495', 'Automotive Trends', 60, 60);

-- StudentPreference
-- Mohit
INSERT INTO StudentPreference VALUES
(159103036, 'PO1491', 1),
(159103036, 'PO1492', 2),
(159103036, 'PO1493', 3),
(159103036, 'PO1494', 4),
(159103036, 'PO1495', 5);

-- Other students (dummy realistic preferences to run full test)
INSERT INTO StudentPreference VALUES
(159103037, 'PO1492', 1), (159103037, 'PO1491', 2), (159103037, 'PO1493', 3), (159103037, 'PO1494', 4), (159103037, 'PO1495', 5),
(159103038, 'PO1493', 1), (159103038, 'PO1491', 2), (159103038, 'PO1492', 3), (159103038, 'PO1495', 4), (159103038, 'PO1494', 5),
(159103039, 'PO1492', 1), (159103039, 'PO1493', 2), (159103039, 'PO1494', 3), (159103039, 'PO1495', 4), (159103039, 'PO1491', 5),
(159103040, 'PO1491', 1), (159103040, 'PO1492', 2), (159103040, 'PO1495', 3), (159103040, 'PO1493', 4), (159103040, 'PO1494', 5),
(159103041, 'PO1491', 1), (159103041, 'PO1492', 2), (159103041, 'PO1493', 3), (159103041, 'PO1494', 4), (159103041, 'PO1495', 5);



