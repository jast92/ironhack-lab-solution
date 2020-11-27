use sakila;

#1. Select the first name, last name, and email address of all the customers who have rented a movie.

select first_name, last_name, email
from customer
where customer_id in 
(select distinct customer_id from rental);

#2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select c.customer_id, concat(c.first_name, " ", c.last_name) as 'name', avg(p.amount)
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id;

#3. Select the name and email address of all the customers who have rented the "Action" movies.

#3.a) Write the query using multiple join statements.

select distinct concat(c.first_name, " ", c.last_name) as 'name', c.email
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category ca
on fc.category_id = ca.category_id
where ca.name = 'Action';

#3.b) Write the query using sub queries with multiple WHERE clause and IN condition

select distinct concat(first_name, " ", last_name) as 'name', email
from customer
where customer_id in
	(select customer_id from rental where inventory_id in
		(select inventory_id from inventory where film_id in
			(select film_id from film_category where category_id = 
				(select category_id from category where name = "Action"
                )
			)
		)
	)
 ;

#4. Use the case statement to create a new column classifying existing columns as either
#or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low
#and if the amount is between 2 and 4, the label should be medium,
#and if it is more than 4, then it should be high.

alter table payment
add transaction_type varchar(6) as (case 
                        when payment.amount < 2 then 'low'
                        when payment.amount between 2 and 4 then 'medium'
                        when payment.amount > 4 then 'high'
                     end);

select distinct transaction_type, amount from payment;

