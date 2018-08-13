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


