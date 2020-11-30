use sakila;

#1. How many distinct (different) actors' last names are there?
select count(distinct last_name)
from actor;

#2. In how many different languages where the films originally produced?
#(Use the column language_id from the film table)

select count(distinct language_id)
from film;

#3. How many movies were released with "PG-13" rating?

select count(rating) as '# of PG-13'
from film
where rating = 'PG-13';

#4. Get 10 the longest movies from 2006.

select *
from film
where release_year = 2006
order by length desc
limit 10;

select * from film;

#5. How many days has been the company operating (check DATEDIFF() function)?
select datediff(max(return_date), min(rental_date)) as 'operationperiod'
from rental;

#6. Show rental info with additional columns month and weekday. Get 20.
select *, date_format(rental_date, '%M') as 'month', date_format(rental_date, '%d') as 'weekday'
from rental;

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

#7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select case 
when DATENAME(dw, rental_date) = 'Saturday' or datename(dw, rental_date) = 'Sunday' then 'weekend'
else 'workday'
end as 'daytype'
from rental;

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

#8. How many rentals were in the last month of activity?

select count(rental_id)
from rental
where (rental_date = max(date_format(rental_date, '%m'))) and (rental_date = max(date_format(rental_date, '%Y')));