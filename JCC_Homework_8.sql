USE sakila;

-- 1.a
SELECT first_name, last_name FROM actor;

-- 1.b
SELECT CONCAT(first_name, ' ', last_name) AS "Actor Name" FROM actor;

-- 2.a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "JOE";

-- 2.b
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%GEN%";

-- 2.c
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

-- 2.d
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3.a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3.b
ALTER TABLE actor
DROP COLUMN description;

-- 4.a
SELECT last_name, count(last_name) FROM actor GROUP BY last_name;

-- 4.b
SELECT last_name, count(last_name) AS "Total" FROM actor GROUP BY last_name HAVING count(last_name) > 1;

-- 4.c
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

-- 4.d
UPDATE actor SET first_name = "GROUCHO" WHERE first_name = "HARPO";
SET SQL_SAFE_UPDATES = 1;

-- 5.a
SHOW CREATE TABLE address;

-- 6.a
SELECT s.first_name, s.last_name, a.address FROM staff s
JOIN address a ON
s.address_id = a.address_id;

-- 6.b
SELECT  CONCAT(s.first_name, ' ', s.last_name) AS "Employee", sum(p.amount) AS "Total for August 2005" FROM staff s
JOIN payment p ON
s.staff_id = p.staff_id WHERE p.payment_date LIKE "2005-08%"
GROUP BY CONCAT(s.first_name, ' ', s.last_name);

-- 6.c
SELECT f.title AS "Film Title", count(fa.actor_id) AS "Number of Actors" FROM film f
JOIN film_actor fa ON
f.film_id = fa.film_id GROUP BY f.title;

-- 6.d
SELECT f.title AS "Film Title", count(i.inventory_id) AS "Copies in Inventory" FROM film f
JOIN inventory i ON
f.film_id = i.film_id WHERE f.title = "HUNCHBACK IMPOSSIBLE";

-- 6.e
SELECT c.first_name, c.last_name, sum(p.amount) AS "Total Paid" FROM customer c
JOIN payment p ON
c.customer_id = p.customer_id GROUP BY c.first_name, c.last_name ORDER BY c.last_name;
