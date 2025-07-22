# 📊 SCD Types - Stored Procedures

This repository contains stored procedures for handling all types of **Slowly Changing Dimensions (SCD)**, which are essential in data warehousing and dimensional modeling. This work is part of an internship task at **Celebal Technologies** under the module **SQL001**.

## 📌 Task Description

> **Create the stored procedure for SCD type 0, SCD type 1, SCD type 2, SCD type 3, SCD type 4, and SCD type 6.**

## 🧠 What are SCD Types?

**Slowly Changing Dimensions (SCD)** are used to manage and track changes in dimensional data over time. Each type defines a different strategy for handling updates:

| SCD Type | Description |
|----------|-------------|
| Type 0   | Fixed attribute – No changes allowed once inserted |
| Type 1   | Overwrite – Update the attribute with new value |
| Type 2   | Historical tracking – Keep full history of changes |
| Type 3   | Limited history – Store previous value in a separate column |
| Type 4   | History table – Maintain a separate table for historical changes |
| Type 6   | Hybrid – Combines Types 1, 2, and 3 |

---

## 🛠 Table Assumptions

- **Source table:** `stg_customer`
- **Target table:** `dim_customer`
- **History table (for SCD Type 4):** `hist_customer`
- Primary key: `customer_id`
- Tracked attribute: `email`
- Extra columns for versioning:
  - `start_date`, `end_date`, `current_flag`, `version`, `prev_email`

---

## 📂 File Included

### `scd_stored_procedures.sql`

This SQL file contains the following procedures:

1. `scd_type_0()` – Inserts only new records, ignoring any updates.
2. `scd_type_1()` – Overwrites existing data without tracking history.
3. `scd_type_2()` – Ends the current record and inserts a new one (tracks full history).
4. `scd_type_3()` – Keeps the current and previous value of the changing attribute.
5. `scd_type_4()` – Logs old data into a history table before updating.
6. `scd_type_6()` – Hybrid approach combining Type 1, 2, and 3.

---

## ✅ How to Use

Run the procedures one by one in your SQL environment. Make sure the staging (`stg_customer`), dimension (`dim_customer`), and history (`hist_customer`) tables exist with appropriate schema.

