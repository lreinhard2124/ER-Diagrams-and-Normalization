-- APAN 5310: SQL & RELATIONAL DATABASES FALL 2019 (F2F)

   -------------------------------------------------------------------------
   --                                                                     --
   --                            HONOR CODE                               --
   --                                                                     --
   --  I affirm that I will not plagiarize, use unauthorized materials,   --
   --  or give or receive illegitimate help on assignments, papers, or    --
   --  examinations. I will also uphold equity and honesty in the         --
   --  evaluation of my work and the work of others. I do so to sustain   --
   --  a community built around this Code of Honor.                       --
   --                                                                     --
   -------------------------------------------------------------------------

/*
 *    You are responsible for submitting your own, original work. We are
 *    obligated to report incidents of academic dishonesty as per the
 *    Student Conduct and Community Standards.
 */


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-- HOMEWORK ASSIGNMENT 4 (DUE 10/15/2019, 11:59 pm EST)

/*
 *  NOTES:
 *
 *    - Type your SQL statements between the START and END tags for each
 *      question. Do not alter this template .sql file in any way other than
 *      adding your answers. Do not delete the START/END tags. The .sql file
 *      you submit will be validated before grading and will not be graded if
 *      it fails validation due to any alteration of the commented sections.
 *
 *    - Our course is using PostgreSQL which has been preinstalled for you in
 *      Codio. We grade your assignments in PostgreSQL. You risk losing points
 *      if you prepare your SQL queries for a different database system
 *      (MySQL, MS SQL Server, Oracle, etc).
 *
 *    - It is highly recommended that you insert additional, appropriate data
 *      to test the results of your queries. You do not need to include your
 *      sample data in your answers.
 *
 *    - Make sure you test each one of your answers. If a query returns an
 *      error it will earn no points.
 *
 *    - In your CREATE TABLE statements you must provide data types,
 *      primary/foreign keys and integrity constraints (if applicable).
 *
 *    - You may expand your answers in as many lines as you need between the
 *      START/END tags.
 *
 */



-------------------------------------------------------------------------------



/*
 * QUESTION 1 (8 points: 1 point for each table plus 1 point for correct order
 *             of execution)
 * ----------------------------------------------------------------------------
 *
 * Assume a simplified schema for a website that matches students with jobs.
 * Provide the SQL statements that create the seven (7) tables with data types
 * of your design. Implement integrity constraints (primary/foreign keys,
 * NOT NULL, UNIQUE, CHECK, etc.), and cascading actions on foreign keys as
 * needed. Note: since underlining is not supported in this file format,
 * primary keys for each relation below are shown between asterisks '*'.
 *
 *
 *   employers (*id*, name, address, phone, email)
 *   job_skills (*job_id*, *job_skill*)
 *   jobs (*id*, emp_id, title, start_date, post_date, min_gpa, salary,
 *         description)
 *   students (*id*, name, email, major, degree, gpa, graduation_date)
 *   student_skills (*student_id*, *student_skill*)
 *   applications (*student_id*, *job_id*, date_submitted)
 *   interviews (*job_id*, *student_id*, interview_date, offer_made)
 *
 *
 * The logic of the schema is that employers create job postings with required
 * skills and students post their information and skills. Then, students can
 * search for jobs and submit an application. Employers can search for students,
 * review their information and skills and extend an invitation for an interview.
 *
 * Type the CREATE TABLE statements in the order they have to be executed so
 * that there is no error in PostgreSQL. Keep in mind that integrity
 * constraints can be executed after the CREATE TABLE statements using the
 * ALTER statement. Expand the space between the START/END tags to fit all of
 * your CREATE TABLE statements.
 *
 * IMPORTANT: Make sure you implement the schema with exactly the provided
 *            relation and attribute names. Do not rename relations or
 *            attributes, either by accident (typos) or on purpose.
 *
 * Schema Description:
 * -------------------
 *
 * employers
 * ---------
 *  id: primary key
 *  name: name of an employer
 *  address: full address of an employer
 *  phone: the primary phone number of an employer
 *  email: the primary email address of an employer
 *
 * job_skills
 * ----------
 *  job_id: the id of a job from the "jobs" relation
 *  job_skill: the "job_skills" table holds the skills required for the job,
 *             one at a time, as specified by the employer. Hence, in a row
 *             in this table, do not add multiple skills as a list. For example,
 *             a job with ID 1 and two necessary skills would be: (1, 'Python'),
 *             (1, 'SQL').
 *
 * students
 * --------
 *  id: primary key
 *  name: full name of a student
 *  email: email address of a student
 *  major: field of study
 *  degree: graduate, undergraduate, visiting, etc (maybe implement a check?)
 *  gpa: grade point average
 *  graduation_date: expected graduation date
 *
 * student_skills
 * --------------
 *  student_id: the id of a student from the "students" relation
 *  student_skill: similar to the "job_skills" table, the "student_skills"
 *                 table holds the skills a student possesses, one at a time,
 *                 as specified by the student. Hence, for a row in this table,
 *                 do not add multiple skills. For example, a student with ID
 *                 'xyz992' and three skills would have their skills stored as:
 *                 ('xyz992', 'R'), ('xyz992', 'SQL'), ('xyz992', 'Machine
 *                 Learning').
 *
 * jobs
 * ----
 *  id: primary key
 *  emp_id: the id of an employer from the "employers" relation
 *  title: full job title
 *  start_date: start date of a position
 *  post_date: date and time of job posting
 *  min_gpa: minimum gpa required for a position
 *  salary: starting salary for a position
 *  description: full description of a position
 *
 * applications
 * ------------
 *  student_id: the id of a student from the "students" relation
 *  job_id: the id of a job from the "jobs" relation
 *  date_submitted: date and time that the application was submitted
 *
 * interviews
 * ----------
 *  job_id: the id of a job from the "jobs" relation
 *  student_id: the id of a student from the "students" relation
 *  interview_date: date and time that an interview is/was scheduled at
 *  offer_made: keeps track of whether an offer was made to the candidate and
 *              if it was accepted. Hint: implement a check with a list such as
 *              ('no offer', 'offer accepted', 'offer rejected', etc).
 *
 */

-- START ANSWER 1 --

CREATE TABLE employers (
id varchar(8),
name varchar(40) NOT NULL,
address varchar(100),
phone char(10) NOT NULL,
email varchar(60) UNIQUE NOT NULL,
PRIMARY KEY (id)
);


CREATE TABLE jobs (
id varchar(8),
emp_id varchar(8),
title varchar(30) NOT NULL,
start_date date NOT NULL,
post_date timestamp NOT NULL,
min_gpa numeric(3,2) NOT NULL CONSTRAINT min_gpa_range CHECK (min_gpa BETWEEN 0 AND 4),       
salary numeric(7,2) NOT NULL CONSTRAINT positive_salary CHECK (salary >= 0),  
description varchar, 
PRIMARY KEY (id),
FOREIGN KEY (emp_id) REFERENCES employers (id) 
ON DELETE CASCADE 
ON UPDATE CASCADE
);


CREATE TABLE job_skills (
job_id varchar(8),
job_skill varchar(40),      
PRIMARY KEY (job_id, job_skill),
FOREIGN KEY (job_id) REFERENCES jobs (id) 
ON DELETE CASCADE 
ON UPDATE CASCADE
);


CREATE TABLE students (
id varchar(8),
name varchar(40) NOT NULL,
email varchar(60) UNIQUE NOT NULL,          
major varchar(40) NOT NULL,        
degree varchar(40) NOT NULL CONSTRAINT degree_level_test
CHECK (degree='Associate’s' OR degree='Bachelor’s' OR degree='Master’s' OR degree= 'Doctorate' OR degree= 'Visiting'),      
gpa numeric(3,2) NOT NULL CONSTRAINT gpa_range CHECK (gpa BETWEEN 0 AND 4),
graduation_date date NOT NULL,  
PRIMARY KEY (id)
);


CREATE TABLE student_skills (
student_id varchar(8),
student_skill varchar(40),       
PRIMARY KEY (student_id, student_skill),
FOREIGN KEY (student_id) REFERENCES students (id)
ON DELETE CASCADE 
ON UPDATE CASCADE
);


CREATE TABLE applications (
student_id varchar(8),
job_id varchar(8),
date_submitted timestamp NOT NULL, 
PRIMARY KEY (student_id, job_id),
FOREIGN KEY (student_id) REFERENCES students (id)
ON DELETE CASCADE 
ON UPDATE CASCADE,
FOREIGN KEY (job_id) REFERENCES jobs (id)
ON DELETE CASCADE 
ON UPDATE CASCADE
);


CREATE TABLE interviews (
job_id varchar(8),
student_id varchar(8),
interview_date timestamp NOT NULL, 
offer_made varchar(15) NOT NULL CONSTRAINT offer_made_test 
CHECK (offer_made ='no offer' OR offer_made ='offer accepted' OR offer_made ='offer rejected'),
PRIMARY KEY (job_id, student_id, interview_date),
FOREIGN KEY (job_id) REFERENCES jobs (id)
ON DELETE CASCADE 
ON UPDATE CASCADE,
FOREIGN KEY (student_id) REFERENCES students (id)
ON DELETE CASCADE 
ON UPDATE CASCADE
);

-- END ANSWER 1 --

-------------------------------------------------------------------------------

/*
 * QUESTION 2 (3 points)
 * ---------------------
 *
 * Provide brief reasoning on your selection of each one of the data types
 * above as well as your implementation of integrity constraints. Include any
 * additional assumptions you made beyond the provided schema description. Type
 * your answers (plain text) within the START/END tags. Expand your answers in
 * as many lines as you need.
 *
 */

-- START ANSWER 2 --

I chose the data type varchar(8) for all id attributes (id, emp_id, job_id,student_id, job_id) 
in all tables because I believe each entry for id should contain a combination of letters and numbers of 
varying length with the maximim length of 8. After every foreign key there is the constraints ON DELETE 
CASCADE and ON UPDATE CASCADE so that when a record in the parent table is deleted or updated, the 
corresponding records in the child table will automatically be deleted and updated respectively.

For the table employers, I set the attribute name  data type 
to varchar(40) since names vary in character length and are typically less than 40 characters long. 
I set the attribute address’s data type as varchar(100) since the entries in the 
column will be of varying length and the length should be maximum 100 characters since the address will
include street name, city and zip code. The phone attribute data type is char(10) since phone numbers 
contain 10 characters consistently with the area code included (which is needed to identify location later
in the assignment). Email was given data type varchar(60) since emails vary in length but are typically 
shorter than 60 characters. Name, phone, and email have the constraint NOT NULL since there cannot be a
null value for an employer name, phone number or email in a table that helps locate/identify employers. 
Furthermore, email is given the constraint UNIQUE so that no employer has the same email. If there are 
employers listed in the table that are small business owners, there may be duplicate phone numbers (their 
cell phones) however they will have a seperate email registered for each business. The primary key was 
identified as the attribute id since it is a unique number that identifies each employer in the table. 

For the table jobs, I set the attribute title  data type to varchar(30) since job titles vary in character 
length and are typically less than 30 characters long. I set the attribute start_date’s data type as
date since the entries in the column will be dates without times listed. I set the attribute post_date’s 
data type as timestamp since the job posting will record what day and time it was posted. The attribute 
min_gpa has data type numeric(3,2) since it will store numbers that have one whole number and two decimals.
The attribute salary is numeric(7,2) since it will store numbers with two decimals (because monetary amount)
and will not contain more than 5 whole numbers since it is a salary for a student job position. The
description is varchar with no character limit since the job description could be very long or have a null
(which is why there is no constraint). Title, start_date, post_date, min_gpa, and salary all have the 
constraint NOT NULL since there cannot be a null value for an job name, start, post time, gpa requirement 
or salary in a table that keeps a record of jobs. The attribute min_gpa has a constraint min_gpa_range since
gpas have to be between the values 4.0 and 0.0. The attribute salary has a constraint positive salary 
to ensure that all entries are positive numbers since a salary cannot be a negative number. 
The primary key is id since it is a unique number that identifies each job in the table. The 
foreign key is emp_id since it references the id from the employers table. 

For the table job_skills, the attribute job_skill has the data type varchar(40) since the column will 
contain different skills with different character lengths that will likely be below 40 characters. 
The Primary Key is a combination of attributes job_id and job_skills since job id is the primary key for 
the table jobs and there can not be a dublicate primary key. job_id is a foreign key since it references 
id in the jobs table. 

For the table students, I set the attribute name data type to varchar(40) since names vary in character 
length and are typically less than 40 characters long. Email was given data type varchar(60) since emails
vary in length but are typically shorter than 60 characters. I set the attributes major and degree data 
type as varchar(40) since the entries in the column will be of varying length and the length should be
maximum 40 characters since most disciplines names are less than 40 characters. The attribute 
gpa has data type numeric(3,2) since it will store numbers that have one whole number and two decimals. The 
attribute graduation_date was given the data type date becasue the entries in the column will be in the 
format MM/DD/YYYY. Name, email, major, degree, gpa, and graduation_date have the constraint NOT NULL 
since there cannot be null values for these values in a table that helps locate/identify students and their
graduation information. The atribute email is given the constraint UNIQUE since all student email addresses
should be unique to ensure they are getting the appropriate graduation notifications. The attribute gpa 
has a constraint gpa_range since gpas have to be between the values 4.0 and 0.0. The attribute degree
has the constraint degree_level_test to ensure that the listed degree is one of the certified options
by the university. The primary key is id since it is a unique number that identifies each student
in the table. 

For the table student_skills, the attribute student_skill has the data type varchar(40) since the column
will contain different skills with different character lengths that will likely be below 40 characters. 
The Primary Key is a combination of attributes student_id and student_skills since student id is the
primary key for the table students and there can not be a dublicate primary key. student_id is a foreign
key since it references id in the students table. 

For the table applications, the attribute date_submitted is given the data type timestamp since the website
should record the MM/DD/YYYY and time of the application submission. This attribute is not null since
it needs to be referenced for record purposes. The primary key is a composite key of the attributes
student_id and job_id since many students can apply for the same job (making job_id not a key alone) and
students can apply for many different jobs (making student_is not a key alone). Combining, the two 
attributes show what student applied for what job. student_id is a foregin key since it references the 
table students and job_id is a foreign key since it references the table jobs. 

For the table interviews, the attribute interview_date is given the data type timestamp since the company
should record the MM/DD/YYYY and time of the interview. This attribute is not null since
it needs to be referenced for record purposes. The attribute offer_made is given the data type varchar(15)
since the selection of responses has a maximum character count of 15. offer_made has the constraint 
offer_made_test to ensure that the column entries are one of the specified choices of reacting to the 
job offer. The primary key is a composite key of the attributes job_id, student_id and interview_date
since (job_id, student_id) is the primary key for table applications and there cannot be duplicate 
primary keys. student_id is a foregin key since it references the table students and job_id is a 
foreign key since it references the table jobs. 


It was necessary to create the requested tables in a certain order since some tables referenced
others with the use of foreign keys. My table order was: Employers, jobs, job_skills, students,
student_skills, applications, and interviews. The tableThe table jobs references employers therefore
employers is created first. Job_skills references jobs so the table jobs is create before job_skills. 
Student_skills references the table students so table students is created fourth with student_skills 
following in fifth place. Applications table references students table and jobs table so that follow
the creation of those tables (sixth place). Interviews references jobs table and students table so it 
is created last. 

This final paragraph will explain the cardinalities between the tables in this assignment. 
There is a many to one relationship between the student_skills and students tables. A skill 
is associated with at most one student, and a student can be associated with several 
(including 0) skills. There is a many to one relationship between the interviews and students 
tables. An interview is associated with at most one student, and a student can be associated with 
several (including 0) interviews. There is a many to one relationship between the applications and 
students tables. An application is submitted by at most one student, and a student can submit several
(including 0) applications. There is a many to one relationship between the interviews and jobs tables. 
An interview is associated with at most one job, and a job can have many interviews conducted for the 
position. There is a many to one relationship between the applications and jobs tables. An application 
is associated with at most one job, and a job can accept many applications. There is a many to one
relationship between the jobs and employers tables. A job is associated with at most one employer, 
and an employer can have many job positions in the company. Finally, there is a many to one relationship 
between the job_skills and jobs tables. A job skill is associated with at most one job, and a job can 
be associated with several (including 0) skills. Furthermore, the email attributes in the students table
and employers table is identified as an alternate key because they are unique values. 


-- END ANSWER 2 --

-------------------------------------------------------------------------------

/*
 * QUESTION 3 (3 points)
 * ---------------------
 *
 * Draw the ER diagram for the schema detailed in Question 1 using Engineering
 * notation. Pay close attention to properly defining relationship and
 * cardinalities. You may draw the ER diagram in any software you prefer,
 * Lucidchart is recommended. Hand drawn diagrams will not be accepted. Upload
 * the ER diagram as a separate file.
 *
 */

 -- No START/END tags here. Your answer is a separate PDF submitted along with
 -- this SQL file and the PDF file for the diagram in Question 3.

-------------------------------------------------------------------------------

/*
 * QUESTION 4 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the job id, employer name, job name,
 * and post date/time of all job listings that a student named 'Louise Belcher'
 * may be qualified for (meaning, she has a high-enough GPA and at least one of
 * her skills is also listed as a skill for the job).
 *
 * IMPORTANT NOTE: This question must be answered with a single SQL query. If
 *                 your answer involves more that one query, it will be marked
 *                 incorrect even if the output is correct.
 *
 */

-- START ANSWER 4 --

SELECT DISTINCT J.id, E.name, J.title, J.post_date
FROM jobs AS J, employers AS E, students AS S, student_skills AS SS, job_skills AS JS
WHERE S.name =  'Louise Belcher'
AND S.id = SS.student_id
AND E.id = J.emp_id
AND J.id = JS.job_id
AND SS.student_skill  = JS.job_skill   
AND S.gpa >= J.min_gpa;

-- END ANSWER 4 --

-------------------------------------------------------------------------------

/*
 * QUESTION 5 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that creates a view called "ny_jobs". This
 * view, when called, must return the job id, company name, and job name of any
 * job posted by a company in New York. (Hint: use the first 3 digits of the
 * employer phone number to locate companies in NY. You may limit to area codes
 * '212', '646' and '718').
 *
 * Demonstrate how the view may be used to further limit results to jobs posted
 * in September 2019.
 *
 * IMPORTANT NOTE: There are two parts to this question. First, you must write
 *                 the query that creates the view and then you must write the
 *                 query that uses this view to limit results to September 2019.
 *                 Make sure you end each statement with a semicolon ';'
 *
 */

-- START ANSWER 5 --

CREATE VIEW ny_jobs AS 
SELECT DISTINCT J.id, E.name, J.title
FROM(SELECT E.phone, J.post_date
FROM employers AS E, jobs AS J
WHERE E.phone LIKE '212%' OR E.phone LIKE '646%' OR E.phone LIKE '718%')
AS nyc_company, jobs AS J, employers AS E
WHERE E.id = J.emp_id
AND E.phone=nyc_company.phone;

SELECT ny_jobs_view.id, ny_jobs_view.name, ny_jobs_view.title FROM 
(SELECT id, name, title
FROM ny_jobs) AS ny_jobs_view NATURAL JOIN 
(SELECT J.post_date, J.id
FROM jobs AS J
WHERE J.post_date BETWEEN '09/01/2019 00:00:00' and '09/30/2019 24:00:00') AS job_view
WHERE ny_jobs_view.id=job_view.id;

-- END ANSWER 5 --

-------------------------------------------------------------------------------

/*
 * QUESTION 6 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the job id and job name of the job
 * that received the most applications.
 *
 * IMPORTANT NOTE: This question must be answered with a single SQL query. If
 *                 your answer involves more that one query, it will be marked
 *                 incorrect even if the output is correct.
 *
 */

-- START ANSWER 6 --

SELECT count_a.id, count_a.title
FROM (SELECT J.id, J.title, COUNT(A.job_id) AS app_count,
             RANK() OVER (ORDER BY COUNT(A.job_id) DESC) as order_num
      FROM jobs AS J, applications AS A
	  WHERE J.id=A.job_id
      GROUP BY J.id, J.title
     ) count_a
WHERE order_num = 1;

-- END ANSWER 6 --

-------------------------------------------------------------------------------

/*
 * QUESTION 7 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the name of any student who did more
 * than two (2) interviews without getting a single offer.
 *
 * IMPORTANT NOTE: This question must be answered with a single SQL query. If
 *                 your answer involves more that one query, it will be marked
 *                 incorrect even if the output is correct.
 */

-- START ANSWER 7 --

SELECT DISTINCT S.name
FROM (SELECT I.student_id, COUNT(I.interview_date) AS count
FROM interviews AS I
GROUP BY student_id) as interview_count, students AS S, interviews AS I
WHERE S.id = interview_count.student_id
AND interview_count.count > 2 
AND I.offer_made = 'no offer' ;

-- END ANSWER 7 --

-------------------------------------------------------------------------------

/*
 * QUESTION 8 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that returns names of all students who are
 * experienced in both 'Python' and 'R'.
 *
 * IMPORTANT NOTE: This question must be answered with a single SQL query. If
 *                 your answer involves more that one query, it will be marked
 *                 incorrect even if the output is correct.
 *
 */

-- START ANSWER 8 --

SELECT DISTINCT S.name
FROM (SELECT SS.student_id
FROM student_skills AS SS
WHERE SS.student_skill = 'Python') AS python,
(SELECT SS.student_id
FROM student_skills AS SS
WHERE SS.student_skill = 'R') AS R, students AS S
WHERE S.id=R.student_id
AND S.id=python.student_id
AND R.student_id=python.student_id;


-- END ANSWER 8 --

-------------------------------------------------------------------------------

/*
 * QUESTION 9 (2 points)
 * ---------------------
 *
 * Provide the SQL statement that for each skill (either job skill or student
 * skill) it returns the number of jobs looking for it and the number of
 * students having it.
 *
 * IMPORTANT NOTE: This question must be answered with a single SQL query. If
 *                 your answer involves more that one query, it will be marked
 *                 incorrect even if the output is correct.
 *
 */

-- START ANSWER 9 --

SELECT DISTINCT * FROM
(SELECT skills_list.student_skill, skills_have.count_student_skills_have FROM
(SELECT DISTINCT SS.student_skill FROM student_skills AS SS UNION SELECT DISTINCT JS.job_skill
FROM job_skills AS JS) AS skills_list LEFT OUTER JOIN 
(SELECT SS.student_skill, COUNT(SS.student_skill) AS count_student_skills_have
FROM student_skills AS SS, students AS S
WHERE SS.student_id = S.id
GROUP BY SS.student_skill) AS skills_have
ON skills_list.student_skill = skills_have.student_skill) AS have_skills
NATURAL JOIN
(SELECT skills_list.student_skill, skills_wanted.count_job_skills_wanted FROM
(SELECT DISTINCT SS.student_skill FROM student_skills AS SS UNION SELECT DISTINCT JS.job_skill
FROM job_skills AS JS) AS skills_list LEFT OUTER JOIN 
(SELECT JS.job_skill, COUNT(JS.job_skill) AS count_job_skills_wanted
FROM job_skills AS JS, jobs AS J
WHERE JS.job_id = J.id
GROUP BY JS.job_skill) AS skills_wanted
ON skills_list.student_skill = skills_wanted.job_skill) AS want_skills
WHERE have_skills.student_skill = want_skills.student_skill;

-- END ANSWER 9 --

-------------------------------------------------------------------------------

/*
 * QUESTION 10 (4 points)
 * ----------------------
 *
 * (This is a multi-part question, make sure you end each statement with ';')
 *
 * Provide all necessary SQL statements that create a trigger. The trigger must
 * ensure that when a new tuple is attempted to be inserted into the
 * "interviews" table, then this tuple will only be stored if the student has
 * a gpa higher than the minimum gpa required for the job. If the student has a
 * lower gpa then the trigger should return an error.
 *
 */

-- START ANSWER 10 --

CREATE OR REPLACE FUNCTION gpa_trigger()
RETURNS trigger AS
$body$
BEGIN 
IF (SELECT S.gpa FROM students AS S WHERE s.id=New.student_id) < 
(SELECT J.min_gpa FROM jobs AS J WHERE j.id=NEW.jobs_id) THEN
RAISE EXCEPTION 'ERROR: Student gpa does not satisfy job gpa requirement';
END IF;
RETURN NEW;
END;
$body$
LANGUAGE plpgsql;

CREATE TRIGGER gpa_trigger
BEFORE INSERT OR UPDATE OR DELETE ON interviews
FOR EACH ROW EXECUTE PROCEDURE gpa_trigger();

-- END ANSWER 10 --

-------------------------------------------------------------------------------
