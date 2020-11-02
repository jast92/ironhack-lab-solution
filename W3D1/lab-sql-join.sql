use sakila;

#1. List number of films per category.

select c.name as 'Category', count(f.film_id) as 'Number of films'
from film_category f join category c
on f.category_id = c.category_id
group by f.category_id
order by count(f.film_id) desc;

#2. Display the first and last names, as well as the address, of each staff member.

select s.staff_id, s.first_name, s.last_name, a.address, a.address2, a.district, a. city_id, a.postal_code, a.location
from staff s join address a
on s.address_id = a.address_id
order by s.first_name, s.last_name;

#3. Display the total amount rung up by each staff member in August of 2005.

select s.first_name, s.last_name, sum(p.amount) as TotalAmount
from payment p join staff s
on p.staff_id = s.staff_id
where p.payment_date >= convert('2005-08-01', datetime) and p.payment_date < convert('2005-09-01', datetime)
group by p.staff_id
order by TotalAmount desc;

#4. List each film and the number of actors who are listed for that film.

select f.title, count(a.actor_id) as TotalActors
from film f join film_actor a
on f.film_id = a.film_id
group by a.film_id
order by TotalActors desc;

#5. Using the tables payment and customer and the JOIN command, list the total paid by each customer.
#List the customers alphabetically by last name.

select c.last_name, c.first_name, sum(amount) as TotalAmount
from customer c join payment p
on c.customer_id = p.customer_id
group by p.customer_id
order by c.last_name;
