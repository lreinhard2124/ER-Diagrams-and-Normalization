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


-- HOMEWORK ASSIGNMENT 2 (DUE 9/24/2019, 11:59 pm EST)

/*
 *  NOTES:
 *
 *    - Type your SQL statements between the START and END tags for each
 *      question, as shown in the example. Do not alter this template .sql file
 *      in any other way other than adding your answers. Do not delete the
 *      START/END tags. The .sql file you submit will be validated before
 *      grading and will not be graded if it fails validation due to any
 *      alteration of the commented sections.
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
 */


/*
 * EXAMPLE
 * -------
 *
 * Provide the SQL statement that returns all attributes and tuples from
 * a relation named "table1".
 *
 */

-- START EXAMPLE --

SELECT * FROM table1;

-- END EXAMPLE --


-------------------------------------------------------------------------------



/*
 * QUESTION 1 (1 point)
 * --------------------
 *
 * Provide the SQL statement that creates a table named "products" with the
 * following attributes:
 *
 *   - "sku" : fixed length character string of length 10
 *   - "name" : variable length character string of length 50
 *   - "category" : variable length character string of length 30
 *   - "price" : fixed point number with 10 digits, 2 decimals
 *   - "description" : variable length character string of maximum length
 *   - "ship_weight" : fixed point number with 6 digits, 1 decimal (stored in ounces)
 *   - "date_listed" : timestamp without time zone
 *   - "last_update" : timestamp without time zone
 *
 * Do not implement integrity constraints.
 *
 */

-- START ANSWER 1 --

CREATE TABLE products (
sku char(10),
name varchar(50),
category varchar(30),
price numeric(10,2),
description varchar,
ship_weight numeric(6,1),
date_listed timestamp,
last_update timestamp
);


-- END ANSWER 1 --

-------------------------------------------------------------------------------

/*
 * QUESTION 2 (1 point)
 * --------------------
 *
 * Provide the SQL statement that populates the "products" table with values as
 * shown in the following table. (Note: try to run this in one statement, not
 * multiple INSERT statements)
 *
 * +-----------+-----------------------------------------+---------------------------+-------+-----------------------------------------------+-------------+---------------------+---------------------+
 * | sku       | name                                    | category                  | price | description                                   | ship_weight | date_listed         | last update         |
 * +-----------+-----------------------------------------+---------------------------+-------+-----------------------------------------------+-------------+---------------------+---------------------+
 * |           |                                         |                           |       | The Philips Norelco Shaver 4500 lets you      | 14.4        | 2016-02-20 09:12:00 | 2018-01-12 15:23:00 |
 * |           |                                         |                           |       | shave any way you want. The AquaTec seal      |             |                     |                     |
 * | TSD992456 | Philips Norelco Shaver 4500             | Personal Care             | 54.99 | gives you the option of either a comfortable  |             |                     |                     |
 * |           |                                         |                           |       | dry shave or a refreshing wet shave with or   |             |                     |                     |
 * |           |                                         |                           |       | without shaving cream or gel.                 |             |                     |                     |
 * +-----------+-----------------------------------------+---------------------------+-------+-----------------------------------------------+-------------+---------------------+---------------------+
 * |           |                                         |                           |       | Ticonderoga has a tradition of fine quality   | 5.8         | 2015-12-01 07:34:50 | 2015-12-01 07:34:50 |
 * |           |                                         |                           |       | writing instruments in the US for over 100    |             |                     |                     |
 * | SPE237105 | Ticonderoga Pencils #2 HB Soft, 30-Pack | Office Products           | 4.99  | years. The exclusive graphite core features   |             |                     |                     |
 * |           |                                         |                           |       | a proprietary formula focusing on graphite    |             |                     |                     |
 * |           |                                         |                           |       | mined from carefully controlled sources to    |             |                     |                     |
 * |           |                                         |                           |       | deliver extra smooth performance.             |             |                     |                     |
 * +-----------+-----------------------------------------+---------------------------+-------+-----------------------------------------------+-------------+---------------------+---------------------+
 * | KLQ509364 | Anker PowerCore 10000 PD                | Cell Phones & Accessories | 34.99 |                                               | 5.6         | 2019-04-15 15:05:23 |                     |
 * +-----------+-----------------------------------------+---------------------------+-------+-----------------------------------------------+-------------+---------------------+---------------------+
 *
 */

-- START ANSWER 2 --

INSERT INTO products (sku, name, category, price, description, ship_weight, date_listed, last_update)
VALUES ('TSD992456',
'Philips Norelco Shaver 4500',
'Personal Care',
'54.99',
'The Philips Norelco Shaver 4500 lets you shave any way you want. The AquaTec seal gives you the option of either a comfortable dry shave or a refreshing we shave with or without shaving cream or gel.',
'14.4',
'2016-02-20 09:12:00',
'2018-01-12 15:23:00'
), 
('SPE237105',
'Ticonderoga Pencils #2 HB Soft, 30-Pack',
'Office Products',
'4.99',
'Ticonderoga has a tradition of fine quality writing instruments in the US for over 100 years. The exclusive graphite core features a proprietary formula focusing on graphite mined from carefully controlled sources to deliver extra smooth performance.',
'5.8',
'2015-12-01 07:34:50',
'2015-12-01 07:34:50'
),
('KLQ509364',
'Anker PowerCore 10000 PD',
'Cell Phones & Accessories',
'34.99',
NULL,
'5.6',
'2019-04-15 15:05:23',
NULL
);


-- END ANSWER 2 --

-------------------------------------------------------------------------------

/*
 * QUESTION 3 (1 point)
 * --------------------
 *
 * Provide the SQL statement that returns all attributes and tuples from table
 * "products", of category "Office Products".
 *
 */

-- START ANSWER 3 --

SELECT * 
FROM products 
WHERE category = 'Office Products';


-- END ANSWER 3 --

-------------------------------------------------------------------------------

/*
 * QUESTION 4 (1 point)
 * --------------------
 *
 * Remember that the "ship_weight" attribute stores values in ounces. Provide
 * the SQL statement that returns the sku, name, category, prince and lastly
 * ship_weight in grams (note: 1 ounce = 28.3495 grams). Rename ship_weight
 * to ship_weight_grams.
 *
 */

-- START ANSWER 4 --

SELECT sku, name, category, price, ship_weight*28.3495 AS ship_weight_grams
FROM products;

-- END ANSWER 4 --

-------------------------------------------------------------------------------

/*
 * QUESTION 5 (1 point)
 * --------------------
 *
 * Provide the SQL statement that returns the "name" and "price" attributes
 * of all "Personal Care" products that contain the word "shave" anywhere in
 * their desription.
 *
 */

-- START ANSWER 5 --

SELECT name, price 
FROM products
WHERE category = 'Personal Care' AND  description LIKE '%shave%';


-- END ANSWER 5 --

-------------------------------------------------------------------------------

/*
 * QUESTION 6 (1 point)
 * --------------------
 *
 * Provide the SQL statement that creates a relation named "vendors" with
 * attributes "vendor_id" (integer), "name" (variable length character string
 * of length 60), "country" (variable length character string of length 30).
 * Do not implement integrity constraints.
 *
 */

-- START ANSWER 6 --

CREATE TABLE vendors (
vendor_id integer,
name varchar(60),
country varchar(30)
);


-- END ANSWER 6 --

-------------------------------------------------------------------------------

/*
 * QUESTION 7 (1 point)
 * --------------------
 *
 * Provide the SQL statement that alters relation "products" adding an attribute
 * called "vendor_id" (integer).
 *
 */

-- START ANSWER 7 --

ALTER TABLE products
ADD vendor_id integer;

-- END ANSWER 7 --

-------------------------------------------------------------------------------

/*
 * QUESTION 8 (1 point)
 * --------------------
 *
 * Provide the SQL statement that returns the product name with the maximum
 * ship_weight of "Cell Phones & Accessories" products. (note: for this and the
 * following questions, it would be good do insert additional data in order to
 * test your answers)
 *
 */

-- START ANSWER 8 --

SELECT name, ship_weight
FROM products
WHERE ship_weight IN (SELECT MAX(ship_weight) FROM products WHERE category='Cell Phones & Accessories');


-- END ANSWER 8 --

-------------------------------------------------------------------------------

/*
 * QUESTION 9 (1 point)
 * --------------------
 *
 * Provide the SQL statement that returns the category and average price per
 * product category, of all products listed after January 1st, 2018.
 * (hint: use GROUP BY)
 *
 */

-- START ANSWER 9 --

SELECT category,ROUND(AVG(price),2)AS avg_price
FROM products
WHERE date_listed > '2018-01-01 24:00:00'
GROUP BY category;


-- END ANSWER 9 --

-------------------------------------------------------------------------------

/*
 * QUESTION 10 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that returns the sku, name, category, price and
 * vendor name of all products supplied by a vendor from the "USA".
 * (Hint: we are not implementing joins yet, use the cartesian product. Also,
 * assume that the "vendor_id" in the "vendors" relation can correlate with the
 * new "vendor_id" attribute of the "products" relation).
 *
 */

-- START ANSWER 10 --

SELECT P.sku, P.name, P.category, P.price, V.name
FROM products AS P, vendors AS V
WHERE P.vendor_id = V.vendor_id 
AND V.country = 'USA';


-- END ANSWER 10 --

-------------------------------------------------------------------------------

/*
 * QUESTION 11 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that returns the product name, category, price,
 * ship_weight and vendor country of all products. Display the results by
 * descending ship_weight and date_listed. (Hint: same as Q10)
 *
 */

-- START ANSWER 11 --

SELECT P.name, P.category, P.price, P.ship_weight, V.country
FROM products AS P, vendors AS V
WHERE P.vendor_id = V.vendor_id
ORDER BY P.ship_weight DESC, P.date_listed DESC;   


-- END ANSWER 11 --

-------------------------------------------------------------------------------

/*
 * QUESTION 12 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that returns the category, vendor_id and total
 * number of products for each category/vendor_id combination.
 *
 */

-- START ANSWER 12 --

SELECT category, vendor_id, COUNT(*) AS product_count
FROM products 
GROUP BY category, vendor_id;


-- END ANSWER 12 --

-------------------------------------------------------------------------------

/*
 * QUESTION 13 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that returns the unique combination of category and
 * ship_weight from the products relation.
 *
 */


-- START ANSWER 13 --

SELECT DISTINCT category, ship_weight
FROM products;


-- END ANSWER 13 --

-------------------------------------------------------------------------------

/*
 * QUESTION 14 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that deletes all tuples from relation "products"
 * of products listed prior to 2017.
 *
 */

-- START ANSWER 14 --

DELETE FROM products 
WHERE date_listed < '2017-01-01 00:00:00';


-- END ANSWER 14 --

-------------------------------------------------------------------------------

/*
 * QUESTION 15 (1 point)
 * ---------------------
 *
 * Provide the SQL statement that removes the "vendors" relation from the
 * database.
 *
 */

-- START ANSWER 15 --

DROP TABLE vendors;

-- END ANSWER 15 --

-------------------------------------------------------------------------------
