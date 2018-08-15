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

-- 7.a
SELECT title FROM film WHERE title LIKE ('K%') OR title LIKE ('Q%') AND language_id IN (
SELECT language_id FROM language WHERE name = "English");

-- 7.b
SELECT first_name, last_name FROM actor WHERE actor_id IN (
SELECT actor_id FROM film_actor WHERE film_id IN(
SELECT film_id FROM film WHERE title = "ALONE TRIP"));

-- 7.c
SELECT first_name, last_name, email FROM customer WHERE address_id IN(
SELECT address_id FROM address WHERE city_id IN(
SELECT city_id FROM city WHERE country_id IN(
SELECT country_id FROM country WHERE country = "Canada")));

-- 7.d
SELECT title AS "Family Films", film_id AS "Film ID" FROM film WHERE film_id IN(
SELECT film_id FROM film_category WHERE category_id IN(
SELECT category_id FROM category WHERE name = "Family"));

-- 7.e
SELECT f.title AS "Film Title", count(r.rental_id) AS "Number of Rentals" FROM rental r
JOIN inventory i ON
r.inventory_id = i.inventory_id
JOIN film f ON
i.film_id = f.film_id GROUP BY f.title ORDER BY count(r.rental_id) DESC;

-- 7.f
SELECT s.store_id AS "Store ID", sum(p.amount) AS "Total Revenue" FROM store s
JOIN inventory i ON
s.store_id = i.store_id
JOIN rental r ON
i.inventory_id = r.inventory_id
JOIN payment p ON
r.rental_id = p.rental_id GROUP BY s.store_id;

-- 7.g
SELECT s.store_id AS "Store ID", c.city AS "City", co.country AS "Country" FROM store s
JOIN address a ON
s.address_id = a.address_id
JOIN city c ON
a.city_id = c.city_id
JOIN country co ON
c.country_id = co.country_id;

-- 7.h
SELECT c.name AS "Film Genre", sum(p.amount) AS "Gross Revenue" FROM category c
JOIN film_category fc ON
c.category_id = fc.category_id
JOIN inventory i ON
fc.film_id = i.film_id
JOIN rental r ON
i.inventory_id = r.inventory_id
JOIN payment p ON
r.rental_id = p.rental_id GROUP BY c.name ORDER BY sum(p.amount) DESC LIMIT 5;

-- 8.a
CREATE VIEW top_five_genres AS
SELECT c.name AS "Film Genre", sum(p.amount) AS "Gross Revenue" FROM category c
JOIN film_category fc ON
c.category_id = fc.category_id
JOIN inventory i ON
fc.film_id = i.film_id
JOIN rental r ON
i.inventory_id = r.inventory_id
JOIN payment p ON
r.rental_id = p.rental_id GROUP BY c.name ORDER BY sum(p.amount) DESC LIMIT 5;

-- 8.b
SELECT * FROM top_five_genres;

-- 8.c
DROP VIEW top_five_genres;
