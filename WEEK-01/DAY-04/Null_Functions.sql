CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT,
    bonus INT,
    manager_id INT
);


INSERT INTO Employees VALUES
(1, 'Amit', 50000, NULL, 101),
(2, 'John', NULL, 5000, 102),
(3, 'Sara', 60000, NULL, NULL),
(4, 'David', NULL, NULL, 103),
(5, 'Priya', 45000, 3000, 101),
(6, 'Kiran', NULL, NULL, NULL),
(7, 'Ravi', 70000, 7000, 102),
(8, 'Neha', NULL, 2000, NULL);

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    amount INT,
    discount INT,
    coupon_code VARCHAR(20)
);


(101, 'Amit', 1000, NULL, 'DISC10'),
(102, 'John', NULL, 50, NULL),
(103, 'Sara', 2000, NULL, 'DISC20'),
(104, 'David', NULL, NULL, NULL),
(105, 'Priya', 1500, 100, NULL),
(106, 'Kiran', NULL, NULL, 'DISC5'),
(107, 'Ravi', 3000, NULL, NULL),
(108, 'Neha', NULL, 200, 'DISC15');


CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(50),
    stock INT
);


(1, 'Laptop', 50000, 'Electronics', 10),
(2, 'Phone', NULL, 'Electronics', NULL),
(3, 'Tablet', 30000, NULL, 5),
(4, 'Headphones', NULL, NULL, NULL),
(5, 'Monitor', 20000, 'Electronics', 0),
(6, 'Keyboard', NULL, 'Accessories', 15),
(7, 'Mouse', 500, NULL, NULL),
(8, 'Printer', NULL, 'Electronics', 3);


--Show all employees whose salary is NULL

select * from Employees where salary IS NULL ;

  Output
emp_id	name	salary	bonus	manager_id
2	John		5000	102
4	David			103
6	Kiran			
8	Neha		2000	

--Show all orders where discount is NOT NULL

select * from orders where discount is null ;

Output
order_id	customer_name	amount	discount	coupon_code
101	Amit	1000		DISC10
103	Sara	2000		DISC20
104	David			
106	Kiran			DISC5
107	Ravi	3000		


--Get products where category is NULL

select * from products where category is null;

output
product_id	product_name	price	category	stock
3	Tablet	30000		5
4	Headphones			
7	Mouse	500		

--Count number of employees with NULL manager_id

select count(*) from employees where manager_id is null;

count(*)
3

--Replace NULL salary with 0

select COALESCE(salary, 0)from employees;

Output
COALESCE(salary, 0)
50000
0
60000
0
45000
0
70000
0


--Replace NULL bonus with 1000

select COALESCE(bonus, 1000)from employees;

  Output
COALESCE(bonus, 1000)
1000
5000
1000
1000
3000
1000
7000
2000

--Show order amount, if NULL replace with 500

    select coalesce(amount, 500) from orders

    Output
coalesce(amount, 500)
1000
500
2000
500
1500
500
3000
500

    
Replace NULL stock with 0

select coalesce(stock,0) from products

Output
coalesce(stock,0)
10
0
5
0
0
15
0
3
1`

-- Show employee earnings using: salary, if NULL use bonus

select emp_id, name, coalesce(salary,bonus) from employees ;

Output
emp_id	name	coalesce(salary,bonus)
1	Amit	50000
2	John	5000
3	Sara	60000
4	David	
5	Priya	45000
6	Kiran	
7	Ravi	70000
8	Neha	2000

/*
Show first available value:
 salary → bonus → 0
*/

select emp_id, name, coalesce(salary,bonus,0) from employees ;

Output
emp_id	name	coalesce(salary,bonus,0)
1	Amit	50000
2	John	5000
3	Sara	60000
4	David	0
5	Priya	45000
6	Kiran	0
7	Ravi	70000
8	Neha	2000

/*
Show product price:
 price → 1000 (default)

*/

select product_id ,product_name, coalesce(price,1000) from products ;

Output
product_id	product_name	coalesce(price,1000)
1	Laptop	50000
2	Phone	1000
3	Tablet	30000
4	Headphones	1000
5	Monitor	20000
6	Keyboard	1000
7	Mouse	500
8	Printer	1000

/*
Get customer payment:
 amount → discount → 0
*/

select order_id ,customer_name, coalesce(amount,discount,0) from orders ;

Output
order_id	customer_name	coalesce(amount,discount,0)
101	Amit	1000
102	John	50
103	Sara	2000
104	David	0
105	Priya	1500
106	Kiran	0
107	Ravi	3000
108	Neha	200

/*
Convert salary to NULL if salary = 0
*/

SELECT emp_id,
       name,
       NULLIF(salary, 0) AS salary
FROM employees;

Output
emp_id	name	salary
1	Amit	50000
2	John	
3	Sara	60000
4	David	
5	Priya	45000
6	Kiran	
7	Ravi	70000
8	Neha	


/*
Convert discount to NULL if discount = 0
*/

SELECT order_id,
       customer_name,
       NULLIF(discount, 0) AS discount
FROM orders;

Output
order_id	customer_name	discount
101	Amit	
102	John	50
103	Sara	
104	David	
105	Priya	100
106	Kiran	
107	Ravi	
108	Neha	200

/*
Calculate total earnings:
   salary + bonus (handle NULL properly)
*/
SELECT emp_id,
       name,
       COALESCE(salary, 0) + COALESCE(bonus, 0) AS total_earnings
FROM employees;

Output
emp_id	name	total_earnings
1	Amit	50000
2	John	5000
3	Sara	60000
4	David	0
5	Priya	48000
6	Kiran	0
7	Ravi	77000
8	Neha	2000

/*
Show employees where:
   both salary AND bonus are NULL
*/
SELECT name
FROM employees
WHERE COALESCE(salary, bonus) IS NULL;

Output
name
David
Kiran

/*
Show products where:
   price is NULL but category is NOT NULL

*/
select product_id ,product_name from products where price is null and category not null
  
Output
product_id	product_name
2	Phone
6	Keyboard
8	Printer

/*
Show orders where:
   both amount and discount are NULL
*/

SELECT order_id
FROM orders
WHERE COALESCE(amount , discount ) IS NULL;

Output
order_id
104
106

/*
Show employee income:
  COALESCE(salary, bonus, 1000)
*/
  
  select salary,bonus,COALESCE(salary,bonus,1000) as employee_income from employees;

Output
salary	bonus	employee_income
50000		50000
5000	5000
60000		60000
1000
45000	3000	45000
1000
70000	7000	70000
2000	2000


/*
Replace empty discount with NULL using NULLIF:
NULLIF(discount, 0)
*/

select nullif(discount,0) as discount from orders
  
Output
discount
50
100
200
/*
Show final payable amount:
  amount - discount (handle NULL)
*/

select amount , discount ,coalesce(amount,0) -   coalesce(discount,0)  as totalpayable from orders
  
Output
amount	discount	totalpayable
1000		1000
50	-50
2000		2000
0
1500	100	1400
0
3000		3000
200	-200

-- Find employees where salary is NULL but manager exists

SELECT name
FROM employees
WHERE salary IS NULL
  AND manager_id IS NOT NULL;


Output
name
John
David
