
-- ============================================
-- 9. Previous Order Amount Using LAG()
-- ============================================

SELECT customer_id, order_date, total_amount,
LAG(total_amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
) AS previous_order
FROM orders;



-- ============================================
-- 10. Next Order Amount Using LEAD()
-- ============================================

SELECT customer_id, order_date, total_amount,
LEAD(total_amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
) AS next_order
FROM orders;



-- ============================================
-- 11. Difference Between Current and Previous Order
-- ============================================

SELECT customer_id, order_date, total_amount,
total_amount -
LAG(total_amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
) AS difference_amount
FROM orders;



-- ============================================
-- 12. Moving Average of Last 3 Orders
-- ============================================

SELECT order_id, order_date, total_amount,
AVG(total_amount) OVER(
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_average
FROM orders;



-- ============================================
-- 13. Divide Employees into Salary Quartiles
-- ============================================

SELECT employee_name, salary,
NTILE(4) OVER(ORDER BY salary DESC) AS quartile
FROM employees;



-- ============================================
-- 14. First Order Placed by Each Customer
-- ============================================

SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS rn
    FROM orders
) t
WHERE rn = 1;



-- ============================================
-- 15. Latest Order Placed by Each Customer
-- ============================================

SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date DESC
    ) AS rn
    FROM orders
) t
WHERE rn = 1;



-- ============================================
-- 16. Employee Salaries with Department Average
-- ============================================

SELECT employee_name, department, salary,
AVG(salary) OVER(PARTITION BY department) AS dept_avg_salary
FROM employees;



-- ============================================
-- 17. Employees Earning Above Department Average
-- ============================================

SELECT *
FROM (
    SELECT employee_name, department, salary,
    AVG(salary) OVER(PARTITION BY department) AS dept_avg
    FROM employees
) t
WHERE salary > dept_avg;



-- ============================================
-- 18. Department Payroll Using SUM() OVER()
-- ============================================

SELECT employee_name, department, salary,
SUM(salary) OVER(PARTITION BY department) AS dept_payroll
FROM employees;



-- ============================================
-- 19. Percentage Contribution of Salary
-- ============================================

SELECT employee_name, department, salary,
ROUND(
    salary * 100.0 /
    SUM(salary) OVER(PARTITION BY department),
2) AS salary_percentage
FROM employees;



-- ============================================
-- 20. Total Number of Employees
-- ============================================

SELECT employee_name, department,
COUNT(*) OVER() AS total_employees
FROM employees;



-- ============================================
-- 21. CTE for Total Sales Per Employee
-- ============================================

WITH employee_sales AS (
    SELECT employee_id,
    SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT * FROM employee_sales;



-- ============================================
-- 22. Employees Whose Sales Exceed Company Average
-- ============================================

WITH employee_sales AS (
    SELECT employee_id,
    SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM employee_sales
);



-- ============================================
-- 23. Multiple CTEs for Customer Spending & Ranking
-- ============================================

WITH customer_spending AS (
    SELECT customer_id,
    SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),

customer_ranking AS (
    SELECT *,
    RANK() OVER(ORDER BY total_spent DESC) AS customer_rank
    FROM customer_spending
)

SELECT * FROM customer_ranking;



-- ============================================
-- 24. Recursive CTE to Generate Numbers 1 to 10
-- ============================================

WITH numbers AS (
    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 10
)

SELECT * FROM numbers;



-- ============================================
-- 25. Recursive CTE for Employee Hierarchy
-- ============================================

CREATE TABLE employee_hierarchy (
    employee_id INT,
    employee_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employee_hierarchy VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'Diana', 2);

WITH hierarchy AS (
    SELECT employee_id, employee_name, manager_id, 1 AS level
    FROM employee_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.employee_name,
           e.manager_id, h.level + 1
    FROM employee_hierarchy e
    JOIN hierarchy h
    ON e.manager_id = h.employee_id
)

SELECT * FROM hierarchy;



-- ============================================
-- 26. CTE Filtering Orders Above Average Amount
-- ============================================

WITH avg_orders AS (
    SELECT *
    FROM orders
    WHERE total_amount >
    (
        SELECT AVG(total_amount)
        FROM orders
    )
)

SELECT * FROM avg_orders;



-- ============================================
-- 27. CTE + Window Function to Rank Customers
-- ============================================

WITH customer_totals AS (
    SELECT customer_id,
    SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)

SELECT *,
RANK() OVER(ORDER BY total_spending DESC) AS spending_rank
FROM customer_totals;



-- ============================================
-- 28. Second Highest Salary in Each Department
-- ============================================

SELECT *
FROM (
    SELECT employee_name, department, salary,
    DENSE_RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
    FROM employees
) t
WHERE salary_rank = 2;



-- ============================================
-- 29. Difference Between Salary and Department Max
-- ============================================

SELECT employee_name, department, salary,
MAX(salary) OVER(PARTITION BY department) - salary
AS salary_difference
FROM employees;


