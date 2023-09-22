--Class SUBQUERY
SELECT title, rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate)
					FROM film);

SELECT * FROM inventory;

SELECT * FROM rental
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';

SELECT film_id, title
FROM film
WHERE film_id IN 
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');

SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11);

SELECT first_name, last_name
FROM customer AS c
WHERE NOT EXISTS
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11);

--Class Self Join

SELECT table1.title, table1.length, table2.title AS tit
FROM film AS table1
JOIN film AS table2
ON table1.length = table2.length
AND table1.film_id != table2.film_id;

--CLASS CASE

SELECT customer_id,

CASE
	WHEN (customer_id <=100) THEN 'Premium'
	WHEN (customer_id >100) AND (customer_id <=200) THEN 'Plus'
	ELSE 'Normal' 
END AS customer_class
FROM customer;

-- CLASS CASE EXPRESSION

SELECT customer_id,
CASE customer_id
	WHEN 2 THEN '!!! Winner !!!'
	WHEN 5 THEN '!! Runner Up !'
	ELSE 'Normal :('	
END AS raffle_results
FROM customer;

SELECT DISTINCT(rental_rate) 
FROM film;

SELECT rental_rate,
CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END AS num_of_bargains
FROM film;

SELECT
SUM(CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
END) AS bargains,
SUM(CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
END) AS regular,
SUM(CASE rental_rate
		WHEN 4.99 THEN 1
		ELSE 0
END) AS premium
FROM film;

-- Challenge CASE

SELECT * FROM film;

SELECT
SUM(CASE rating
		WHEN 'R' THEN 1
		ELSE 0
END) AS r,
SUM(CASE rating
		WHEN 'PG' THEN 1
		ELSE 0
END) AS pg,
SUM(CASE rating
		WHEN 'PG-13' THEN 1
		ELSE 0
END) AS pg13
FROM film;

-- Class COALESCE is in the notes

-- Class CAST

SELECT CAST('5' AS INTEGER) AS new_int;

SELECT '5'::INTEGER AS new_int; -- Only applicable in Postgre SQL engine

SELECT * FROM rental;

SELECT inventory_id::VARCHAR
FROM rental;

SELECT CHAR_LENGTH(inventory_id::VARCHAR)
FROM rental;

SELECT * FROM address;

-- Class VIEWS

CREATE VIEW customer_info AS 
SELECT first_name, last_name, address
FROM customer
INNER JOIN address ON
customer.address_id = address.address_id;

SELECT * FROM customer_info;

CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district
FROM customer
INNER JOIN address ON
customer.address_id = address.address_id;

DROP VIEW IF EXISTS c_info

ALTER VIEW customer_info RENAME TO c_info;

SELECT * FROM c_info;