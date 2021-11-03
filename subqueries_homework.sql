-- List all customers who live in Texas

SELECT customer_id, customer.first_name, customer.last_name, address.address, district
FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district LIKE 'Texas';

--Get all payments above $6.99 with the Customer's Full Name
SELECT amount, payment.customer_id, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

--Show all customers names who have made payments over $175(use subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--List all customers that live in Nepal (use the city table)

SELECT store_id,first_name,last_name,address, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal'; 

-- Which staff member had the most transactions?

SELECT staff.staff_id,first_name, last_name, count(amount)
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER by count(amount) DESC
Limit 1;

-- How many movies of each rating are there?

SELECT rating, count(rating)
FROM film
GROUP BY rating
ORDER by count(rating) DESC
Limit 1;

-- Show all customers who have made a single payment above $6.99 (Use Subqueries)
	
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN(
	SELECT amount
	FROM payment
	WHERE amount > 6.99
	GROUP BY payment.amount
	ORDER BY count(amount) DESC
)
GROUP BY customer.customer_id
HAVING count(amount) = 1;

-- How many free rentals did our stores give away?

SELECT amount, count(amount)
FROM payment
WHERE amount = 0
GROUP BY amount
;