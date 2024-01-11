
USE testcourseDB;

CREATE TABLE salary_changes(
employee_id INT,
changed_at DATETIME DEFAULT current_timestamp,
old_salary DECIMAL(8,2),
new_salary DECIMAL(8,2),
PRIMARY KEY (employee_id,changed_at) );

/* CREATE DEFINER=`root`@`localhost` TRIGGER `employees_BEFORE_UPDATE` BEFORE UPDATE ON `employees` FOR EACH ROW BEGIN
	IF NEW.salary<> OLD.salary THEN
		INSERT INTO salary_changes (employee_id,old_salary, new_salary) 
		VALUES (NEW.employee_id, OLD.salary, NEW.salary);
	END IF;
END
*/

SELECT * FROM employees WHERE employee_id=101;

UPDATE employees
SET salary = salary* 1.05
WHERE employee_id =101;

SELECT * FROM salary_changes;

/* CREATE DEFINER=`root`@`localhost` TRIGGER `employees_BEFORE_INSERT` BEFORE INSERT ON `employees` FOR EACH ROW BEGIN
	IF NEW.salary <65000 THEN
    SIGNAL SQLSTATE '45111' SET message_text =
    'INVALID Salary criteria. Does not match with our requirments';
--  -SIGNAL SQLSTATE '45112' SET message_text =
--  'VALID Salary criteria. Does   match with our requirments';
    END IF;
END
*/

INSERT INTO employees VALUES(001, 'Yogesh', 'Nawale','yogesh@abc.com', '434-434-5444',
				'1987-12-22','AD-pres', 30000, 0.00, 100,90);
                
-- create a trigger to check the entered record of employee having age>18

CREATE TABLE testemployee (
employee_id INT primary key,
emoloyee_name VARCHAR(50),
birth_date date,
salary int 
);

SELECT * FROM testemployee;
truncate testemployee;
INSERT INTO testemployee VALUES(1,"yogesh",'2010-12-12',6000);
INSERT INTO testemployee VALUES(2,"SURAJ",'2001-12-12',3333);

-- create a trigger to check if least salary of the employees is 5000 if not set to 5000

INSERT INTO testemployee VALUES(3,"ISHWAR",'2001-12-12',3333);

update testemployee
SET salary=3500
WHERE employee_id=3;

/*IF (datediff(current_date , new.birth_date)/365) < 18 THEN
signal sqlstate '15456' SET message_text = 'Invalid age. age less than 18';
END IF;*/

/*if new.salary < 5000 THEN
	SET  new.salary=5000;
	END IF;*/
    
    -- write a trigger for automatic id generation of employee table
    
    /*
    CREATE DEFINER=`root`@`localhost` TRIGGER `testemployee_BEFORE_INSERT`
    BEFORE INSERT
    ON `testemployee` FOR EACH ROW 
    BEGIN
	SET new.employee_id= (SELECT max(employee_id) as max FROM testemployee) + 1;
	END*/
    INSERT INTO testemployee VALUES(3,"yogesh",'2010-12-12',6000);
INSERT INTO testemployee (emoloyee_name,  birth_date, salary)VALUES("SURAJ",'2001-12-12',3333);
    
    
    --  create a trigger to restrict delete record of employees who is a manager of other employees
    
    select DISTINCT e1.employee_id 
    FROM employees e1
    INNER JOIN employees e2 on(e1.employee_id=e2.manager_id);
    
    SELECT COUNT(DISTINCT manager_id)
    FROM employees;

	
    DELETE FROM employees 
    WHERE employee_id=1;