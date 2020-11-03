#Lab SQL Subqueries

use sakila;

#1. How many copies of the film Hunchback Impossible exist in the inventory system?
select count(inventory_id) as 'Copies of Hunchback Impossible'
from inventory
where film_id = (select film_id from film
where title = 'Hunchback Impossible');

#2. List all films whose length is longer than the average of all the films.

select *
from film
where length > (select avg(length) from film);

#3. Use subqueries to display all actors who appear in the film Alone Trip.

select distinct first_name, last_name
from actor
where actor_id in (select distinct actor_id from film_actor
where film_id = (select distinct film_id from film where title = 'Alone Trip'));

#4. Sales have been lagging among young families, and you wish to target all family movies
#for a promotion. Identify all movies categorized as family films.

select title
from film
where film_id in (select film_id from film_category
where category_id = (select category_id from category
where name = 'Family'));


#5. Get name and email from customers from Canada using subqueries.
#Do the same with joins. Note that to create a join, you will have to identify the
#correct tables with their primary keys and foreign keys, that will help you get the
#relevant information.

#Subquery select
select first_name, last_name, email
from customer
where address_id in (select address_id from address
where city_id in (select city_id from city
where country_id = (select country_id from country
where country = 'Canada')));

#Join select
select c.first_name, c.last_name, c.email, co.country
from customer c
join address a on (c.address_id = a.address_id)
join city ci on (a.city_id = ci.city_id)
join country co on (ci.country_id = co.country_id)
where (co.country = 'Canada');

#6. Which are films starred by the most prolific actor?
#Most prolific actor is defined as the actor that has acted in the most number of films.
#First you will have to find the most prolific actor and then use that actor_id to find
#the different films that he/she starred.

select concat(a.first_name, ' ', a.last_name) as actor_name, f.title, f.release_year
from film f
join film_actor fa on (f.film_id = fa.film_id)
join actor a on (fa.actor_id = a.actor_id)
where (fa.actor_id = (select fa.actor_id from film f
join film_actor fa on (f.film_id = fa.film_id)
join actor a on (fa.actor_id = a.actor_id)
group by fa.actor_id
order by count(fa.film_id) desc
limit 1));

#Alternative solution for 6.:

select concat(first_name, ' ', last_name) as actor_name, film.title, film.release_year
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join film
using (film_id)
where actor_id = (
select actor_id
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join sakila.film
using (film_id)
group by actor_id
order by count(film_id) desc
limit 1
)
order by release_year desc;

#?????????????????????????????????
#7. Films rented by most profitable customer.
#You can use the customer table and payment table to find the most profitable customer
#ie the customer that has made the largest sum of payments.

select f.film_id, f.title, r.rental_date, p.amount
from customer c
join payment p on (c.customer_id = p.customer_id)
join rental r on (p.rental_id = r.rental_id)
join inventory i on (r.inventory_id = i.inventory_id)
join film f on (i.film_id = f.film_id)
where (c.customer_id = (select p.customer_id
from payment p
group by p.customer_id
order by sum(p.amount) desc
limit 1))
order by r.rental_date desc;

#8. Customers who spent more than the average payments.

select customer_id, concat(first_name, ' ', last_name) as power_customers, sum(amount) as 'payment'
from customer
join payment using (customer_id)
group by customer_id
having sum(amount) > (select avg(amount)
from payment)
order by sum(amount) desc;
