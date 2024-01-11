create database foreignkeydemo;
use foreignkeydemo;
create table catagory(
catid int auto_increment primary key,
catname varchar(100) not null
);
create table product(
pid int auto_increment primary key,
pname varchar(50),
catid int, constraint fkcatagory foreign key(catid) references catagory(catid)
);

insert into catagory(catname) values ("smartphone");
insert into catagory(catname) values ('smartwatch');
insert into catagory values(3,'iphone');
select * from catagory;

insert into product(pname,catid) values ("samsung s6",1);
insert into product(pname, catid) values ('boat ',2);
insert into product (pname,catid) values ('Vivo ',1);
insert into product (pname,catid) values ("apple watch",2);
insert into product (pname,catid) values ("iphone 6",3);
insert into product (pname,catid) values ("MI ",1),("Samsung S7",1);

select * from product;

update catagory
set catid=101
where catid=1;

drop table product;

create table product(
pid int auto_increment primary key,
pname varchar(50),
catid int, constraint fkcatagory foreign key(catid) references catagory(catid)
on delete cascade
on update cascade
);

insert into product(pname,catid) values ("samsung s6",1);
insert into product(pname, catid) values ('boat ',2);
insert into product (pname,catid) values ('Vivo ',1);
insert into product (pname,catid) values ("apple watch",2);
insert into product (pname,catid) values ("iphone 6",3);
insert into product (pname,catid) values ("MI ",1),("Samsung S7",1);

select * from product;

-- update catagory to check if product (parent class ) is updated
update catagory
set catid=101
where catid=1;
select * from product;

delete from catagory 
where catid=3;