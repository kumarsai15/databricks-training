
# SQL Joins, Window Functions and CTE Assignment

This project contains SQL practice queries using:
- Joins
- Window Functions
- CTEs
- Ranking Functions
- Running Totals

## Topics Covered

### SQL Joins
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- CROSS JOIN

### Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- Running Total using SUM()

## Files

- `joins_assignment.sql` → SQL Joins practice queries
- `window_functions_assignment.sql` → Window functions and ranking queries

## Database Tables Used

### Joins Assignment
- Students
- Courses
- Instructors
- Enrollments

### Window Functions Assignment
- Employees
- Customers
- Orders

## Example Queries

### Rank Employees by Salary
```sql
SELECT *,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


Concepts Learned
Working with relational data
Combining tables using joins
Using window functions
Employee salary ranking
Calculating cumulative totals

Software Used
MySQL Workbench 


Author
Kumar Sai
