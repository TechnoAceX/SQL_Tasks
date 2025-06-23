-- TASK: Subject Allotment Stored Procedure
-- This procedure assigns students to subjects based on GPA and preference.
-- If a student's top preferences are full, they're marked unallotted.
-- Tables used: StudentDetails, StudentPreference, SubjectDetails, Allotments, UnallotedStudents

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

-- 2. Inserting Sample Data 

-- StudentDetails
INSERT INTO StudentDetails VALUES
(1, 'Akash', 9.2, 'CSE', 'A'),
(2, 'Anjali', 8.7, 'CSE', 'A'),
(3, 'Raj', 9.5, 'CSE', 'A'),
(4, 'Neha', 8.4, 'CSE', 'A'),
(5, 'Aman', 9.0, 'CSE', 'A');

-- SubjectDetails
INSERT INTO SubjectDetails VALUES
('S1', 'AI', 2, 2),
('S2', 'ML', 2, 2),
('S3', 'IOT', 1, 1),
('S4', 'BlockChain', 2, 2),
('S5', 'CyberSecurity', 2, 2);

-- StudentPreference
INSERT INTO StudentPreference VALUES
(1, 'S1', 1), (1, 'S2', 2), (1, 'S3', 3), (1, 'S4', 4), (1, 'S5', 5),
(2, 'S2', 1), (2, 'S1', 2), (2, 'S3', 3), (2, 'S5', 4), (2, 'S4', 5),
(3, 'S2', 1), (3, 'S1', 2), (3, 'S3', 3), (3, 'S5', 4), (3, 'S4', 5),
(4, 'S1', 1), (4, 'S2', 2), (4, 'S5', 3), (4, 'S4', 4), (4, 'S3', 5),
(5, 'S3', 1), (5, 'S2', 2), (5, 'S1', 3), (5, 'S5', 4), (5, 'S4', 5);

CREATE TABLE UnallotedStudents (
    StudentId INT PRIMARY KEY
);

-- 3. Stored Procedure: AllocateSubjects

GO

CREATE OR ALTER PROCEDURE AllocateSubjects
AS
BEGIN
    -- Clear existing results
    DELETE FROM Allotments;
    DELETE FROM UnallotedStudents;

    DECLARE student_cursor CURSOR FOR
    SELECT StudentId FROM StudentDetails ORDER BY GPA DESC;

    DECLARE @StudentId INT;
    DECLARE @SubjectId VARCHAR(10);
    DECLARE @Preference INT;
    DECLARE @Allotted BIT;

    OPEN student_cursor;
    FETCH NEXT FROM student_cursor INTO @StudentId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Allotted = 0;
        SET @Preference = 1;

        WHILE @Preference <= 5 AND @Allotted = 0
        BEGIN
            SELECT @SubjectId = SubjectId
            FROM StudentPreference
            WHERE StudentId = @StudentId AND Preference = @Preference;

            IF EXISTS (
                SELECT 1 FROM SubjectDetails
                WHERE SubjectId = @SubjectId AND RemainingSeats > 0
            )
            BEGIN
                INSERT INTO Allotments (SubjectId, StudentId)
                VALUES (@SubjectId, @StudentId);

                UPDATE SubjectDetails
                SET RemainingSeats = RemainingSeats - 1
                WHERE SubjectId = @SubjectId;

                SET @Allotted = 1;
            END

            SET @Preference = @Preference + 1;
        END

        IF @Allotted = 0
        BEGIN
            INSERT INTO UnallotedStudents (StudentId)
            VALUES (@StudentId);
        END

        FETCH NEXT FROM student_cursor INTO @StudentId;
    END

    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;

-- 4. Executing the procedure 
EXEC AllocateSubjects;

-- View Allotments
SELECT * FROM Allotments;
-- View Unallotted Students
SELECT * FROM UnallotedStudents;

GO
