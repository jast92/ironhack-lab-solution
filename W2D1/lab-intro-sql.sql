USE sakila;
#1. Show tables in the database.
SHOW TABLES IN sakila;

#2. Explore tables. (select everything from each table)
SELECT * FROM actor;
SELECT * FROM actor_info;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM customer_list;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_list;
SELECT * FROM film_text;
SELECT * FROM inventory;
SELECT * FROM language;
SELECT * FROM nicer_but_slower_film_list;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM sales_by_film_category;
SELECT * FROM sales_by_store;
SELECT * FROM staff;
SELECT * FROM staff_list;
SELECT * FROM store;

#3. Select one column from a table. Get film titles.
SELECT title FROM film;

#4. Select one column from a table and alias it. Get languages.
SELECT name AS language FROM language;

#5. How many stores does the company have? How many employees? which are their names?
#Show number of stores and employees:
SELECT (SELECT COUNT(*) FROM store) AS storenumber, (SELECT COUNT(*) FROM staff) AS employeenumber;

#Show names of employees:
SELECT staff_id, first_name, last_name FROM staff;

