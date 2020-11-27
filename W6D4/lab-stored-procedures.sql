use sakila;

#1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies.
#Convert the query into a simple stored procedure.

select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;

drop procedure if exists action_viewers;

delimiter $$
create procedure action_viewers()
begin 
	(select first_name, last_name, email 
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = "Action"
	group by first_name, last_name, email);
end$$
delimiter ;

call action_viewers();

#2. Now keep working on the previous stored procedure to make it more dynamic.
#Update the stored procedure in a such manner that it can take a string argument for the category name
#and return the results for all customers that rented movie of that category/genre.
#For eg., it could be action, animation, children, classics, etc.

drop procedure if exists genre_viewer;

delimiter $$
create procedure genre_viewer(
	IN category_name VARCHAR(255))
begin 
	select first_name, last_name, email 
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = category_name
	group by first_name, last_name, email;
end$$
delimiter ;

call genre_viewer("Action");

#3. Write a query to check the number of movies released in each movie category.
#Convert the query into a stored procedure to filter only those categories that have movies released greater than a certain number.
#Pass that number as an argument in the stored procedure.

drop procedure if exists numb_movies_per_category;

delimiter $$
create procedure numb_movies_per_category(
	in movienumber int)
begin
select c.name, count(film_id) as 'Number of movies'
from film_category fc
join category c
using (category_id)
group by c.name
having count(film_id) >= movienumber;
end$$
delimiter ;

call numb_movies_per_category(70);
