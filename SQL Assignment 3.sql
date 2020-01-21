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


-- HOMEWORK ASSIGNMENT 3 (DUE 10/1/2019, 11:59 pm EST)

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
 * QUESTION 1 (6 points: 1 point for each table plus 1 point for correct order
 *             of execution)
 * ----------------------------------------------------------------------------
 *
 * You are tasked to create a simplified database of a hospital. Provide the
 * SQL statements that create the five tables with data types of your design.
 * Implement integrity constraints (primary/foreign keys, NOT NULL) as needed.
 * Note: since underlining is not supported in this file format, primary keys
 * for each relation below are shown within '*'.
 *
 *   clinics (*clinic_id*, address_id, name)
 *   patients (*patient_id*, address_id, name, gender, dob)
 *   addresses (*address_id*, street, city, state, zip_code, country)
 *   examinations (*patient_id*, *doctor_id*, exam_date, exam_cost, exam_notes)
 *   doctors (*doctor_id*, address_id, clinic_id, name, specialty)
 *
 *
 * Type the CREATE TABLE statements in the order they have to be executed so
 * that there is no error in PostgreSQL. Expand the space between the START/END
 * tags to fit all of your CREATE TABLE statements.
 *
 * IMPORTANT: Make sure to implement the schema with exactly the provided
 *            relation and attribute names. Do not rename relations or
 *            attributes, either by accident (typos) or on purpose.
 *
 *
 * Attribute Descriptions:
 * -----------------------
 *
 * clinics
 * -------
 *  clinic_id: unique ID for clinics (PK)
 *  address_id: unique ID for addresses, this is the address of the clinic
 *  name: the clinic's name (i.e. "Brooklyn Methodist Hospital", etc.)
 *
 * patients
 * --------
 *  patient_id: unique ID for patients (PK)
 *  address_id: unique ID for addresses, this is a patient's home address
 *  name: full name for a patient
 *  gender: the gender that a patient identifies as
 *  dob: the date of birth of a patient
 *
 * addresses
 * ---------
 *  address_id: unique ID for addresses (PK)
 *  street: street name, number and apartment (if applicable)
 *  city: city name
 *  state: state name, not state abbreviation
 *  zip_code: zip code
 *  country: country name
 *
 * examinations
 * ------------
 *  patient_id: unique ID for patients (PK)
 *  doctor_id: unique ID for doctors (PK)
 *  exam_date: date and time of a patient examination by a doctor
 *  exam_cost: cost of examination
 *  exam_notes: notes on the examination (if any)
 *
 * doctors
 * -------
 *  doctor_id: unique ID for doctors (PK)
 *  address_id: unique ID for addresses, this is a doctor's home address
 *  clinic_id: unique ID for clinics
 *  name: full name for a doctor
 *  specialty: doctor specialty (i.e. pediatrician, ophthalmologist, etc.)
 *
 */

-- START ANSWER 1 --

CREATE TABLE addresses (
address_id char(9),
street varchar(60) NOT NULL,
city varchar(40) NOT NULL,
state varchar(40), 
zip_code varchar(10) NOT NULL,
country varchar(40) NOT NULL,
PRIMARY KEY (address_id)
);

CREATE TABLE clinics(
clinic_id char(9),
address_id char(9),
name varchar(60) NOT NULL,
PRIMARY KEY (clinic_id),
FOREIGN KEY (address_id) REFERENCES addresses
);

CREATE TABLE patients (
patient_id char(9),
address_id char(9),
name varchar(60) NOT NULL,
gender varchar(17) NOT NULL,
dob date NOT NULL,
PRIMARY KEY (patient_id),
FOREIGN KEY (address_id) REFERENCES addresses
);

CREATE TABLE doctors (
doctor_id char(9),
address_id char(9),
clinic_id char(9),
name varchar(60) NOT NULL,
specialty varchar(60) NOT NULL,
PRIMARY KEY (doctor_id),
FOREIGN KEY (address_id) REFERENCES addresses,
FOREIGN KEY (clinic_id) REFERENCES clinics
);


CREATE TABLE examinations (
patient_id char(9),
doctor_id char(9),
exam_date timestamp with time zone,
exam_cost integer NOT NULL,
exam_notes varchar,
PRIMARY KEY (patient_id, doctor_id, exam_date),
FOREIGN KEY (patient_id) REFERENCES patients,
FOREIGN KEY (doctor_id) REFERENCES doctors
);

-- END ANSWER 1 --

-------------------------------------------------------------------------------

/*
 * QUESTION 2 (4 points)
 * ---------------------
 *
 * Provide detailed reasoning on your selection of each one of the data types
 * above as well as your implementation of any/all integrity constraints. Include
 * any additional assumptions you made beyond the provided schema description.
 * Explain relationships and cardinalities. Type your answers as plain text
 * within the START/END tags. Expand your answer in as many lines as you need.
 *
 */

-- START ANSWER 2 --

/*
 * We will check for reasonable data types based on the answers shown above. We
 * will also check that primary and foreign keys have been properly defined as
 * well as some basic implementation of NOT NULL, as needed. More important,
 * we want to see well-defined reasoning on the data types, integrity constraints
 * and established relationships and cardinalities. Insufficient/short answers
 * will not receive full credit.
 *
 */

For the table addresses, I set the attribute address_id’s data type as char since all
the entries in the column should be the same length since all the ids will have the same 
length (which I set as 9 to allow for enough permutations). I set the three attributes street, 
city, and state with the data type varchar since each entry will have varying character lengths.
Furthermore, the length for street was set as 60 to allot for long address names and the city and 
state lengths were set at 40 since the length of names are typically less than 40 characters. 
The zip_code attribute has the data type varchar since there are addresses recorded from different 
countries and there are varying lengths for addresses in different countries. The longest zip code 
length in the world is 10, therefore the data length was set at 10 for zip_code. The attribute country 
was also set as varchar(40) since there are varying character lengths in the names of different countries
that are largely under 40 characters. The primary key was identified as the attribute address_id since 
it is a unique number that identifies each address in the table. Finally, the attributes street, city, 
zip_code, and country were given the constraint not null since the values cannot be blank if they are 
to properly locate an address. The attribute state was not given this constraint since some countries 
do not use “states” to divide up their lands, instead preferring principalities or districts.
In the table clinics, I assigned the attributes clinic_id and address_id with the data type char(9) 
since these columns will have values with the length of 9 characters for every entry. Name was assigned 
the data type varchar(60) since there will be clinic names with vary length entered into the table. 
Clinic_id was identified as the primary key since it is a unique number that identifies each clinic 
in the table. The attribute address_id was identified as a foreign key that references the table 
addresses since the attribute address_id is contained in the table addresses as a primary key. The
attribute name was given the constraint not null since the name of the clinic is an important entry 
into the table used to identify clinics. The attributes clinic_id and address_id where not given the 
constraints not null since it is automatically included when the attribute is identified as a primary 
key. The address_id attribute was identified as a primary key in the address table so there are no null 
values being referenced for the clinics table. In the table patients, patient_id and address_id were given
the data type char(9) as explained above for previous ids. The attribute name was given the data type 
varchar(60) since the names of various patients will vary in length and the likelihood of the name being 
longer than 60 characters is low. Gender was assigned the data type varchar with the length 17 since the 
answer with the highest character count is “Prefer not to say”. I assigned the attribute dob the data type
date since date of birth only records the day/month/year of birth without a time stamp. Patient_id was 
identified as the primary key in the patients table since it is a unique number that identifies each 
patient in the table. Address_id was identified as a foreign key since it is a primary key in the 
addresses table. The attributes name, gender and dob were given the constraints not null since they 
contain valuable information that the doctor will need to view when looking up a patient’s info in the 
table. In the table doctors, doctor_id, address_id, and clinic_id were given the data type char(9) for the 
same reasons as explained for the previous tables. Name was given the data_type varchar(60) since the names 
of various doctors will vary in length and the likelihood of the name being longer than 60 characters is 
low. The attribute specialty was given the data type varchar(60) since the doctor may have a variety of
different specialties that vary in character length. The doctor_id was identified as the primary key in 
the doctors table since it is a unique number that identifies each doctor in the table. Address_id was 
identified as a foreign key since it is a primary key in the addresses table and clinic_id was identified
as a foreign key since it is a primary key in the clinics table. The attributes name and specialty were
given the constraints not null since they are important values that should not be blank when someone
queries the doctor table. The other attributes were not given constraints since they are either primary
keys or foreign keys that are primary keys in their original referenced tables. In the table examinations,
the attributes patient_id and doctor_id were assigned the data type char(9) for the same reasons as 
explained for the other tables. The attribute exam_date was assigned the data type timestamp with time zone
since the exam date column needs to log the day/month/year and time of each exam. Furthermore, the
time zone needs to be taken into consideration since there will be data collected from different countries
in different time zones. Exam_cost was assigned the data type integer since it is recording a money amount 
and therefore all entries will be integers. Exam_notes was assigned the data type varchar without any
length constraint since each doctor will have notes of varying different lengths on each examination. 
I listed the attributes patient_id, doctor_id, and exam_date as the primary key since the main identifiers 
for an exam are the participants and when it occurred. Originally, the assignment only listed the 
patient_id and doctor_id as the primary key, however a patient may have multiple exams with the same doctor.
This made it necessary to include the date (and time) at which the exam occurred in the primary key to 
ensure that a query will return the correct exam. Patient_id was identified as a foreign key since it 
is a primary key in the patients table and doctor_id was identified as a foreign key since it is a
primary key in the doctors table. Exam_cost was given the constraint not null since the column contain 
important information that should not be blank when someone queries the examinations table. If there is
an issue with billing, it is important that the clinic has the cost of each exam for each patient on record.
Exam_notes has no constraint since it is possible the doctor has no notes to record on a particular 
examination. The other attributes were not given constraints since they are either primary keys or 
foreign keys that are primary keys in their original referenced tables. It was necessary to create the
requested tables in a certain order since some tables referenced others with the use of foreign keys.
My table order was: addresses, clinics, patients, doctors, and examinations. The table examinations 
referenced patients with the use of foreign key patient_id and also referenced doctors with the 
foreign key doctor_id. The table doctors referenced addresses with the use of the foreign key address_id
and referenced clinics with the foreign key clinic_id. Finally, both tables patients and clinics
referenced the table addresses through the use of the foreign key address_id. Based off of these 
foreign keys, there were a few different orders to successfully create the assigned tables. The code 
would execute as long as the table addresses was created first, the table clinics was created before 
doctors, and the tables patients and doctors were created before examinations (hence the order I chose). 
This final paragraph will explain the cardinalities between the tables in this assignment. There is a many 
to one relationship between the clinics and addresses tables. A clinic is associated with at most one
address, and an address is associated with several (including 0) clinics. There can be several clinics 
at the same address since many clinics share offices, especially in hospitals. There is a many to one 
relationship between the doctors and addresses tables. A doctor is associated with at most one address, 
and an address is associated with several (including 0) doctors. There is a many to one relationship
between the patients and addresses tables. A patient is associated with at most one address, and an 
address is associated with several (including 0) patients. For example, in the case that there are
multiple family members in the system that live in the same family house. There is a many to many 
relationship between the doctors and patients tables that is connected by the relationship set examinations.
A doctor can be associated with several (including 0) patients, and a patient can be associated with several 
(including 0) doctors since they may see various different specialists. There is a many to one relationship 
between the doctors and clinics tables. A doctor is associated with at most one clinic, and a clinic is 
associated with several (including 0) doctors. 


-- END ANSWER 2 --

-------------------------------------------------------------------------------

/*
 * QUESTION 3 (10 points)
 * ----------------------
 *
 * Draw the ER diagram for the schema detailed in Question 1 using the same
 * notation as in Chapter 6 of your textbook, also the notation we presented
 * in the slides and lecture for this module. Pay close attention in properly
 * defining relationships and cardinalities. You may draw the ER diagram in
 * any software you prefer, Lucidchart is recommended. Hand drawn diagrams will
 * not be accepted. Upload the ER diagram as a separate file.
 *
 */

-- No START/END tags here. Your answer is a separate PDF submitted along with
-- this SQL file.

-------------------------------------------------------------------------------

/*
 * QUESTION 4 (5 points)
 * ---------------------
 *
 * Draw the ER diagram for the schema detailed in Question 1 using Engineering
 * notation. Pay close attention in properly defining relationships and
 * cardinalities. You may draw the ER diagram in any software you prefer,
 * Lucidchart is recommended. Hand drawn diagrams will not be accepted. Upload
 * the ER diagram as a separate file.
 *
 */

 -- No START/END tags here. Your answer is a separate PDF submitted along with
 -- this SQL file and the PDF file for the diagram in Question 3.


-------------------------------------------------------------------------------
