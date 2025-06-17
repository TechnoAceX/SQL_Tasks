-- TASK 7: Prime Numbers ≤ 1000 with '&' separator
-- No tables required for this task

-- This version works in PostgreSQL
WITH RECURSIVE Numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 1000
),
Primes AS (
    SELECT n FROM Numbers n1
    WHERE NOT EXISTS (
        SELECT 1 FROM Numbers n2
        WHERE n2.n < n1.n AND n2.n > 1 AND n1.n % n2.n = 0
    )
)
SELECT STRING_AGG(n::TEXT, '&') AS prime_list FROM Primes;

