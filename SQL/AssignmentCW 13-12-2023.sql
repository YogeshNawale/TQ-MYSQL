use classicmodels;
-- distinct 
 SELECT DISTINCT status
 FROM orders;
 -- select distinct lastname from employees in ascending orders
 SELECT DISTINCT lastname
 FROM employees
 Order BY lastname DESC;
 
 -- distinct gives only one null values and other non repeating values
 SELECT DISTINCT state
 FROM customers;
 
 -- distinct clause with multiple columns
 SELECT DISTINCT state,city
 FROM customers
 WHERE state IS NOT NULL
 ORDER BY state;
 
 -- group by
 SELECT status
 FROM orders
 GROUP BY status;
 
 -- group by with aggregate functions
 SELECT status , COUNT(*)
 FROM orders
 GROUP BY status;
 
 -- to get total price of each order
 SELECT *,ordernumber , sum(quantityordered * priceEach ) AS TotalPrice
 FROM orderdetails
 GROUP BY orderNumber;
 
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- find out citywise customer count
SELECT city, COUNT(customerNumber)
FROM customers
GROUP BY city; 

-- find out yearwise count of order number

SELECT year(orderdate) AS orderyear, COUNT(ordernumber) 
FROM orders
GROUP BY orderyear;

-- limit
SELECT customernumber,customername,creditlimit
FROM customers
ORDER BY creditlimit DESC
LIMIT 5;

SELECT customernumber,customername,creditlimit
FROM customers
ORDER BY creditlimit DESC
LIMIT 2,5;

-- find avg buyprice of all the products in product table
SELECT AVG(buyprice)
FROM products;


-- find avg buyprice for each product line
SELECT productline,AVG(buyprice)
FROM products
GROUP BY productline;

-- find number of product in product table

SELECT COUNT(productcode) AS NumberOfProduct
FROM products;

-- find number of products in each product line as per descending order of product line
SELECT productline,COUNT(productcode)
FROM products
GROUP BY Productline
ORDER BY productline DESC;

-- find a query to get sum of price*quantity ordered as per product code
SELECT productcode, SUM(priceeach * quantityOrdered ) AS TotalPrice
FROM orderdetails
GROUP BY productcode;

-- write a query to get highest buyprice from the products
SELECT productname,MAX(buyprice)
FROM products;

-- -- write a query to get highest buyprice as per productline . Order by max buyprice desc

SELECT productcode,productname,MAX(buyprice) AS maxprice
FROM products
GROUP BY productline
ORDER BY maxprice DESC;

-- write a query to get lowest buyprice from the products
SELECT productname,MIN(buyprice)
FROM products;

-- -- write a query to get lowest buyprice as per productline . Order by min buyprice desc

SELECT productcode,productname,MIN(buyprice) AS minprice
FROM products
GROUP BY productline
ORDER BY minprice DESC;

-- 1. Write a query to list the number of jobs available in the employees table.
use testcoursedb;
SELECT COUNT(DISTINCT Job_id)
FROM employees
WHERE job_id IS NOT NULL;

-- 2. Write a query to get the total salaries payable to employees
SELECT SUM(salary) AS TotalSalary
FROM employees;

-- 3. Write a query to get the minimum salary from employees table.
SELECT MIN(Salary) as Minsalary
FROM employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
SELECT job_id,MAX(salary)
FROM employees
WHERE job_id='IT_PROG';
-- 5. Write a query to get the average salary and number of employees working the department 90.

SELECT department_id, AVG(salary),COUNT(employee_id)
FROM employees
WHERE DEPARTMENT_ID=90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
SELECT MAX(salary) AS MaxSalary,
	MIN(salary) AS MinSalary,
    SUM(salary) AS TotalSalary,
    AVG(salary) AS AverageSalary
FROM employees;

-- 7. Write a query to get the number of employees with the same job.
SELECT job_id, COUNT(employee_id)
FROM employees
GROUP BY job_id;

-- 8. Write a query to get the difference between the highest and lowest salaries.

SELECT MAX(salary)-MIN(salary) AS difference
FROM employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.

SELECT  manager_id, employee_id,FIRST_NAME, MIN(salary) as min
FROM employees
GROUP BY manager_id;

-- 10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id, SUM(salary) as TotalSalary
FROM employees
GROUP BY department_id;

-- 11. Write a query to get the average salary for each job ID excluding programmer.

SELECT job_id, AVG(salary)
FROM EMployees
where job_id != 'IT_PROG'
GROUP BY job_id;

-- 12. Write a query to get the total salary, maximum, minimum, average salary of 
--      employees (job ID wise), for department ID 90 only.
SELECT DEPARTMENT_ID,SUM(salary) as TotalSalary , MAX(salary), MIN(salary), AVG(salary) AS AverageSalary
FROM employees
WHERE DEPARTMENT_ID=90;
-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.

SELECT  job_id,first_name,last_name, MAX(salary) AS maxsal
FROM employees
GROUP BY employee_id
HAVING maxsal >= 4000;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT first_name, AVG(salary),COUNT(*) AS noofemp,department_id
FROM employees
GROUP BY department_id
HAVING noofemp > 10;
-- 									