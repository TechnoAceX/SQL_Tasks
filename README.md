# SQL Assignment Documentation

## Overview

This repository contains SQL queries developed to address 42 specific questions based on the AdventureWorks Data Warehouse 2014 (AdventureWorksDW2014) database. The queries aim to demonstrate proficiency in SQL querying, data manipulation, and reporting within a data warehouse environment.

## Notes and Assumptions

- **Database Schema:** The queries are designed for the AdventureWorksDW2014 database schema, which is a data warehouse version of the AdventureWorks database.

- **Schema Differences:** Some columns present in the OLTP version of AdventureWorks2014 (e.g., FaxNumber in the DimCustomer table) are not available in this Data Warehouse schema. This discrepancy may affect the ability to answer certain questions as originally posed.

## Queries and Explanations

### Query 2: Customers with Company Name Ending in 'N'
- **Issue:** The DimCustomer table lacks a CompanyName field, making this query unachievable.
- **Resolution:** This query was omitted from the assignment.

### Query 23: Discontinued Products Ordered Between 1997-1998
- **Issue:** The DimProduct table does not contain a Discontinued column, preventing the identification of discontinued products.
- **Resolution:** This query was omitted from the assignment.

### Query 30: Customers Without a Fax Number
- **Issue:** The DimCustomer table includes a Phone field but lacks a FaxNumber field, making it impossible to filter customers without a fax number.
- **Resolution:** This query was omitted from the assignment.

### Query 33: Products Supplied by 'Specialty Biscuits, Ltd.'
- **Issue:** The database schema does not include a Supplier table or any supplier-related information.
- **Resolution:** This query was omitted from the assignment.

### Query 35: Products with Low Stock and No Orders
- **Issue:** The DimProduct table lacks UnitsInStock and UnitsOnOrder fields, preventing the identification of products with low stock and no orders.
- **Resolution:** This query was omitted from the assignment.

### Query 37: Orders Placed by Employees for Specific Customers
- **Issue:** The FactInternetSales table does not contain an EmployeeKey field, making it impossible to associate orders with employees.
- **Resolution:** This query was omitted from the assignment.

### Query 40: Products Supplied by 'Specialty Biscuits, Ltd.'
- **Issue:** As mentioned in Query 33, the database schema lacks supplier-related information.
- **Resolution:** This query was omitted from the assignment.

## Conclusion

Due to the aforementioned schema limitations, certain queries could not be implemented. The remaining queries were executed successfully and are included in the attached SQL script.
EOF
