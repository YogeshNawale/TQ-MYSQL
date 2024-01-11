# joins

use classicmodels;
-- inner join
SELECT *
FROM orders o, orderdetails o1
WHERE o.ordernumber= o1.ordernumber;

SELECT *
FROM orders o
INNER JOIN orderdetails o1
ON o.ordernumber= o1.ordernumber; 

-- another method
SELECT *
FROM orders o
INNER JOIN orderdetails o1
USING (ordernumber);     --  column name in both tables should be same

-- multiple joins
SELECT ordernumber, productcode, orderdate, status, customernumber, customername
FROM orders
INNER JOIN orderdetails USING(ordernumber)
INNER JOIN customers USING (customernumber);

-- left outer join
-- select all countries information along with location info
use testcoursedb;
SELECT c.country_id, country_name, l.country_id, city
FROM countries c
LEFT JOIN locations l
ON c.country_id= l.country_id;

-- find country that does not have any location in the locations
SELECT c.country_id, country_name, l.country_id, city
FROM countries c
LEFT JOIN locations l
ON c.country_id= l.country_id
WHERE l.COUNTRY_ID IS NOT null;

-- self Join
USE classicmodels;
SELECT e.employeenumber, concat(e.firstname, ' ', e.lastname ) as 'Employee' , e.reportsTo as 'Manager 
Number', CONCAT(m.firstname, ' ', m.lastname )
FROM employees e
INNER JOIN employees m
ON e.reportsTo = m.employeenumber;


-- right join

-- find all employeenumbers and customernumber where employee work as salesRepnumber

use classicmodels;

SELECT employeenumber, customernumber
FROM customers
RIGHT JOIN employees
ON salesRepEmployeeNumber= employeeNumber
ORDER BY employeeNumber;


-- ----------------------------- SQL JOINS assignments ---------------------------------------------

-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, 
--     country_name) of all the departments.

use testcoursedb;

SELECT *
FROM locations;

SELECT location_id, street_address, city, state_province,country_name
FROM departments
LEFT JOIN locations USING (location_id)
LEFT JOIN countries USING (country_id) ;

-- 2. Write a query to find the names (first_name, last name), department ID and name of all the employees.

SELECT CONCAT(e.first_name,' ',  e.last_name) as 'Employee_Name', e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d USING (department_id);

-- 3. Find the names (first_name, last_name), job, department number, and department name of the 
--     employees who work in London.

SELECT CONCAT(e.first_name,' ',  e.last_name) as 'Employee_Name',e.job_id, j.job_title, e.department_id, 
	d.department_name
FROM employees e
INNER JOIN jobs j USING (job_id)
INNER JOIN departments d USING (department_id)
WHERE d.location_id IN(SELECT location_id FROM locations WHERE city= 'London');

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id, 
--    manager name (last_name).

SELECT e1.employee_id, e1.last_name, e2.employee_id, e2.last_name as 'Manager_Name'
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id= e2.employee_id;

-- 5. Find the names (first_name, last_name) and hire date of the employees who were hired after 'Jones'.

SELECT e2.first_name, e2.last_name , e2.hire_date
FROM employees e1
INNER JOIN employees e2 ON (e1.last_name='jones')
WHERE  e1.hire_date < e2.hire_date;

-- 6. Write a query to get the department name and number of employees in the department.

SELECT  d.department_name, count(employee_id)
FROM departments d 
LEFT JOIN employees USING(department_id)
GROUP BY d.DEPARTMENT_id;

-- 7. Find the employee ID, job title, number of days between ending date and starting date for all 
--   jobs in department 90 from job history.

SELECT j1.employee_id, j2.job_title, datediff(j1.end_date,j1.start_date) as NO_of_days
FROM job_history j1
INNER JOIN jobs j2 USING(job_id)
WHERE j1.department_id=90 ;

-- 8. Write a query to display the department ID, department name and manager first name.

SELECT d.department_id, d.department_name, e.first_name
FROM departments d
LEFT JOIN employees e ON(d.manager_id=e.employee_id);

-- 9. Write a query to display the department name, manager name, and city.

SELECT d.department_name, e.first_name, e.last_name, l.city
FROM departments d
LEFT JOIN employees e ON (d.manager_id= e.employee_id)
LEFT JOIN locations l USING(location_id);

-- 10. Write a query to display the job title and average salary of employees.

SELECT job_title, ROUND(AVG(salary),2)
FROM jobs j
LEFT JOIN employees e USING(job_id)
GROUP BY j.job_title;

-- 11. Display job title, employee name, and the difference between salary of the employee and
--     minimum salary for the job.

SELECT j.job_title, CONCAT(e.first_name,' ', e.last_name) as employee_name,  (e.salary-j.min_salary) as diff
FROM employees e
LEFT JOIN jobs j USING(job_id);

-- 12. Write a query to display the job history that were done by any employee who is currently drawing
--     more than 10000 of salary

SELECT j.*
FROM job_history j
INNER JOIN employees e USING (employee_id)
where salary>10000;

-- 13. Write a query to display department name, name (first_name, last_name), hire date, 
--     salary of the manager for all managers whose experience is more than 36.3 years.

SELECT department_name,  first_name, last_name, hire_date, salary
FROM employees e
LEFT JOIN departments d ON (e.employee_id= d.manager_id)
WHERE datediff(curdate(),hire_date)/365 > 36.3;

SELECT datediff(curdate(),hire_date)/365
FROM employees;

-- ----------------------------practice set 2-----------------------------------------

-- 1>	Write a query to select employee with the highest salary


SELECT * , MAX(e1.Salary) 
FROM Employees e1 
RIGHT JOIN employees e2 ON (e1.salary=(SELECT max(salary) FROM employees));

-- 2>	Select employee with the second highest salary

SELECT * , MAX(e1.Salary) 
FROM Employees e1 
RIGHT JOIN employees e2 ON (e2.salary<(SELECT max(salary) FROM employees));

-- 3>	Write a query to select employees and their corresponding managers and their salaries

SELECT e1.first_name, e1.last_name, e1.salary, e2.first_name, e2.last_name, e2.salary
FROM employees e1
INNER JOIN employees e2 ON (e1.employee_id= e2.MANAGER_ID);

-- 4>	Write a query to show count of employees under each manager in descending order

SELECT e2.employee_id, e2.first_name, e2.last_name, COUNT(e1.employee_id) AS number_of_employees
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
GROUP BY e2.employee_id, e2.first_name, e2.last_name
ORDER BY number_of_employees DESC;

-- 5>	Find the count of employees in each department

SELECT e1.department_id, d.department_name, COUNT(e1.employee_id) AS number_of_employees
FROM employees e1
LEFT JOIN departments d USING (department_id)
GROUP BY d.department_id
ORDER BY number_of_employees DESC;

-- 6>	Get the count of employees hired year wise

SELECT year(e2.hire_date),COUNT(e1.employee_id) as no_of_emp
FROM employees e1
INNER JOIN employees e2 USING (employee_id)
GROUP BY year(e2.hire_date); 

-- 7>	Select the employees whose first_name contains “an”

SELECT e2.*
FROM employees e1
INNER JOIN employees e2 USING(employee_id ) 
where e2.FIRST_NAME LIKE '%an%';

-- 8>	Find the employees who joined in August, 1987.
SELECT e2.*
FROM employees e1
INNER JOIN employees e2 USING (employee_id)
WHERE MONTH(e2.hire_date)=08 AND  YEAR(e2.hire_date)=1987;

-- 9>	Write an SQL query to display employees who earn more than the average salary in that company

SELECT e2.*
FROM employees e1
INNER JOIN employees e2 USING(employee_id)
WHERE e2.salary > (SELECT AVG(salary) FROM employees);

-- 10>	Find the maximum salary from each department.
SELECT department_name, MAX(salary)
FROM employees e
RIGHT JOIN departments d USING(department_id)
GROUP BY department_name;

-- 11>	Write a query to make deptid foreign key in employee table.




-- 13>	Write a query to show employee names and department names for each employee. 
SELECT first_name, last_name, department_name
FROM employees e
LEFT JOIN departments d USING (department_id);

-- 14>	Show name of city where ‘Ramesh’ is working.

SELECT city
FROM employees e
INNER JOIN departments d USING (department_id)
INNER JOIN locations l USING (location_id)
WHERE first_name='John';

-- 15>	Write a query to show name of city and number of employees working in that city.

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT city, COUNT(employee_id)
FROM locations
INNER JOIN departments d USING (location_id)
INNER JOIN employees e USING (department_id)
GROUP BY city;

-- 16>	Show all employees who are working in HR department and having salary less than 5000

SELECT e.*
FROM employees e 
LEFT JOIN departments USING (department_id)
WHERE department_name='Human Resources' AND salary<8000; 

-- 17>	Show employee having highest salary. 

SELECT e1.*
FROM employees e1
INNER JOIN employees e2 USING(employee_id)
WHERE e1.salary = (SELECT MAX(salary) FROM employees);

-- 18>	Show name of department along with number of employees working in that city.

SELECT city, department_name, count(employee_id)
FROM departments d
INNER JOIN employees USING (department_id)
INNER JOIN locations USING (location_id)
GROUP BY city;

-- 19>	Show city wise number of employees

SELECT city,  count(employee_id)
FROM departments d
INNER JOIN employees USING (department_id)
INNER JOIN locations USING (location_id)
GROUP BY city;

-- 20>	Show city name and total salary of employees working in that city.


SELECT city,  SUM(SALARY) as Total_salary
FROM departments d
INNER JOIN employees USING (department_id)
INNER JOIN locations USING (location_id)
GROUP BY city;

-- ---------------------------------assignment -------------------------------------
CREATE DATABASE joinsAssignment;
USE joinsAssignment;

CREATE TABLE employee(
empid INT PRIMARY KEY ,
 name VARCHAR(50),
 salary DECIMAL(8,2) ,
 deptid INT ,
 magrid INT );

CREATE TABLE department ( 
deptid INT PRIMARY KEY ,
deptname VARCHAR(50) ,
city VARCHAR(30)); 
 
 -- 1.	Write a query to make deptid foreign key in employee table.
 ALTER TABLE employee
 ADD  CONSTRAINT dept_const FOREIGN KEY (deptid)REFERENCES department(deptid);
 
 DESC employee;
 
 -- 2.	Write a query to insert multiple rows in both tables using one insert command.
 
 INSERT INTO department (deptid, deptname, city) VALUES 
(101, 'ACCOUNTING', 'PUNE'),
(102, 'RESEARCH', 'MUMBAI'),
(103, 'SALES', 'DELHI'),
(104, 'OPERATIONS', 'HYDRABAD'),
(105, 'HR', 'BANGLORE') ;

INSERT INTO employee(empid, name, salary , deptid, magrid ) VALUES 
(1,'yogesh',53000,101,4),
(2,'suraj',45000,102,3),
(3,'ishwar',32000,101,4),
(4,'adarsh',21000,103,1),
(5,'abhishek',65000,105,2),
(6,'shehal',54000,104,1),
(7,'utkarsha',32000,105,5),
(8,'sumit',22000,101,3),
(9,'prasad',42000,103,4),
(10,'amit',33000,101,2);

-- 3.	Write a query to show employee names and department names for each employee. 

SELECT name, deptname
FROM employee
INNER JOIN department USING(deptid);

-- 4.	Show name of city where ‘ishwar’ is working.

SELECT name, city
FROM employee
INNER JOIN department USING (deptid)
WHERE name='ishwar';
 
 -- 5.	Write a query to show name of city and number of employees working in that city.
 
 SELECT  city, count(empid)
FROM employee
INNER JOIN department USING (deptid)
GROUP BY city;

-- 6.	Show all employees who are working in HR department and having salary less than 50000

SELECT name, deptname,salary
FROM employee
INNER JOIN department USING (deptid)
WHERE deptname='HR' AND salary<50000;

-- 7.	Show employee having highest salary. 

SELECT name, deptname,MAX(salary) as max_sal
FROM employee
INNER JOIN department USING (deptid)
WHERE salary=(SELECT MAX(salary) FROM employee);

-- 8.	Show name of department along with number of employees working in that city.

SELECT city,deptname , count(empid)
FROM employee
INNER JOIN department USING(deptid)
GROUP BY city;

-- 9.	Show city wise number of employees
 
 SELECT city,deptname , count(empid) as no_of_emp
FROM employee
INNER JOIN department USING(deptid)
GROUP BY city;

-- 10.	Show city name and total salary of employees working in that city.

 SELECT city,deptname , count(empid) as no_of_emp, SUM(salary) as total_sal
FROM employee
INNER JOIN department USING(deptid)
GROUP BY city; 

-- 11.	Show names of all employees working under ‘adarsh’

SELECT empid,name
FROM employee
INNER JOIN department USING(deptid)
WHERE magrid=(SELECT empid FROM employee WHERE  name='adarsh');

-- 12.	Show names of all employees working in same department as ‘yogesh’ 

SELECT empid,name
FROM employee
INNER JOIN department USING (deptid)
WHERE deptid=(SELECT deptid FROM employee WHERE name='yogesh');

-- 13.	Show all names of all employees having same salary as ‘ishwar’

SELECT empid, name, salary
FROM employee
INNER JOIN department USING(deptid)
WHERE salary=(SELECT salary FROM employee WHERE name='ishwar'); 

-- 14.	Delete data of all employees working in ‘HR’ department.
DELETE FROM employee
WHERE deptid IN(SELECT DISTINCT deptid FROM employee INNER JOIN department USING(deptid)
				WHERE deptname='HR');

-- 15.	Delete all employees whose salary is less than 30000 and working in ‘Sales’ department.
DELETE FROM employee
WHERE empid IN(
SELECT empid
FROM employee
INNER JOIN department USING(deptid)
WHERE deptname='SALES' AND salary<30000);

-- 16.	Increase salary of all employees working in ‘Mumbai’ city by 20%

UPDATE employee
SET salary= salary*1.2
WHERE empid IN (SELECT empid FROM employee INNER JOIN department USING (deptid) 
				WHERE city='Mumbai');
                
-- 17.	Change ‘suraj’s department to ‘HR’
/*	UPDATE tablename  
	INNER JOIN tablename  
	ON tablename.columnname = tablename.columnname  
	SET tablenmae.columnnmae = tablenmae.columnname;*/
UPDATE  employee 
SET deptid= e.deptid 
FROM employee e
INNER JOIN department d USING (deptid) 
WHERE deptname='HR' AND e.name ='suraj';


-- 18.	Increase salary of all employees who are working under manager ‘adarsh’

SELECT e2.empid
FROM employee e1
INNER JOIN employee e2 ON (e2.magrid =e1.empid)
where  e1.name='adarsh';

UPDATE employee
SET salary = salary *1.02
WHERE empid in(SELECT e2.empid
FROM employee e1
INNER JOIN employee e2 ON (e2.magrid =e1.empid)
where  e1.name='adarsh');

-- 19.	Show names of all cities where any of the employee working in that city is having salary > 50000

SELECT city
FROM employee
INNER JOIN department USING (deptid)
WHERE salary>50000;

-- 20.	Show names of all cities where less than 10 employees are working.

SELECT city
FROM employee
INNER JOIN department USING (deptid)
GROUP BY city
HAVING  COUNT(empid)<10;

