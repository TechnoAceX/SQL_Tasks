-- SCD Type 0 – Fixed Attributes (No change allowed)
CREATE PROCEDURE scd_type_0()
BEGIN
    INSERT INTO dim_customer (customer_id, email)
    SELECT s.customer_id, s.email
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END;


