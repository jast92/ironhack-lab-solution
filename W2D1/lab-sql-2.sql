USE sakila;

#1. Select all the actors with the first name ‘Scarlett’.
SELECT *
FROM actor
WHERE first_name = "Scarlett";

#2. Select all the actors with the last name ‘Johansson’.
SELECT *
FROM actor
WHERE last_name = "Johansson";

#3. How many films (movies) are available for rent?
SELECT distinct count(inventory_id) FROM rental;

#4. How many films have been rented?
SELECT DISTINCT count(rental_date) as rented FROM rental;

#5. What is the shortest and longest rental period?

#Shortest duration:
SELECT * FROM film
ORDER BY rental_duration
LIMIT 1;

#Longest duration
SELECT * FROM film
ORDER BY rental_duration DESC
LIMIT 1;

#6. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT min(length) AS max_duration FROM film;

SELECT max(length) AS max_duration FROM film;

#7. What's the average movie duration?
SELECT avg(length) AS avg_duration FROM film;

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

#8. What's the average movie duration expressed in format (hours, minutes)?
SELECT avg(length) AS avg_duration FROM film;

#9.How many movies are longer than 3 hours?
SELECT count(length) AS "longer than 3 h" FROM film
WHERE length > 180;
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

#10. Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.

#11. What's the length of the longest film title?
SELECT max(length(title)) AS "longest film title" FROM film;
