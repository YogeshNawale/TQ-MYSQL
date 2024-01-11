use testcoursedb;
SELECT * FROM employee_contacts;

SHOW FULL TABLES;

USE classicmodels;

SELECT od.orderNumber, customerName, customerNumber, salesRepEmployeeNumber, phone, SUM(od.quantityOrdered * od.priceeach) as sum
FROM orders  o
INNER JOIN orderdetails od USING (orderNumber)
INNER JOIN customers c USING (customerNumber)
GROUP BY od.ordernumber;

SELECT * FROM sum_quantityorderd_priceeach;

SELECT *
FROM products 
WHERE buyprice> (SELECT avg(buyprice) FROM products);

SELECT p1.*
FROM products p1
INNER JOIN products p2 USING(productCode)
WHERE p1.buyPrice > (SELECT avg(buyprice) FROM products);

SELECT * FROM pricegreaterthanAvgprice;

SELECT customerName, count(ordernumber)
FROM customers
INNER JOIN orders USING (customernumber)
GROUP BY customerName;

SELECT countstat FROM countoforderstats;

SELECT * from new_view;

-- DML operations on simple view

INSERT INTO simple_view VALUES (01,'Yogesh','Nawale');
UPDATE simple_view
SET FIRST_NAME= 'mangesh'
WHERE employee_id=01;

SELECT table_name ,is_updatable
FROM information_schema.views
WHERE table_schema= 'testcoursedb';

SELECT table_name ,is_updatable
FROM information_schema.views
WHERE table_schema= 'classicmodels';