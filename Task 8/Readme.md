# Time Dimension Stored Procedure — Internship Task

Write a Stored Procedure that populates a table with certain date attributes. The data would be populated for 1 year. For example the date 14-07-2020 is passed as an input parameter, then the stored procedure will populate those attributes for all the dates present within the year 2020. The primary key for this table would be date column. In order to find sample data and list of attributes please click on the link. Constraint: More than one insert statement cannot be used

## 📋 Task Overview
The objective of this task is to create a **MySQL Stored Procedure** that populates a **Time Dimension Table** for all dates within a given year, based on a provided input date.

### ✅ Constraints:
- The data must be generated **dynamically** using SQL Date Functions.
- Only **one `INSERT INTO ... SELECT` statement** is allowed inside the procedure.
- The Excel file provided was used **only as a reference for attributes** — no static data was inserted manually.

---

## 🗃️ Table Structure — `TimeDimension`
The table was designed with the following attributes (based on the provided Excel reference):

| Column Name           | Description                    |
|-----------------------|--------------------------------|
| SKDate               | Surrogate Key in YYYYMMDD format |
| KeyDate              | Actual Date                    |
| Date                 | Same as KeyDate                |
| CalendarDay          | Day of Month                   |
| CalendarMonth        | Month Number                   |
| CalendarQuarter      | Quarter of the Year            |
| CalendarYear         | Year                           |
| DayNameLong          | Full Day Name (e.g., Monday)   |
| DayNameShort         | Short Day Name (e.g., Mon)     |
| DayNumberOfWeek      | Number of Day in Week (1=Sunday) |
| DayNumberOfYear      | Day of the Year (1-366)        |
| DaySuffix            | Ordinal Suffix (e.g., 1st, 2nd)|
| Fiscal Week          | Fiscal Week Number             |
| Fiscal Period        | Fiscal Month                   |
| FiscalQuarter        | Fiscal Quarter                 |
| Fiscal Year          | Fiscal Year                    |
| Fiscal Year/Period   | Combined Fiscal Year & Period  |

---

## 🛠️ Scripts Included

### 1️⃣ `create_time_dimension_table.sql`
- Defines the `TimeDimension` table with the above columns.

### 2️⃣ `populate_time_dimension_procedure.sql`
- Contains a **Stored Procedure** `PopulateTimeDimension(IN input_date DATE)` that:
  - Generates a sequence of dates for the entire year of `input_date`
  - Populates all attributes dynamically using SQL functions
  - Uses **only one `INSERT INTO ... SELECT` statement**
  - Uses a **Recursive CTE** for date generation (MySQL 8.0+)

---

## 📄 Note
The attached Excel sheet served as a reference for expected columns only.
All data is dynamically generated at runtime based on the input date.

---

## 🚀 Usage Example
```sql
-- To create the table
SOURCE create_time_dimension_table.sql;

-- To create the stored procedure
SOURCE populate_time_dimension_procedure.sql;

-- To execute and populate data for the year 2020
CALL PopulateTimeDimension('2020-07-14');

