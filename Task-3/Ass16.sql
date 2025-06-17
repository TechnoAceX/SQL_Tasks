-- Task 16: Swap Two Columns Without Third Variable

CREATE TABLE SwapTable (
    a INT,
    b INT
);

INSERT INTO SwapTable VALUES (5, 10);

-- Swap logic
UPDATE SwapTable
SET a = a + b,
    b = a - b,
    a = a - b;

-- SELECT * FROM SwapTable; -- To verify swap worked


