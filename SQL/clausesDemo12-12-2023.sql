USE classicmodels;
 SHOW TABLES;
 desc employees;
 
 SELECT lastName
 FROM employees;
 
 SELECT firstName,lastName,jobTitle
 From employees;
 
SELECT * 
FROM employees;

SELECT employeeNumber, lastName, firstName, extension,email,officeCode,reportsTo,jobTitle
FROM employees;

SELECT  1+1;
SELECT NOW();  -- output current date and time
SELECT CONCAT('Yogesh','Nawale');  -- to concat strings
SELECT CONCAT ('Yogesh ',':',' Nawale') AS EmployeeName;  -- alias  AS name used to give heading 
SELECT CONCAt(firstName,' ',lastName) AS 'full Name'
FROM employees;

DESC customers;
-- sort customers by their lastname in descending order 
SELECT contactLastName 
FROM customers
ORDER BY contactLastName DESC;

-- sort customers by their lastname in descending order and firstname in ascending order
SELECT contactLastName,contactFirstName
FROM customers
ORDER BY
contactLastName DESC,
contactFirstName ASC; -- note only one column gets sorted

DESC orderdetails;

SELECT productCode,orderNumber,quantityOrdered*priceEach AS 'Total Price'
FROM orderdetails;
SELECT productCode,orderNumber,quantityOrdered*priceEach AS 'TotalPrice'
FROM orderdetails
ORDER BY TotalPrice DESC;

SELECT FIELD ('C','A','B','C','s','c');

DESC orders;

SELECT orderNumber,status
FROM orders
ORDER BY FIELD(status,
'In Process',
'On Hold',
'Cancelled',
'Resolved',
'Disputed',
'Shipped'
);

SELECT firstName, lastName,reportsTo
FROM employees
ORDER BY reportsTo;

-- select all employes with job title 'Sales Rep'
SELECT * 
FROM employees
WHERE jobTitle="Sales Rep";

-- select all employes with job title 'Sales Rep' and office code is 1
SELECT *
FROM employees
WHERE jobTitle='Sales Rep' AND officeCode=1;

-- select all employes with job title 'Sales Rep' or office code is 1
SELECT firstName,lastName,jobTitle,officeCode
FROM employees
WHERE jobTitle='Sales Rep' OR officeCode=1;

-- select all employes with  office code is between 1 to 3
SELECT firstName,lastName,officeCode
FROM employees
WHERE officeCode BETWEEN 1 AND 3;

SELECT firstName,lastName
FROM employees
WHERE lastName like '%son';

-- select employee with 5 character(size ) first name
SELECT firstNAme,lastName
FROM employees
WHERE firstName LIKE '_____';

-- select employee with officecode 1,2,3
SELECT firstname, lastname,officeCode
FROM employees
WHERE officeCode IN(1,2,3);

-- select all employees who does not reportTo anyone
SELECT firstname, lastname,reportsto
FROM employees
WHERE reportsto IS NULL;

-- find out all employees who are not sales rep
SELECT firstname, lastname,jobtitle
FROM employees
WHERE jobtitle != 'Sales Rep';

SELECT firstname, lastname,jobtitle
FROM employees
WHERE jobtitle <>'Sales Rep';

-- find out all employees whose officecode is greater than 5
SELECT firstname, lastname,officecode
FROM employees
WHERE officecode >5;

-- find out all employees whose officecode isless than equal to 4
SELECT firstname, lastname,officecode
FROM employees
WHERE officecode <=4;
