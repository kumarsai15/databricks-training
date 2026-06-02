
# SQL NULL Functions Practice

## Overview

This project contains SQL practice exercises focused on handling NULL values using:

* IS NULL
* IS NOT NULL
* COALESCE()
* NULLIF()
* Aggregate Functions
* Conditional Filtering

## Tables Used

### Employees

Stores employee details such as:

* Employee ID
* Name
* Salary
* Bonus
* Manager ID

### Orders

Stores customer order information:

* Order ID
* Customer Name
* Amount
* Discount
* Coupon Code

### Products

Stores product details:

* Product ID
* Product Name
* Price
* Category
* Stock

## Topics Covered

### NULL Checking

* Find records with NULL values
* Find records with NOT NULL values

### COALESCE()

Used to replace NULL values with default values.

Examples:

* Replace NULL salary with 0
* Replace NULL bonus with 1000
* Replace NULL stock with 0
* Show first available value from multiple columns

### NULLIF()

Used to convert a specific value into NULL.

Examples:

* Convert salary = 0 to NULL
* Convert discount = 0 to NULL

### Aggregate Functions

* COUNT()
* SUM()
* Handling NULL values in calculations

### Practical Queries

* Employee earnings calculation
* Customer payment calculation
* Product price handling
* Payable amount calculation
* Finding records with multiple NULL conditions

## Learning Outcomes

After completing this project, you will be able to:

* Handle NULL values effectively in SQL
* Use COALESCE and NULLIF functions
* Write conditional queries
* Perform calculations with NULL-safe logic
* Apply aggregate functions correctly

## Database

PostgreSQL

## Tool Used

DBeaver

## Author

Kumar Sai
