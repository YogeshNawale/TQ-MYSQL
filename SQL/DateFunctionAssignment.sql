USE testcoursedb;

-- 1.	Find the names of employees hired in the last 3 months

SELECT employee_id, first_name, last_name
FROM Employees
Where DATEDIFF( current_date, Hire_Date)/30 Between 1 and 3;

-- 2.	Retrieve employees hired on a specific date

SELECT first_name , last_name , hire_date 
FROM employees
 WHERE hire_date ='1987-07-04';
 
 -- 3.	Count the number of employees hired each year
 
 SELECT COUNT(*), year(hire_date)
 FROM employees 
 GROUP BY year(hire_date);
 
 -- 4.	List employees with birthdays in the next 30 days
 
select employee_id, FIRST_NAME, last_name, hire_date
  from employees
 where adddate(hire_date,interval 37 year) BETWEEN current_date()  AND adddate(current_date(),INTERVAL 1 month);



-- 5.	Find employees who have been with the company for more than 36.5 years

SELECT * FROM employees 
WHERE (datediff(current_date,hire_date)/365)  > 36.5;

-- 6.	Calculate the average age of employees

SELECT avg(datediff(current_date,hire_date)/365) as avg_age FROM employees;

-- 7.	List employees with no hire date (potentially missing data)

SELECT * FROM employees
WHERE hire_date IS null ;

-- 8.	Find the earliest and latest hire dates

SELECT MAX(hire_date), MIN(hire_date)
FROM employees;

-- 9.	Retrieve employees with the same birth date

SELECT e1.employee_id, e1.first_name, e1.hire_date,e2.employee_id, e2.first_name, e2.hire_date
FROM employees e1
INNER JOIN employees e2 ON(e1.hire_date = e2.hire_date)
WHERE e1.employee_id != e2.employee_id;

-- 10.	List employees and their age in descending order

SELECT * , datediff(current_date, hire_date)/365 as age_diff
FROM employees 
ORDER BY age_diff DESC;

-- 11.	Find employees hired in the current year

SELECT * FROM employees
WHERE year(hire_date) = year(current_date());

-- 12.	Count the number of employees born in each month

SELECT month(hire_date),COUNT(*) FROM employees
GROUP BY month(hire_date);

-- 13.	List employees with a hire date and a birth date on the same day

SELECT * FROM employees
WHERE month(hire_date)= month(birth_date) AND day(hire_date)= day(birth_date);

-- 14.	Find employees with a birth date in a specific range

SELECT * FROM employees 
WHERE HIRE_date BETWEEN '1987-06-30' AND '1987-08-01' ;

-- 15.	Calculate the total number of years of experience for all employees

SELECT SUM(datediff(current_date, hire_date)/365) as Total_experience
FROM employees;

-- 16.	Find employees with an upcoming work anniversary within the next month
SELECT * FROM employees
where adddate(hire_date,interval 37 year) BETWEEN current_date()  AND adddate(current_date(),INTERVAL 1 month);

SELECT year(current_date())-year(hire_date)
FROM employees;

-- 17.	Retrieve employees who were born on a weekend (Saturday or Sunday)

/*The WEEKDAY() function returns the weekday number for a given date.
Note: 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.*/

/*
The DAYOFWEEK() function returns the weekday index for a given date (a number from 1 to 7).
Note: 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday.*/

SELECT First_name, hire_date FROM employees
WHERE weekday(hire_date) in (5,6);

SELECT First_name, hire_date FROM employees
WHERE dayofweek(hire_date) in (1,7);

-- 18.	List employees who have not celebrated their birthdays yet this year

-- SELECT * FROM employees
-- where month(hire_date) NOT BETWEEN 

SELECT timestampdiff(year, hire_date ,now()) from employees;



-- 19.	Calculate the average age of employees hired in each year

SELECT year(hire_date) , AVG(datediff(current_date, hire_date)/365) as average_age
FROM employees
GROUP BY year(hire_date);

-- 20.	Find employees with a hire date on a weekday (Monday to Friday)
/*The WEEKDAY() function returns the weekday number for a given date.
Note: 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.*/

/*
The DAYOFWEEK() function returns the weekday index for a given date (a number from 1 to 7).
Note: 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday.*/

SELECT * 
FROM employees
WHERE weekday(hire_date) in (0,1,2,3,4);

SELECT * 
FROM employees
WHERE dayofweek(hire_date) in (2,3,4,5,6);
