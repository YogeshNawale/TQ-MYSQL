create database MYSQLtest2;
use MYSQLtest2;

-- Create Customer Table
CREATE TABLE Customer (
    Cust_Id INT PRIMARY KEY,
    Cust_name VARCHAR(255),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(255),
    pin_code VARCHAR(10)
);

-- Create Service_Status Table
CREATE TABLE Service_Status (
    Status_Id INT PRIMARY KEY,
    desp VARCHAR(255)
);

-- Insert values into Service_Status Table
INSERT INTO Service_Status (Status_Id, desp)
VALUES
    (1, 'OPEN'),
    (2, 'IN_PROGRESS'),
    (3, 'CLOSED'),
    (4, 'CANCELLED');

-- Create Employee Table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    age INT,
    requestsCompleted INT,
    emp_rating INT
);

-- Create Service_Request Table
CREATE TABLE Service_Request (
    Service_Id INT PRIMARY KEY,
    cust_id INT,
    service_desc VARCHAR(255),
    request_open_date DATE,
    status_id INT,
    Emp_id INT,
    request_closed_date DATE,
    charges DECIMAL(10, 2),
    feedback_rating INT,
    FOREIGN KEY (cust_id) REFERENCES Customer(Cust_Id),
    FOREIGN KEY (status_id) REFERENCES Service_Status(Status_Id),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_Id)
);

-- Insert values into Customer Table
INSERT INTO Customer (Cust_Id, Cust_name, address_line1, address_line2, city, pin_code)
VALUES
    (1, 'Sudarshan', '123 Main St', 'Apt 45', 'Pune', '123452'),
    (2, 'Yogesh', '456 Oak St', 'Suite 101', 'Mumbai', '567489'),
    (3, 'Sunil', '789 Pine St', 'Apt 12', 'Chennai', '101311'),
    (4, 'Anil', '101 Cedar St', 'Suite 50', 'Gujrat', '206222'),
    (5, 'Pankaj', '222 Oak St', 'Apt 30', 'Pune', '303373'),
    (6, 'Raghav', '555 Maple St', 'Suite 75', 'Mumbai', '404444');

-- Insert values into Employee Table
INSERT INTO Employee (Emp_Id, Emp_name, age, requestsCompleted, emp_rating)
VALUES
    (10, 'Amit', 30, 20, 1),
    (20, 'Raju', 35, 15, 2),
    (30, 'Pintu', 28, 25, 1),
    (40, 'Prashant', 40, 18, 2),
   (50, 'Ishwar', 32, 22, 2),
    (60, 'Abhishek', 36, 20, 3);

-- Insert values into Service_Request Table
INSERT INTO Service_Request (Service_Id, cust_id, service_desc, request_open_date, status_id, Emp_id, request_closed_date, charges, feedback_rating)
VALUES
    (101, 1, 'Repair', '2023-01-15', 1, 10, '2023-01-20', 150.00, 1),
    (102, 2, 'Installation', '2023-02-01', 2, 20, NULL, 200.50, 3),
    (103, 3, 'Maintenance', '2023-02-10', 1, 30, '2023-02-15', 120.75, 2),
    (104, 4, 'Consultation', '2023-03-01', 2, 40, NULL, 180.25, 4),
    (105, 1, 'Upgrade', '2023-03-15', 1, 20, NULL, 250.00, 1),
    (106, 5, 'Repair', '2023-04-01', 1, 50, '2023-04-05', 135.50, 2),
    (107, 6, 'Installation', '2023-04-15', 2, 60, NULL, 190.75, 3),
    (108, 2, 'Maintenance', '2023-05-01', 1, 40, NULL, 220.00, 1);
    
    INSERT INTO Service_Request (Service_Id, cust_id, service_desc, request_open_date, status_id, Emp_id, request_closed_date, charges, feedback_rating)
VALUES
    (109, 1, 'Repair', '2022-11-15', 4, 10, '2023-01-20', 450.00, 1),
    (110, 2, 'Installation', '2022-12-01', 2, 20, NULL, 230.50, 3),
    (111, 3, 'Maintenance', '2022-12-10', 3, 30, '2023-02-15', 210.75, 2),
    (112, 4, 'Consultation', '2022-03-01', 2, 40, NULL, 180.25, 4),
    (113, 1, 'Upgrade', '2022-03-15', 4, 20, NULL, 220.20, 1),
    (114, 5, 'Repair', '2022-04-21', 3, 50, '2023-04-05', 235.50, 2),
    (115, 6, 'Installation', '2022-04-19', 2, 60, NULL, 390.75, 3),
    (116, 2, 'Maintenance', '2022-05-31', 1, 40, NULL, 320.04, 1);
    
    INSERT INTO Service_Request (Service_Id, cust_id, service_desc, request_open_date, status_id, Emp_id, request_closed_date, charges, feedback_rating)
VALUES
    (117, 1, 'Repair', '2022-11-15', 3, 10, '2023-01-20', 150.00, 1),
    (118, 2, 'Installation', '2022-12-01', 2, 20, NULL, 200.50, 3),
    (119, 3, 'Maintenance', '2022-12-10', 3, 10, '2023-02-15', 310.75, 2);
    
-- 3.	Write a query to add column email_id(varchar(50)) to customer table. 
ALTER TABLE customer
ADD email_id VARCHAR(50) ; 

-- 4.	Show customer name, service description, charges of requests served by employees older than age 30. [1.5M]
SELECT cust_name, service_desc, charges
FROM service_request 
INNER JOIN customer USING (cust_id)
INNER JOIN employee USING (emp_id)
WHERE age>30; 

-- 5.	Write a query to select customer names for whom employee ‘Amit’ has not served any request.
SELECT cust_name
FROM service_request 
INNER JOIN customer USING (cust_id)
INNER JOIN employee USING (emp_id)
WHERE emp_name != 'Amit'; 

-- 6. Show employee name, total charges of all the requests served by ‘Amit’. Consider only ‘closed’ requests.

SELECT emp_name, SUM(charges) 
FROM service_request
INNER JOIN employee USING(emp_id)
INNER JOIN service_status USING (status_id)
WHERE emp_name='Amit' AND desp='Closed';

-- 7.	Show service description, customer name of request having third highest charges.
SELECT service_desc, cust_name, charges 
FROM service_request
INNER JOIN customer USING (cust_id)
ORDER BY charges DESC
LIMIT 2,1;

-- 8.	Show name of all employees who have same rating as employee ‘Amit’ 
SELECT e1.emp_name
FROM employee e1
INNER JOIN employee e2 ON(e1.emp_rating= e2.emp_rating)
WHERE  e2.emp_name='Amit';

-- 9.	Find the total charges earned by each employee. Sort by maximum charges at top. 
--      Consider ‘closed’ requests only.
SELECT emp_id,SUM(charges) as Total_charges
FROM service_request
INNER JOIN service_status USING(status_id)
WHERE desp='closed'
GROUP BY emp_id 
ORDER BY Total_charges DESC;

-- 10.	Delete all requests served by ‘Kumar’ as he has left the company.
/*		DELETE table1, table2
		FROM table1
		INNER JOIN table2 ON table1.field = table2.field
		WHERE condition;
*/

DELETE service_request, employee FROM service_request INNER JOIN employee USING(emp_id)
WHERE emp_name='Ishwar';

-- 11.	Delete all cancelled requests from request table.
DELETE service_request, service_status FROM service_request INNER JOIN service_status USING(status_id)
WHERE desp='cancelled';

-- 12.	Add 200 to the charges of service_request raised by customer ‘Singh’.
/*		UPDATE table1
		SET table1.column = table2.column
		FROM table1
		INNER JOIN table2 ON table1.column2 = table2.column2
		[WHERE condition];
*/


UPDATE service_request 
SET charges = charges + 200
WHERE cust_id= (select cust_id FROM customer WHERE cust_name='Anil');
 
 -- 15.	Create a trigger which is fired when Service_request is updated. The trigger should 
 -- update emp_rating in employee table(emp_rating is average of all the service_requests ‘closed’ by 
 --  employee).
 
CREATE TRIGGER emp_rating_employee
AFTER  UPDATE ON service_request
FOR EACH ROW

BEGIN
   
END;

-- 16.	Create a stored procedure which returns the year-wise, month-wise addition of total_charges
--      sorted by year in descending and then month in ascending [2M]

CALL Sorted_totalCharges;

-- 19.	Write single query to create SerReqCopy table which will have same structure and 
--      data of service_request table.

CREATE TABLE SerReqCopy AS
SELECT * FROM service_request ;

-- 20.	Create index so that retrieval of records is faster when retrieved based on status id

CREATE INDEX status_id ON service_request(status_id);

-- 21.	Create a view which will show customer name, service desc , employee name , service charges ,
--   status desc of requests which are not closed.

CREATE VIEW service_request_status_customer_employee AS
SELECT cust_name, service_desc , emp_name , charges , desp
FROM service_request
INNER JOIN customer USING(cust_id)
INNER JOIN employee USING(emp_id)
INNER JOIN service_status USING(status_id);

DESC service_request_status_customer_employee;
SELECT * FROM service_request_status_customer_employee;

-- 