create database uniquedemo;
create table suppliers(
supplier_id INT AUTO_INCREMENT ,
supplier_name VARCHAR(250) NOT NULL,
phone varchar(15) not null unique,
address varchar(255) not null,
primary key (supplier_id),
constraint uc_name_address unique (supplier_name,address)
);

select * from suppliers;
insert into suppliers(supplier_name,phone,address) values("Yogesh",'944675654','pune');
insert into suppliers (supplier_name,phone,address) values("Ishwar",'89348623','Mumbai');
insert into suppliers (supplier_name,phone,address) values("Ishwar",'997342623','pune');
insert into suppliers (supplier_name,phone,address) values("Ishwar",'797342623','Goa');
insert into suppliers (supplier_name,phone,address) values("Suraj",'883943423','Delhi');

select * from suppliers;
