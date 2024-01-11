USE classicmodels;
CALL  getCountOfEmployees(@e);
SELECT @e as cnt;

CALL variableDEMo();

CALL classicmodels.getcustomerlevel(@112, @level);
SELECT @level as level;

USE testcoursedb;
CALL getdeptnamelocation(107, @dname_city);
SELECT @dname_city;
 
SET GLOBAL log_bin_trust_function_creators = 1;
USE testcoursedb;
CALL getsalary(105);

-- to call function

SET @sal=getsalary(105);
SELECT @sal;

CALL factorialLoopExample();
CALL factorialWhileExample();
CALL powerofNumberwhile();
CALL sumofdigitsLoop();

SET @fullNameList = "";
CALL getFullName(@fullNameList);

SELECT @fullNameList;

CALL addnewemployee('yogesh','nawale', 20000, 50 );

DELETE FROM employees
WHERE EMPLOYEE_ID=0;

CALL UpdateSalary(0,25000);

CALL AvgSalaryInDept(20);

CALL CountEmployeesInDept(20);

CALL TransferEmployeeToDept(0,90);

CALL 