use classicmodels;
-- find out all the employees  who work in the offices located in usa

SELECT officecode
FROM offices
WHERE country='USA';

SELECT firstname, lastname 
FROM employees
WHERE officecode IN (SELECT officecode
FROM offices
WHERE country='USA');

-- write a query to find  out customer who has highest payment
SELECT MAX(amount)
FROM payments;

SELECT customernumber
FROM payments
WHERE amount=(SELECT MAX(amount)
FROM payments);

-- customer details of above quo
SELECT contactfirstname, contactlastname, customernumber
FROM customers
WHERE customernumber= (SELECT customernumber
FROM payments
WHERE amount=(SELECT MAX(amount)
FROM payments));

-- find the customers whoose payments are greater than avg payments
SELECT AVG(amount)
FROM payments;
SELECT customernumber, amount
FROM payments
WHERE amount>(SELECT AVG(amount)
FROM payments);

SELECT contactfirstname, contactlastname, customernumber
FROM customers
WHERE customernumber IN (SELECT customernumber
FROM payments
WHERE amount>(SELECT AVG(amount)
FROM payments));

-- find the customer who has not placed any orders
SELECT DISTINCT customernumber
FROM orders;

SELECT contactfirstname, contactlastname
FROM customers
WHERE customernumber NOT IN (SELECT DISTINCT customernumber
FROM orders);

-- find max, min and avg number of items in sales order

SELECT ordernumber, COUNT(ordernumber) AS items 
FROM orderdetails
GROUP BY ordernumber;

SELECT MAX(items), MIN(items), FLOOR(AVG(items))
FROM (SELECT ordernumber, COUNT(ordernumber) AS items 
FROM orderdetails
GROUP BY ordernumber) AS lineitems;

-- corelated sub-query
-- Select the products whoose buyprices are greater than average buyprices of all the products in 
-- 		each product line
SELECT avg(buyprice) FROM products;

SELECT productcode, productline, buyprice
FROM products p1
WHERE buyprice > (SELECT avg(buyprice) FROM products
WHERE productline= p1.productline);
							-- subQuery Assignment---
                            
use testcoursedb;
-- 1. Write a query to find the names (first_name, last_name) and the salaries of the employees
--  who have a higher salary than the employee whose last_name='Bull'.

SELECT first_name, last_name, salary
FROM employees
WHERE salary>( SELECT salary
FROM employees
WHERE last_name='Bull');

-- SELECT salary FROM employees WHERE last_name='Bull';

-- 2. Write a query to find the names (first_name, last_name) of all employees who works in the
--    IT department.
SELECT first_name, last_name,department_id
FROM employees
WHERE department_id=(SELECT department_id
FROM departments
where department_name='IT');

-- SELECT department_id FROM departments where department_name='IT';

-- 3. Write a query to find the names (first_name, last_name) of the employees who have a manager 
-- and work for a department based in the United States. Hint : 
-- Write single-row and multiple-row subqueries

SELECT location_id
FROM locations
WHERE country_id="US";

SELECT department_id
FROM departments
WHERE location_id IN (SELECT location_id
FROM locations
WHERE country_id="US");

SELECT employee_id 
FROM employees 
WHERE department_id IN (SELECT department_id
FROM departments
WHERE location_id IN (SELECT location_id
FROM locations
WHERE country_id="US" ));


SELECT first_name,last_name 
FROM employees
WHERE  manager_id IN (SELECT employee_id 
FROM employees 
WHERE department_id IN (SELECT department_id
FROM departments
WHERE location_id IN (SELECT location_id
FROM locations
WHERE country_id="US" )));

SELECT first_name, last_name FROM employees 
WHERE manager_id in (select employee_id 
FROM employees WHERE department_id 
IN (SELECT department_id FROM departments WHERE location_id 
IN (select location_id from locations where country_id='US')));

-- 3. Write a query to find the names (first_name, last_name) of the employees who are managers.

SELECT manager_id
FROM employees;

SELECT first_name, last_name, employee_id
FROM employees
WHERE  employee_id IN (SELECT manager_id
FROM employees);

-- 4. Write a query to find the names (first_name, last_name), the salary of the employees whose
--    salary is greater than the average salary.

SELECT AVG(salary)
FROM employees;

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
FROM employees);

-- 5. Write a query to find the names (first_name, last_name), the salary of the employees whose 
-- salary is equal to the minimum salary for their job grade.

SELECT job_title,min_salary
FROM jobs;

SELECT first_name, last_name, salary 
FROM employees 
WHERE employees.salary = (SELECT min_salary
FROM jobs
WHERE employees.job_id = jobs.job_id);

-- 6. Write a query to find the names (first_name, last_name), the salary of the employees who earn
--  more than the average salary and who works in any of the IT departments.

SELECT department_id
FROM departments
WHERE department_name='IT';

SELECT first_name, last_name,salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees ) AND department_id IN (SELECT department_id
FROM departments
WHERE department_name='IT');

SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN 
(SELECT department_id FROM departments WHERE department_name LIKE 'IT%') 
AND salary > (SELECT avg(salary) FROM employees);

-- 7. Write a query to find the names (first_name, last_name), the salary of the employees 
--     who earn more than Mr. Bell.

SELECT salary
FROM employees
WHERE last_name LIKE '%BELL%';

SELECT first_name, last_name, salary
FROM employees
WHERE salary >(SELECT salary
FROM employees
WHERE last_name LIKE '%BELL%');

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 
(SELECT salary FROM employees WHERE last_name = 'Bell') 
ORDER BY first_name;

-- 8. Write a query to find the names (first_name, last_name), the salary of the employees 
--    who earn the same salary as the minimum salary for all departments.

SELECT MIN(salary)
FROM employees;

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary = (SELECT MIN(salary)
FROM employees);

SELECT * FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 9. Write a query to find the names (first_name, last_name), the salary of the employees whose
--    salary greater than the average salary of all departments.

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary)
FROM employees);

SELECT * FROM employees 
WHERE salary > 
ALL(SELECT avg(salary)FROM employees GROUP BY department_id);

-- 10. Write a query to find the names (first_name, last_name) and salary of the employees 
-- who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK').
--  Sort the results of the salary of the lowest to highest.

SELECT MAX(salary) 
FROM employees
WHERE JOB_ID = 'SH_CLERK';

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > (SELECT MAX(salary) 
FROM employees
WHERE JOB_ID = 'SH_CLERK')
ORDER BY salary ;

SELECT first_name,last_name, job_id, salary 
FROM employees 
WHERE salary > 
ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK') ORDER BY salary;

-- 11. Write a query to find the names (first_name, last_name) of the employees who are not supervisors.

SELECT b.first_name,b.last_name 
FROM employees a ,employees b
WHERE NOT EXISTS (SELECT 'X' FROM employees a WHERE a.manager_id = b.employee_id)
GROUP BY b.first_name,b.last_name ;

SELECT first_name, last_name
FROM employees b
WHERE NOT EXISTS( SELECT * FROM employees a WHERE a.manager_id = b.employee_id);

-- 12. Write a query to display the employee ID, first name, last names, 
--     and department names of all employees. 

SELECT department_name, department_id
FROM departments;

SELECT employee_id,first_name, last_name,  a.department_name
FROM employees , (SELECT department_name, department_id
FROM departments) AS a;

SELECT employee_id, first_name, last_name, 
(SELECT department_name FROM departments d
 WHERE e.department_id = d.department_id) department 
 FROM employees e ORDER BY department;

-- 13. Write a query to display the employee ID, first name, last names, salary of all employees 
-- whose salary is above average for their departments.

SELECT AVG(salary)
FROM employees
GROUP BY department_id;


SELECT employee_id, first_name, last_name, salary
FROM employees AS A 
WHERE salary > 
(SELECT AVG(salary) FROM employees WHERE department_id = A.department_id);

-- 14. Write a query to fetch even numbered records from employees table.

SELECT * 
FROM employees
WHERE employee_id%2=0;

SET @i = 0; 
SELECT i, employee_id 
FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees)
a WHERE MOD(a.i, 2) = 0;

-- 15. Write a query to find the 5th maximum salary in the employees table.
SELECT DISTINCT salary
FROM employees 
ORDER BY salary DESC
LIMIT 4,1;

SELECT DISTINCT salary 
FROM employees e1 
WHERE 5 = (SELECT COUNT(DISTINCT salary) 
FROM employees  e2 
WHERE e2.salary >= e1.salary);

-- 16. Write a query to find the 4th minimum salary in the employees table.

SELECT DISTINCT salary
FROM employees a
WHERE 4= (SELECT COUNT(DISTINCT salary)
FROM employees b
WHERE b.salary <= a.salary);

-- 17. Write a query to select last 10 records from a table.

SELECT * FROM (
SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) sub 
ORDER BY employee_id ASC;

-- 18. Write a query to list department number, name for all the departments in which there 
--     are no employees in the department.

SELECT  DISTINCT department_id
FROM employees;


SELECT * FROM departments 
WHERE department_id 
NOT IN (select department_id FROM employees);

-- 19. Write a query to get 3 maximum salaries.


SELECT salary FROM (
SELECT salary FROM employees ORDER BY salary DESC LIMIT 3) sub 
ORDER BY salary ASC;

SELECT DISTINCT salary 
FROM employees a 
WHERE 3 >= (SELECT COUNT(DISTINCT salary) 
FROM employees b 
WHERE b.salary >= a.salary) 
ORDER BY a.salary DESC;

-- 20. Write a query to get 3 minimum salaries.

SELECT salary
FROM (SELECT DISTINCT salary FROM employees ORDER BY salary LIMIT 3 ) sub
ORDER BY salary;

SELECT DISTINCT salary 
FROM employees a
WHERE 3 >= (SELECT COUNT(DISTINCT salary) FROM employees b
WHERE b.salary <= a.salary)
ORDER BY a.salary;

-- 21. Write a query to get nth max salaries of employees.

SELECT *
FROM employees emp1
WHERE (1) = (
SELECT COUNT(DISTINCT(emp2.salary))
FROM employees emp2
WHERE emp2.salary > emp1.salary);
