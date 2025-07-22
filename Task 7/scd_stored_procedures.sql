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

    -- Insert new version
    INSERT INTO dim_customer (customer_id, email, start_date, end_date, current_flag, version)
    SELECT s.customer_id, s.email, current_date, '9999-12-31', 'Y', COALESCE(d.version, 0) + 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id AND d.current_flag = 'Y'
    WHERE d.customer_id IS NULL OR s.email <> d.email;
END;


-- SCD Type 3 – Limited History (Previous value stored)
CREATE PROCEDURE scd_type_3()
BEGIN
    MERGE INTO dim_customer AS target
    USING stg_customer AS source
    ON target.customer_id = source.customer_id
    WHEN MATCHED AND target.email <> source.email THEN
        UPDATE SET target.prev_email = target.email,
                   target.email = source.email
    WHEN NOT MATCHED THEN
        INSERT (customer_id, email)
        VALUES (source.customer_id, source.email);
END;


-- SCD Type 4 – History Table
CREATE PROCEDURE scd_type_4()
BEGIN
    -- Insert into history table
    INSERT INTO hist_customer (customer_id, email, change_date)
    SELECT d.customer_id, d.email, CURRENT_DATE
    FROM stg_customer s
    JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE s.email <> d.email;

    -- Update main dimension table
    UPDATE dim_customer
    SET email = s.email
    FROM stg_customer s
    WHERE dim_customer.customer_id = s.customer_id AND dim_customer.email <> s.email;
END;


-- SCD Type 6 – Hybrid (Type 1 + 2 + 3)
CREATE PROCEDURE scd_type_6()x
BEGIN
    DECLARE current_date DATE;
    SET current_date = CURRENT_DATE;

    -- Expire old record and insert new
    UPDATE dim_customer
    SET end_date = current_date - INTERVAL 1 DAY,
        current_flag = 'N'
    WHERE customer_id IN (
        SELECT s.customer_id
        FROM stg_customer s
        JOIN dim_customer d ON s.customer_id = d.customer_id
        WHERE s.email <> d.email AND d.current_flag = 'Y'
    );

    INSERT INTO dim_customer (customer_id, email, prev_email, start_date, end_date, current_flag, version)
    SELECT s.customer_id, s.email, d.email, current_date, '9999-12-31', 'Y', COALESCE(d.version, 0) + 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id AND d.current_flag = 'Y'
    WHERE d.customer_id IS NULL OR s.email <> d.email;
END;

