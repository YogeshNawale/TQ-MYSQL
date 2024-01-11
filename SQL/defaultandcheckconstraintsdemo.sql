create database defaultandcheckconstraintsdemo;

create table cart_items(
item_id int auto_increment primary key,
name varchar(255) not null,
quantity int not null,
price dec(5,2) not null,
sales_tax dec(5,2) not null default 0.1,
check(quantity>0),
check(sales_tax>=0)
);

select * from cart_items;

insert into cart_items(name,quantity, price,sales_tax) values("Maintainance services",100,102.23,default);
insert into cart_items(name,quantity, price,sales_tax) values("Battery",50,12.23,.5);
insert into cart_items(name,quantity, price,sales_tax) values("Mirror",78,56.23,0.2);


-- changes in the coloumn name 
alter table cart_items
change name
item_name varchar(200) not null;

insert into cart_items(item_name,quantity, price,sales_tax) values("tyres",24,150.255,0);
