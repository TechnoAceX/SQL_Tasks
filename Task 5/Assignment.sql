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
