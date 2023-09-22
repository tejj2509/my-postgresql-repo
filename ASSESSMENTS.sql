-- ASSESSMENT 1
-- How many payment transactions were greater than $5.00

SELECT COUNT(*) FROM payment
WHERE amount > 5.00;

--How many actors have the first name that starts with the letter 'p'

SELECT COUNT(*) from actor
WHERE first_name ILIKE 'P%';

-- How many distinct districts are our customers from

SELECT COUNT(DISTINCT(district)) FROM address;

--Names of those Distinct districts:

SELECT DISTINCT(district) FROM address;

-- How many films have a rating of R and a replacement_cost between $5 and $15?

SELECT count(*) FROM film
WHERE (rating = 'R') AND (replacement_cost BETWEEN 5.00 AND 15.00);

SELECT COUNT(*) FROM film
WHERE title ILIKE '%Truman%';

-- ASSESSMENT TEST TEXT LIKE 1
--Question 1
SELECT customer_id, staff_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id, staff_id
HAVING SUM(amount) >= 110;

--Question 2
SELECT COUNT(*) FROM film
WHERE title ILIKE 'J%';

--Question 3
SELECT first_name, last_name
FROM customer
WHERE address_id < 500 AND first_name ILIKE 'E%'
ORDER BY customer_id DESC
LIMIT 1;


