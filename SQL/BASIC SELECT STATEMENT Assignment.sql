use testcoursedb;
-- 1. Write a query to display the names (first_name, last_name) using alias name 
-- “First Name", "Last Name"

SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM employees ;

-- 2. Write a query to get unique department ID from employee table.

SELECT DISTINCT dept_id 
FROM employee;

-- 3. Write a query to get all employee details from the employee table
--     order by first name, descending.

SELECT *
FROM employee
ORDER BY name DESC;

-- 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees
--  (PF is calculated as 12% of salary).

SELECT first_name, last_name,salary,salary*0.12 AS 'PF'
FROM employees;

-- 5. Write a query to get the employee ID, names (first_name, last_name), 
--    salary in ascending order of salary.
SELECT employee_id,first_name, last_name,salary
FROM employees
ORDER BY salary;

-- 6. Write a query to get the total salaries payable to employees.

SELECT SUM(salary) AS Totalsalaries 
FROM employees;

-- 7. Write a query to get the maximum and minimum salary from employees table.

SELECT MAX(Salary) AS MaximumSalary, 
	   MIN(salary) AS MinimumSalary
FROM employees;

-- 8. Write a query to get the average salary and number of employees in the employees table.

SELECT AVG(salary) AS Average , COUNT(employee_id) AS ' Number of Employees'
FROM employees;

-- 9. Write a query to get the number of employees working with the company.
SELECT COUNT(DISTINCT employee_id) AS ' Number of Employees'
FROM employees;

-- 10. Write a query to get the number of jobs available in the employees table.
SELECT COUNT(DISTINCT job_id) AS 'Number of jobs available'
FROM employees;

-- 11. Write a query get all first name from employees table in upper case.

SELECT UPPER(first_name)
FROM employees;

-- 12. Write a query to get the first 3 characters of first name from employees table.
SELECT SUBSTRING(first_name,1,3)
FROM employees; 								-- SUBSTRING(string, start pos, length)

-- 13. Write a query to calculate 171*214+625.
SELECT  171*214+625;

-- 14. Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) 
-- of all the employees from employees table.

SELECT CONCAT(first_name,' ',last_name)
FROM employees;

-- 15. Write a query to get first name from employees table after removing 
--  white spaces from both side.
SELECT trim(' ' FROM first_name)
FROM employees;

-- 16. Write a query to get the length of the employee names (first_name, last_name) 
-- from employees table

SELECT length(First_name) AS Firstlength , LENGTH(last_name) AS lastlength
FROM employees;

-- 17. Write a query to check if the first_name fields of the employees table 
--    contains numbers.
SELECT *
FROM employees
 WHERE first_name regexp (0-9);	-- regular expression regrex
 
 
 -- 18. Write a query to select first 10 records from a table.
 SELECT * 
 FROM employees LIMIT 10;  -- The LIMIT clause is used to specify the number of records to return.
 
 -- 19. Write a query to get monthly salary (round 2 decimal places) of each and every 
 -- employee Note : Assume the salary field provides the 'annual salary' information.
 
 SELECT employee_id,first_name, last_name, ROUND(salary/12,2) AS monthlySalary
 FROM employees;
 -- The ROUND() function rounds a number to a specified number of decimal places.
 -- Syntax ROUND(number, decimals, operation)
 
 SELECT department_id
 From departments
 limit 5,5; 	-- limit [offset,] row_count
 
 