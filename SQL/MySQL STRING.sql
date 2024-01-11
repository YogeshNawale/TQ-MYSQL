	-- ---------------------MySQL string----------------------------------------
    use   testcoursedb;
    
/* 1. Write a query to get the job_id and related employee's id.
 Partial output of the query : job_id Employees ID 
 AC_ACCOUNT 206
 AC_MGR 205
 AD_ASST 200
 AD_PRES 100
 AD_VP 101 ,102 
 FI_ACCOUNT 110 ,113 ,111 ,109 ,112 */
 
 SELECT job_id, GROUP_CONCAT(employee_id,' ') as employee_id
 FROM employees
 GROUP BY job_id;
 
 /*2. Write a query to update the portion of the phone_number in the employees table,
 within the phone number the substring '124' will be replaced by '999'. Sample table: employees */
  
 UPDATE employees
 SET phone_number = replace(phone_number,'124','999')
 WHERE phone_number LIKE '%124%';
 
 SELECT phone_number 
 FROM employees;
 
 -- 3. Write a query to get the details of the employees where the length of the first name 
 -- 		greater than or equal to 8. Sample table: employees
 
 SELECT *
 FROM employees
 WHERE length(first_name)>=8;
 
 -- 4. Write a query to display leading zeros before maximum and minimum salary. Sample table: jobs
 
SELECT job_id,  LPAD( max_salary, 7, '0') AS 'Max Salary' ,
LPAD( min_salary, 7, '0') AS ' Min Salary' 
FROM jobs;

/*5. Write a query to append '@example.com' to email field. Sample table: employees Sample Output : 
EMAIL -------------------- 
SKING@example.com 
NKOCHHAR@example.com 
LDEHAAN@example.com
AHUNOLD@example.com 
BERNST@example.com 
DAUSTIN@example.com 
VPATABAL@example.com
 DLORENTZ@example.com
 NGREENBE@example.com
 - - - - - - - - - - -
*/
SELECT CONCAT(email,'@example.com') AS EMAIL   --  temperory changes 
FROM employees;

UPDATE employees 							-- permanant changes
SET email = CONCAT(email, '@example.com');

SELECT email
from employees;

-- 6. Write a query to get the employee id, first name and hire month. Sample table: employees
SELECT employee_id, first_name, month(hire_date) AS month
FROM employees;

-- 7. Write a query to get the employee id, email id (discard the last three characters). Sample table: employees

SELECT employee_id, REVERSE(SUBSTR(REVERSE(email), 4)) as Email_ID 
from employees;

-- 8. Write a query to find all employees where first names are in upper case. Sample table: employees

SELECT first_name 
FROM employees
WHERE first_name=BINARY(UPPER(first_name));

-- 9. Write a query to extract the last 4 character of phone numbers. Sample table: employees

SELECT SUBSTRING(phone_number,-4)   -- SUBSTR(col_name, start pos, [length])
FROM employees;

-- 10. Write a query to get the last word of the street address. Sample table: locations
SELECT SUBSTRING_INDEX(street_address,' ',-1) AS lastWord
FROM locations;

-- 11. Write a query to get the locations that have minimum street length. Sample table: locations

SELECT * 
FROM locations
WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address)) 
FROM locations);

-- 12. Write a query to display the first word from those job titles which 
-- 	   contains more than one words. Sample table: jobs

SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;
-- SELECT INSTR(job_title, ' ') FROM jobs;

-- 13. Write a query to display the length of first name for employees
--  where last name contain character 'c' after 2nd position. Sample table: employees
;
SELECT first_name,last_name,CHARACTER_LENGTH(first_name)
FROM employees
WHERE LOCATE('c',last_name,3) >0;

SELECT first_name, last_name FROM employees WHERE INSTR(last_name,'C') > 2;

/*14. Write a query that displays the first name and the length of the first name for
 all employees whose name starts with the letters 'A', 'J' or 'M'. 
 Give each column an appropriate label. Sort the results by the employees' first names.
 Sample table: employees */
 
 SELECT first_name, length(first_name) as length
 FROM employees
 WHERE first_name LIKE ('A%') OR first_name LIKE ('J%') OR first_name LIKE ('M%')
 GROUP BY first_name;
 

-- 15. Write a query to display the first name and salary for all employees. Format the salary to 
-- be 10 characters long, left-padded with the $ symbol. Label the column SALARY.
-- Sample table: employees 

SELECT first_name, LPAD(salary, 10,'$') as salary
FROM employees;

-- 16. Write a query to display the first eight characters of the employees' first names and 
-- indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. 
-- Sort the data in descending order of salary. 
-- Sample table: employees

SELECT substring(first_name, 1,8) as name, REPEAT('$', FLOOR(salary/1000)) as 'SALARY($)',  salary
FROM employees
ORDER BY salary DESC;

SELECT left(first_name, 8), REPEAT('$', FLOOR(salary/1000)) as'SALARY($)', salary
FROM employees
ORDER BY salary DESC;

-- 17. Write a query to display the employees with their code, first name, last name and hire date who
-- hired either on seventh day of any month or seventh month in any year.

SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE month(hire_date)='7' OR day(hire_date)='7';

SELECT employee_id,first_name,last_name,hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;