-- TASK 8: Pivot Occupation
CREATE TABLE OCCUPATIONS (
    Name VARCHAR(50),
    Occupation VARCHAR(50)
);

INSERT INTO OCCUPATIONS (Name, Occupation) VALUES
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashley', 'Professor'),
('Ketty', 'Professor'),
('Christeen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');

-- Pivot Query
SELECT
    MAX(Doctor) AS Doctor,
    MAX(Professor) AS Professor,
    MAX(Singer) AS Singer,
    MAX(Actor) AS Actor
FROM (
    SELECT
        Name,
        Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) AS sub
PIVOT (
    MAX(Name)
    FOR Occupation IN ([Doctor], [Professor], [Singer], [Actor])
) AS pvt
GROUP BY rn
ORDER BY rn;
