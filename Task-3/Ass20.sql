--  Task 20: Copy New Data Between Tables (No Flag Present)
--Assumption: Copy data not already present in the destination.

CREATE TABLE SourceData (
    id INT PRIMARY KEY,
    data VARCHAR(100)
);

CREATE TABLE DestinationData (
    id INT PRIMARY KEY,
    data VARCHAR(100)
);

INSERT INTO SourceData VALUES (1, 'A'), (2, 'B'), (3, 'C');
INSERT INTO DestinationData VALUES (1, 'A');

-- Copy data that doesn't already exist in destination
INSERT INTO DestinationData (id, data)
SELECT id, data
FROM SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM DestinationData d WHERE d.id = s.id
);
