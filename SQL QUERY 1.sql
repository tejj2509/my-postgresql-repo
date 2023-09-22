SELECT first_name, last_name, email FROM customer;
SELECT DISTINCT(rating) FROM film; 
SELECT COUNT(DISTINCT (amount)) FROM payment;
SELECT COUNT(*) FROM customer
WHERE first_name = 'John';
SELECT * FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';
SELECT title FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';
SELECT COUNT(title) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';
SELECT title FROM film
WHERE rating = 'R' OR rating = 'PG-13';
SELECT * FROM film
WHERE rating <> 'R';
-- Task on WHERE CLAUSE
SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';
-- Task #2
SELECT description FROM film
WHERE title = 'Outlaw Hanky';
-- Task #3
SELECT phone FROM address
WHERE address = '259 Ipoh Drive';
-- Class ORDER BY
SELECT * FROM customer
ORDER BY first_name ASC;

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id ASC, first_name DESC;

-- Challenge 1
SELECT customer_id FROM payment
WHERE amount != 0.00
ORDER BY payment_date ASC
LIMIT 10;

-- Challenge 2
SELECT title, length FROM film
ORDER BY length ASC 
LIMIT 5;

--Note: here length is actually a keyword, but since we are using capital letters for commands
-- We can understand that it is not a keyword but the name of a column.

--Challenge 3
SELECT COUNT(title) FROM film
WHERE length <= 50;

-- Class BETWEEN
SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 8.00 AND 9.00;

-- Class NOT BETWEEN
SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8.00 AND 9.00;

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-14';

-- Class IN and NOT IN
SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99);

SELECT * FROM customer
WHERE first_name IN ('John', 'Robert', 'David', 'Jack', 'Bill', 'Zach');

--Class LIKE AND ILIKE
SELECT * FROM customer
WHERE first_name LIKE 'J%';

SELECT COUNT(*) FROM customer
WHERE first_name LIKE 'J%';

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

SELECT * FROM customer
WHERE first_name ILIKE 'j%' AND last_name ILIKE 'j%';

SELECT * FROM customer
WHERE first_name LIKE '_her%';

SELECT COUNT(*) FROM customer
WHERE first_name NOT LIKE '_her%';

SELECT * FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;

--Class on Group By and Aggregate functions

SELECT MIN(replacement_cost) FROM film;

SELECT MAX(replacement_cost) FROM film;

SELECT MAX(replacement_cost),MIN(replacement_cost)
FROM film;

SELECT ROUND(AVG(replacement_cost),2) FROM film;

SELECT SUM(replacement_cost) FROM film;

--Class GROUP BY 
SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

SELECT customer_id, COUNT(amount) 
FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

SELECT customer_id, staff_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY SUM(amount) DESC;

SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

-- Challenge 1
SELECT staff_id, COUNT(rental_id)
FROM payment
GROUP BY staff_id
ORDER BY COUNT(rental_id) DESC;

-- Challenge 2
SELECT rating, ROUND(AVG(replacement_cost),4)
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(replacement_cost),4) DESC;

--Challenge 3
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

--Class HAVING
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

--Challenge 1
SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40;

--Challenge 2
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id != 1
GROUP BY customer_id, staff_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;

-- Class on AS and JOINS

SELECT COUNT(amount) AS num_transactions
FROM payment;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100;

-- Class INNER JOIN
SELECT payment_id, payment.customer_id, first_name
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id;

SELECT payment_id, payment.customer_id, email, payment.amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id;

--Class FULL OUTER JOIN
SELECT * FROM payment
FULL OUTER JOIN customer
ON customer.customer_id = payment.customer_id
WHERE customer.email IS null
OR payment.payment_id IS null

-- Another way to check this privacy policy is by using distinct count

SELECT COUNT(DISTINCT customer_id) FROM payment;

SELECT COUNT(DISTINCT customer_id) FROM customer;

--Since 599 = 599 we can confirm there are no discrepencies, however we cannot rely on this
-- 100% surely as there might be same number of different distinct values

--Class LEFT OUTER JOIN
SELECT  * FROM film;

SELECT * FROM inventory;

SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
WHERE inventory.film_id IS null;

--Challenge 1 easy

SELECT email, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'California';

--Challenge 2

SELECT * FROM film;

SELECT * FROM film_actor 
WHERE actor_id = 2;

SELECT * FROM actor 
WHERE actor_id = 2;

SELECT film.title, actor.first_name, actor.last_name
FROM film_actor
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg';

-- Class TIMESTAMPS AND EXTRACT
SHOW TIMEZONE;

SELECT NOW();

SELECT TIMEOFDAY();

SELECT CURRENT_TIME;

SELECT CURRENT_DATE;

--CLASS EXTRACT, AGE AND TO_CHAR

SELECT * FROM payment;

SELECT EXTRACT(MONTH from payment_date) AS payment_month
FROM payment;

SELECT AGE(payment_date)
FROM payment;

SELECT TO_CHAR(payment_date, 'MM/DD/YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'mon/DD/YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'DD/MM/YYYY')
FROM payment;

--CHALLENGE 1
SELECT DISTINCT(TO_CHAR(payment_date,'MONTH')) AS payment_months
FROM payment;

SELECT COUNT(TO_CHAR(payment_date, 'Day')) As payments_on_monday
FROM payment
WHERE TO_CHAR(payment_date, 'Day') = 'Monday   ';

-- CLASS Mathematical Operations and functions

SELECT title, ROUND(rental_rate/replacement_cost,4)*100 AS cost_percent
FROM film;

SELECT title, 0.1*replacement_cost AS init_deposit
FROM film;

--Class String operations and functions

SELECT first_name || ' ' ||last_name AS full_name
FROM customer;

SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer;

SELECT LOWER(first_name) || '.' || LOWER(last_name) || '@' || 'sakilacustomer.org'
AS custom_email,
email 
FROM customer;

SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) ||'@gamil.com'
AS custom_gmail
FROM customer;
