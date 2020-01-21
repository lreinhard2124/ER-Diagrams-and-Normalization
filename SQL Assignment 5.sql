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


-- HOMEWORK ASSIGNMENT 5 (DUE 10/22/2019, 11:59 pm EST)

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
 *
 * NOTE: For Questions 1 through 4, you have to use the following relation:
 *
 *          weather_data (station, name, date, time, hourly_temp, hourly_wind)
 *
 *       The CREATE TABLE and INSERT INTO statements for this schema are
 *       provided in a separate file on the HW5 canvas page.
 *
 *
 * QUESTION 1 (2 points)
 * ---------------------
 * Provide the SQL statement that returns the station, name, date, time, hourly_temp
 * and rank of hourly temperatures. Display the results in proper rank order.
 * The hottest reading across all stations should be ranked first and the coldest
 * coldest last. Apply dense ranking.
 *
 */

-- START ANSWER 1 --

SELECT station, name, date, time, hourly_temp, 
DENSE_RANK() OVER (ORDER BY hourly_temp DESC) as rank_temp
FROM weather_data
;


-- END ANSWER 1 --

-------------------------------------------------------------------------------

/*
 * QUESTION 2 (2 points)
 * ---------------------
 * Provide the SQL statement that returns the station, name, date, time, hourly_temp
 * and rank of hourly temperatures for each station. Display the results in
 * proper rank order. The hottest reading for each station be ranked first and
 * the coldest last. Apply normal ranking. Sort by station name and rank.
 *
 */

-- START ANSWER 2 --

SELECT station, name, date, time, hourly_temp, 
RANK() OVER (PARTITION BY name ORDER BY hourly_temp DESC) as rank_temp
FROM weather_data
ORDER BY name, rank_temp;

-- END ANSWER 2 --

-------------------------------------------------------------------------------

/*
 * QUESTION 3 (2 points)
 * ---------------------
 * Provide the SQL statement that returns the station, name, date, time and moving
 * average of hourly wind speeds on a 3 hour window. Calculation must be per
 * station.
 *
 */

-- START ANSWER 3 --

SELECT station, name, date, time, AVG(hourly_wind) OVER     
(PARTITION BY station ORDER BY station, date, time ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 
AS avg_wind_3_hr_window
FROM weather_data;

-- END ANSWER 3 --

-------------------------------------------------------------------------------

/*
 * QUESTION 4 (2 points)
 * ---------------------
 * Provide the SQL statement that returns the station, name, date, hourly
 * temperature and daily average temperature per station.
 *
 */

-- START ANSWER 4 --

SELECT station, name, date, hourly_temp, AVG(hourly_temp) OVER     
(PARTITION BY station, date ORDER BY station, date) 
AS avg_daily_temp
FROM weather_data
ORDER BY station, date, time;

-- END ANSWER 4 --

-------------------------------------------------------------------------------

/*
 * QUESTION 5 (8 points)
 * ---------------------
 * Refer to the Google Sheet at the link below.
 *
 * https://docs.google.com/spreadsheets/d/1SWWr1MMP36QWlnp0dNZ5V4urpQfwYXhZ5cHAVUaOhxU/edit?usp=sharing
 *
 * In order to access it you must use your Columbia Google account, no personal
 * or other Google accounts. You may download the linked spreadsheet as “XLSX” or
 * copy to your own Google account and use it as a template for your answers.
 * When done, export to PDF and submit.
 *
 * The table shown is a simplified scenario of a movie rental store. Each row
 * contains information about the customer and the movie(s) they rented. Notice
 * that a customer may rent more than one movies at a time. Your task is to
 * produce a relational design up to third normal form (3NF). Show all work and
 * add comments. Show the tables at each step with the data. Remember that you
 * may not need to make changes at every normal form step if the rule is
 * satisfied.
 *
 */

 -- No START/END tags here. Your answer is a separate PDF submitted along with
 -- this SQL file.

-------------------------------------------------------------------------------
