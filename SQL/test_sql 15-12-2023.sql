CREATE database test_sql;
use test_sql;

create table theatre (
theatre_id int  primary key,
theatre_name varchar(20) not null,
address varchar(20) not null,
rating int not null);

insert into theatre values(1,'kusum theatre','pune',8);
insert into theatre values(2,'City Pride','nashik',7);
insert into theatre values(3,'globle theatre','nanded',6);
insert into theatre values(4,'star theatre','beed',9);
insert into theatre values(5,'moon theatre','dhule',5);

create table movie (
movie_id int  primary key,
movie_name varchar(20) not null,
director varchar(20) not null,
producer varchar(20)not null);

insert into movie values(101,'uri','prakash raj','karan johar');
insert into movie values(102,'3 idiots','raju hirani','amir khan');
insert into movie values(103,'ddlj','sanjay leela','subhas gahe');
insert into movie values(104,'rockstar','ekta kapoor','kapoor production');
insert into movie values(105,'ranjan','prakash raj','dhanush');

create table customer(
cust_id int  primary key,
cust_name varchar(20) not null,
address varchar(20) not null,
birth_date date not null,
creaditcard_no int not null );

insert into customer values(201,'maroti','nanded','1996-02-24',899456123);
insert into customer values(202,'sunish','mumbai','1996-02-02',85956123);
insert into customer values(203,'abhisheek','mp','2000-11-11',749456123);
insert into customer values(204,'prashant','nager','2000-02-23',899456123);
insert into customer values(205,'mayuri','nanded','2002-10-14',899456123);
insert into customer values(206,'maroti','pune','1996-02-24',899456123);
insert into customer values(207,'yogesh','pune','1996-05-26',98437347);
insert into customer values(208,'pallavi','mumbai','1996-10-11',895456123);

create table screeninginfo(
movie_id int not null,
theatre_id int not null,
ticket_price int not null,
constraint uniscreen  unique  (movie_id,theatre_id),
constraint movie_const foreign key(movie_id) references  movie (movie_id),
constraint theatre_const foreign key(theatre_id) references  theatre(theatre_id));




insert into screeninginfo values(101,1,250);
insert into screeninginfo values(102,2,550);
insert into screeninginfo values(101,2,350);
insert into screeninginfo values(103,3,250);
insert into screeninginfo values(104,4,450);
insert into screeninginfo values(105,5,550);
insert into screeninginfo values(102,5,150);
insert into screeninginfo values(103,1,550);
insert into screeninginfo values(101,3,750);
insert into screeninginfo values(102,3,250);





create table bookings(
booking_id int  primary key,
booking_date date not null,
cust_id int not null,
movie_id int not null,
theatre_id int not null,
no_of_tickets_booked int not null,
constraint fkcust foreign key (cust_id) references customer(cust_id),
constraint fkmovie foreign key(movie_id) references  movie (movie_id),
constraint fkthearter foreign key(theatre_id) references  theatre  (theatre_id));



insert into bookings values(501,'2023-02-03',201,101,1,5);
insert into bookings values(502,'2023-02-04',201,102,2,4);
insert into bookings values(503,'2023-02-03',202,101,2,7);
insert into bookings values(504,'2020-03-05',203,103,3,5);
insert into bookings values(505,'2021-05-06',204,104,4,3);
insert into bookings values(506,'2022-04-07',205,105,5,4);
insert into bookings values(507,'2023-09-03',204,102,3,5);
insert into bookings values(508,'2023-04-03',202,104,2,7);
insert into bookings values(509,'2022-03-03',205,105,5,7);
insert into bookings values(510,'2022-03-03',208,105,5,7);
insert into bookings values(511,'2022-03-03',208,104,2,5);


-- 1.show names of theatres where pallavi has booked tickets
SELECT cust_id
FROM customer
WHERE cust_name='pallavi'; 

SELECT DISTINCT theatre_id
FROM bookings
WHERE cust_id = (SELECT cust_id
FROM customer
WHERE cust_name='pallavi'); 

SELECT theatre_name
FROM theatre
WHERE theatre_id IN (SELECT theatre_id
FROM bookings
WHERE cust_id IN (SELECT cust_id
FROM customer
WHERE cust_name='pallavi'));

-- 2.show name of theatres where movie 'Uri' is screening

SELECT movie_id
FROM movie
WHERE movie_name='URI'; 

SELECT DISTINCT theatre_id
FROM bookings
WHERE movie_id IN (SELECT movie_id
FROM movie
WHERE movie_name='URI'); 

SELECT theatre_name
FROM theatre
WHERE theatre_id IN (SELECT theatre_id
FROM bookings
WHERE movie_id IN (SELECT movie_id
FROM movie
WHERE movie_name='URI'));

-- 3.show names of theatres which has done maximum business
SELECT SUM(no_of_tickets_booked),theatre_id 
FROM bookings
GROUP BY theatre_id
ORDER BY SUM(no_of_tickets_booked) DESC 
LIMIT 1;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


SELECT theatre_name
FROM theatre as orig , (SELECT   theatre_id, MAX(totaltickets)
FROM (SELECT theatre_id, SUM(no_of_tickets_booked) as totaltickets
FROM bookings
GROUP BY theatre_id) as a) as b
WHERE orig.theatre_id IN (b.theatre_id);

-- ----------------- another method
SELECT SUM(no_of_tickets_booked),theatre_id 
FROM bookings
GROUP BY theatre_id
ORDER BY SUM(no_of_tickets_booked) DESC 
LIMIT 1;

SELECT theatre_name FROM theatre 
WHERE theatre_id =( SELECT theatre_id 
FROM bookings
GROUP BY theatre_id
ORDER BY SUM(no_of_tickets_booked) DESC 
LIMIT 1);
-- 4.show the names of movies and businesses done by that movie
SELECT b.movie_id, SUM(ticket_price * no_of_tickets_booked)
FROM screeninginfo as s, bookings as b
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id
GROUP BY b.movie_id ;

SELECT d.movie_name, c.sum
FROM movie AS d, (SELECT b.movie_id, SUM(ticket_price * no_of_tickets_booked) as sum
FROM screeninginfo as s, bookings as b
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id
GROUP BY b.movie_id) AS c
WHERE d.movie_id= c.movie_id ;

-- another mothod
SELECT no_of_tickets_booked, b.movie_id , b.theatre_id, ticket_price
FROM bookings b, screeninginfo s
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id; 

SELECT SUM(no_of_tickets_booked * ticket_price), b.movie_id, ticket_price, theatre_name
FROM bookings b, screeninginfo s , theatre t 
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id AND b.theatre_id= t.theatre_id
GROUP BY s.movie_id; 

SELECT SUM(no_of_tickets_booked * ticket_price), b.movie_id, m.movie_name, ticket_price, theatre_name
FROM bookings b, screeninginfo s , theatre t , movie m
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id AND b.theatre_id= t.theatre_id AND b.movie_id= m.movie_id
GROUP BY s.movie_id; 


-- 5.write a query to add city field in theatre table between address and rating

ALTER TABLE theatre
ADD COLUMN city VARCHAR(50) NOT NULL
AFTER address; 

-- 6.write a query to add field totalcharges int(10) in booking table

ALTER TABLE bookings
ADD COLUMN totalcharges int(10) ; 


SELECT b.movie_id, b.theatre_id, s.movie_id, s.theatre_id, ticket_price
FROM bookings b, screeninginfo s
WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id ;

-- 7.update field totalcharges. Totalcharges are no_of_tickets_booked * ticked_price for that movie and theatre
    
    UPDATE  bookings as b
    SET totalcharges = (no_of_tickets_booked * ( SELECT ticket_price
		FROM  screeninginfo s WHERE b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id )) ;
    
-- 8. update total charges to give discount off 20% to all those who have their birthday on the 
--     booking date when they have booked tickets.  


SELECT day(birth_date), month(birth_date) FROM customer;

SELECT b.cust_id, booking_date, birth_date 
FROM customer c, bookings b
WHERE day(c.birth_date)=day(b.booking_date) AND month(c.birth_date)=month(b.booking_date) 
	AND b.cust_id= c.cust_id;

UPDATE bookings b
SET totalcharges = totalcharges-(0.2* totalcharges)
WHERE b.cust_id IN (SELECT b.cust_id
FROM customer c
WHERE day(c.birth_date)=day(b.booking_date) AND month(c.birth_date)=month(b.booking_date) 
	AND b.cust_id= c.cust_id);



-- 9.delete all bookings done by 'yogesh'

insert into bookings values(512,'2022-03-03',207,104,2,5,44444);

SELECT cust_id
FROM customer
WHERE cust_name = 'yogesh';

DELETE FROM bookings
WHERE cust_id IN(SELECT cust_id
FROM customer
WHERE cust_name = 'yogesh');

--  10. show the names of movie name , totalbusiness done by it of movies diracted by 'prakash raj'

SELECT SUM(no_of_tickets_booked * ticket_price), b.movie_id, s.ticket_price, b.no_of_tickets_booked
FROM bookings b, screeninginfo s , movie m
WHERE m.movie_id= b.movie_id AND b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id
AND m.director='prakash raj'
GROUP BY s.movie_id; 

SELECT m.movie_id, m.movie_name, SUM(ticket_price * no_of_tickets_booked) as total_business
FROM movie m ,screeninginfo as s, bookings as b
WHERE m.movie_id= b.movie_id AND b.movie_id= s.movie_id AND b.theatre_id= s.theatre_id
AND m.director='prakash raj'
GROUP BY m.movie_id, m.movie_name;
