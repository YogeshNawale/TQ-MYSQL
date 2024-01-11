create database Assign1BookAuthorAward;
use Assign1BookAuthorAward;

create table author(
author_id int not null primary key,
author_name varchar(200) not null,
ph_no varchar(12) not null unique,
email varchar(100) not null unique,
address varchar(250) not null,
city varchar(100) not null,
constraint uc_name_address_city unique (author_name,address,city)
);

create table book(
book_id int primary key,
book_name varchar(150) not null,
author_id int not null ,
price float not null ,
constraint fkauthor foreign key(author_id) references author(author_id),
check (price>0)
);

create table awardsMaster(
award_type_id int primary key,
award_name varchar(150) not null,
award_price int not null,
check (award_price>0)
);

create table bookauthoraward(
award_id int primary key,
award_type_id int not null,
author_id int not null,
book_id int not null,
publish_year year not null,
constraint fkbookauthoraward foreign key(author_id) references author(author_id),
constraint fkawardsMaster foreign key(award_type_id) references awardsMaster(award_type_id),
constraint fkbook foreign key(book_id) references book(book_id)
);

insert into author values(1,"Shivaji Sawant",'4394398832','ssawant@gmail.com','sadashiv peth','pune');
insert into author values(2,"P.L>Deshpande",'9039828832','pdeshpande@gmail.com','shanivarwada','pune'),
(3,"Ranjit Desai",'89237863832','rdesai@gmail.com','Bandra','Mumbai'),
(4,"Sane Guruji",'48943332','sguruji@gmail.com','G.M road','Mumbai');

select * from author;

insert into book values (101,"Mrutunjay",1,550);
insert into book values (102,"Batatyachi chal",2,650),
(103,"Shreeman Yogi",3,450),
(104,"Shyamchi aai",4,500);

select * from book;

insert into awardsMaster values(1001,'Pulitzer award',500000);
insert into awardsMaster values(1002,'National Book Award',100000);

insert into bookauthoraward values(50,1001,1,101,1967);
insert into bookauthoraward values(51,1002,2,102,1958),
(52,1001,3,103,1984),
(53,1002,4,104,1901);

select * from  author;
select * from book ;
select * from awardsMaster;
select * from bookauthoraward;
