#Lab | SQL Joins on multiple tables

use sakila;

#1. Write a query to display for each store its store ID, city, and country.

select s.store_id, ci.city, co.country
from store s
join address a on s.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.

select sto.store_id, ci.city, co.country, sum(amount) as TotalAmount
from store sto
join staff sta on sto.manager_staff_id = sta.staff_id
join payment p on sta.staff_id = p.staff_id
join address a on sto.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
group by sto.store_id;

#3. What is the average running time of films by category?

select c.name, avg(length) as avglength
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by fc.category_id
order by avglength desc;

#4. Which film categories are longest?

#The following film categories are on average the longest:
select c.name, avg(length) as avglength
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by fc.category_id
order by avglength desc
limit 3;

#The following film category has the longest film in it:

select c.name, max(length) as maxlength
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by fc.category_id
order by maxlength desc;

#5. Display the most frequently rented movies in descending order.
select f.title, count(r.inventory_id) as frequency
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by r.inventory_id
order by frequency desc;

#6. List the top five genres in gross revenue in descending order.

select c.name as 'category', sum(p.amount) as TotalAmount
from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by TotalAmount
limit 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?

select sto.store_id, ci.city, co.country, f.title, case
when count(f.title) > 0 then 'Available in Store 1'
when count(f.title) = 0 then 'Not available in Store 1' end as 'Availability'
from store sto
join staff sta on sto.manager_staff_id = sta.staff_id
join rental r on sta.staff_id = r.staff_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join address a on sto.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where sto.store_id = 1 and f.title = "Academy Dinosaur";
