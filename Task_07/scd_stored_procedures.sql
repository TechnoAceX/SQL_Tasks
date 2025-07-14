-- SCD Type 0 – Fixed Attributes (No change allowed)
CREATE PROCEDURE scd_type_0()
BEGIN
    INSERT INTO dim_customer (customer_id, email)
    SELECT s.customer_id, s.email
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END;


-- SCD Type 1 – Overwrite (No history)
CREATE PROCEDURE scd_type_1()
BEGIN
    MERGE INTO dim_customer AS target
    USING stg_customer AS source
    ON target.customer_id = source.customer_id
    WHEN MATCHED THEN
        UPDATE SET target.email = source.email
    WHEN NOT MATCHED THEN
        INSERT (customer_id, email)
        VALUES (source.customer_id, source.email);
END;


-- SCD Type 2 – Full History (Versioning)
CREATE PROCEDURE scd_type_2()
BEGIN
    DECLARE current_date DATE;
    SET current_date = CURRENT_DATE;

    -- Expire old record
    UPDATE dim_customer
    SET end_date = current_date - INTERVAL 1 DAY,
        current_flag = 'N'
    WHERE customer_id IN (
        SELECT s.customer_id
        FROM stg_customer s
        JOIN dim_customer d ON s.customer_id = d.customer_id
        WHERE s.email <> d.email AND d.current_flag = 'Y'
    );
