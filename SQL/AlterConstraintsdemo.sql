create database alterConstraintDemo;
use alterConstraintDemo;

create table vehicles(
vechile_id int,
year INT NOT NULL,
make VARCHAR(100) NOT NULL,
PRIMARY KEY(vechile_id )
);

/*	to add column to a table  
	ALTER TABLE table_name
		ADD 
		new_column_name column_definition
		[FIRST | AFTER column_name] */
        
alter table vehicles
add
	no_of_tyres int
    after year;
    
select * from vehicles;

/* 2) Add multiple columns to a table
ALTER TABLE table_name
    ADD new_column_name column_definition
    [FIRST | AFTER column_name],
    ADD new_column_name column_definition
    [FIRST | AFTER column_name],
    ...;
*/
alter table vehicles
	ADD
    fuel_type varchar(50) ,
    add
    mileage dec(5,2);
    
    select * from vehicles;
    
/*1) Modify a column
Here is the basic syntax for modifying a column in a table:
ALTER TABLE table_name
MODIFY column_name column_definition
[ FIRST | AFTER column_name];    
*/

alter table vehicles
modify
fuel_type varchar(150);


/*
Modify multiple columns
The following statement allows you to modify multiple columns:
ALTER TABLE table_name
    MODIFY column_name column_definition
    [ FIRST | AFTER column_name],
    MODIFY column_name column_definition
    [ FIRST | AFTER column_name],
    ...;
*/

alter table vehicles
modify 
fuel_type varchar(150),
modify
year INT NOT NUll default 2020;

desc vehicles;
/*
MySQL ALTER TABLE – Rename a column in a table
To rename a column, you use the following statement:
ALTER TABLE table_name
    CHANGE COLUMN original_name new_name column_definition
    [FIRST | AFTER column_name];
*/
alter table vehicles
CHANGE COLUMN make company_name VARCHAR(100) NOT NULL 
after vechile_id;

desc vehicles;
/*
To drop column in a table, you use the ALTER TABLE DROP COLUMN statement:
ALTER TABLE table_name
DROP COLUMN column_name;
*/

alter table vehicles
drop column no_of_tyres;

/*
To rename, you use the ALTER TABLE RENAME TO statement:
ALTER TABLE table_name
RENAME TO new_table_name;
*/

alter table vehicles
rename to cars;

desc cars;