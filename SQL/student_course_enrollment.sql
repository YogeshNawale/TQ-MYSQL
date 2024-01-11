CREATE DATABASE student_course;
USE student_course;

CREATE TABLE students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100) ,
birth_date date,
major VARCHAR(50) );

CREATE TABLE courses(
course_id INT  PRIMARY KEY ,
course_name VARCHAR(50),
credit_hours INT);

CREATE TABLE enrollments(
enrollment_id int primary key,
student_id int ,
course_id int ,
enrollment_date date,
constraint enroll_students foreign key (student_id) references students(student_id)
ON DELETE CASCADE 
ON UPDATE CASCADE ,
constraint enroll_courses foreign key (course_id) references courses(course_id)
ON DELETE CASCADE 
ON UPDATE CASCADE 
);

INSERT INTO students values(1,'Yogesh','1994-04-23','Computer Science');
INSERT INTO students values(2,'Suraj','1995-12-22','History');
INSERT INTO students values(3,'Ishwar','1994-08-13','Biology');
INSERT INTO students values(4,'Kiran','1994-07-23','Comerse');
INSERT INTO students values(5,'Snehal','1995-05-01','Biology');
INSERT INTO students values(6,'Sudarshan','1993-02-23','History');
INSERT INTO students values(7,'Abhishek','1994-11-30','Computer Science');
INSERT INTO students values(8,'Adarsh','1992-03-22','Comerse');
INSERT INTO students values(9,'Aman','1995-03-09','Biology');
INSERT INTO students values(10,'Rahul','1996-12-13','Computer Science');
INSERT INTO students values(11,'Amit','1997-07-09','Biology');
INSERT INTO students values(12,'Prasad','1995-10-13','Computer Science');
INSERT INTO students values(13,'Prakash','2005-07-23','History');
INSERT INTO students values(14,'Sahil','2004-12-03','History');

INSERT INTO courses VAlUES (101,"MBBS",440);
INSERT INTO courses VAlUES (102,"CSE",210);
INSERT INTO courses VAlUES (103,"IT",200);
INSERT INTO courses VAlUES (104,"Applied Mathematics",380);
INSERT INTO courses VAlUES (105,"Medival History",190);
INSERT INTO courses VAlUES (106,"Advanced Mathematics",270);
INSERT INTO courses VAlUES (107,"General Surgery",350);
INSERT INTO courses VAlUES (108,"Ancient History",150);
INSERT INTO courses VAlUES (109,"Pharmacy",170);

INSERT INTO enrollments VALUES(501,1,102,'2020-12-30');
INSERT INTO enrollments VALUES(502,2,105,'2022-11-20');
INSERT INTO enrollments VALUES(503,3,101,'2020-06-23');
INSERT INTO enrollments VALUES(504,4,104,'2021-05-03');
INSERT INTO enrollments VALUES(505,5,109,'2020-01-09');
INSERT INTO enrollments VALUES(506,6,108,'2020-08-12');
INSERT INTO enrollments VALUES(507,7,103,'2021-11-17');
INSERT INTO enrollments VALUES(508,8,106,'2022-12-27');
INSERT INTO enrollments VALUES(509,9,102,'2021-05-31');
INSERT INTO enrollments VALUES(510,10,102,'2022-02-05');
INSERT INTO enrollments VALUES(511,2,108,'2020-12-12');
INSERT INTO enrollments VALUES(512,4,106,'2021-11-24');
INSERT INTO enrollments VALUES(513,2,102,'2022-12-20');
INSERT INTO enrollments VALUES(514,3,107,'2020-11-27');
INSERT INTO enrollments VALUES(515,7,102,'2021-12-30');

-- 1.	Select all students and their majors
SELECT * FROM students;

-- 2.	List the names of courses with more than 300 credit hours.
SELECT * 
FROM courses
WHERE credit_hours>300;

-- 3.	Find the students born after 1993.

SELECT * FROM students
WHERE year(birth_date) > 1994;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- 4.	Count the number of courses in each major.
SELECT student_id,major
FROM students
GROUP BY major;

SELECT major ,count(course_id)
FROM enrollments e,(SELECT student_id,major
FROM students
GROUP BY major) a 
WHERE e.student_id=a.student_id 
GROUP BY major ;

-- 5.	Show the name and birth date of the oldest student.
SELECT student_name, MIN(birth_date)
FROM students;

-- 6.	Update the major of a specific student.
UPDATE students
SET major='History'
WHERE student_id=10;

UPDATE students
SET major='Computer Science'
WHERE student_id=10;

-- 7.	List all students who have not enrolled in any courses.

SELECT DISTINCT student_id
FROM enrollments
WHERE course_id= course_id  ;

SELECT *
FROM students s
WHERE s.student_id not in((SELECT DISTINCT student_id
FROM enrollments WHERE course_id = course_id));

-- 8.	Find the course with the highest number of credit hours.
SELECT *,max(credit_hours)
FROM courses;

-- 9.	Calculate the average birth year of all students.

SELECT AVG(year(birth_date))
FROM students;

-- 10.	Delete all students majoring in 'History'.

DELETE FROM students
WHERE major='History';

-- 11.	Show the names and birth dates of students majoring in 'Computer Science'.

SELECT student_name, birth_date
FROM students
WHERE major='Computer Science';

-- 12.	Find the student with the highest number of credit hours enrolled.
SELECT student_id,group_concat(course_id)
FROM enrollments
GROUP BY student_id;

SELECT sum(credit_hours),s.student_id, s.student_name
FROM courses c, (SELECT student_id,group_concat(course_id) as course_id_group
FROM enrollments
GROUP BY student_id) a, students s
WHERE course_id IN(course_id_group) AND a.student_id= s.student_id
GROUP BY a.student_id
ORDER BY sum(credit_hours) DESC
LIMIT 1;

-- 13.	List the majors and the number of students in each major.

SELECT major, count(*)
FROM students
GROUP BY major;

-- 14.	Find students with similar birth years (having at least one year in common).
SELECT group_concat(student_name), year(birth_date)
FROM students
WHERE year(birth_date)= year(birth_date)
GROUP BY year(birth_date);

-- 15.	Show the majors with students born before 1995.
SELECT *
FROM students
WHERE year(birth_date)<1995;

-- 16.	Count the total number of credit hours for each major.
SELECT student_id,group_concat(course_id)
FROM enrollments
GROUP BY student_id;

SELECT student_id,SUM(credit_hours)
FROM courses c,(SELECT student_id,group_concat(course_id) as grp
FROM enrollments
GROUP BY student_id) a
WHERE course_id in(grp)
GROUP BY a.student_id;

SELECT major, sum(sum) as Total_Hours, group_concat(sum)
FROM students s, (SELECT student_id,SUM(credit_hours) as sum
FROM courses c,(SELECT student_id,group_concat(course_id) as grp
FROM enrollments
GROUP BY student_id) a
WHERE course_id in(grp)
GROUP BY a.student_id) a
WHERE s.student_id in( a.student_id)
GROUP BY major;

-- 17.	Update the birth date of all students majoring in 'Biology'.
UPDATE  students
SET birth_date = '1994-12-30'
WHERE major = 'Biology';

-- 18.	Find the courses with no enrolled students.
SELECT * 
FROM courses;

SELECT c.course_id, c.course_name
FROM courses c
WHERE c.course_id NOT IN(SELECT course_id FROM enrollments);

-- 19.	List the students and their majors, ordered by birth date (ascending order).
SELECT *
FROM students 
order by birth_date;

-- 20.	Show the students born in the last twenty years.

SELECT * FROM students
WHERE ( year(curdate())-year(birth_date) ) <= 20;

SELECT (current_date());

-- 21.	Find the courses with names containing the word 'Math'.

SELECT *
FROM courses
WHERE course_name LIKE '%math%';

-- 22.	Calculate the total number of credit hours for all courses.

SELECT SUM(credit_hours)
FROM courses;

-- 23.	Show the students with the highest and lowest credit hours enrolled.

SELECT student_id,group_concat(course_id)
FROM enrollments
GROUP BY student_id;

SELECT  e.student_id,SUM(credit_hours)
FROM courses c ,enrollments e
WHERE c.course_id IN ( SELECT group_concat(course_id) as group_course
FROM enrollments
GROUP BY student_id )
GROUP BY e.student_id

;




SELECT  e.student_id,SUM(credit_hours) as Min_credithours
FROM courses c ,enrollments e
WHERE c.course_id IN ( SELECT group_concat(course_id) as group_course
FROM enrollments
GROUP BY student_id )
GROUP BY e.student_id
order by Min_credithours 
LIMIT 1;

-- 24.	Find students who have enrolled in consecutive years.

SELECT group_concat(student_name)
FROM students
WHERE student_date;