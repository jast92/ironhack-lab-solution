use sakila;
select * from rentals_may;

#1.Create a table rentals_may to store the data from rental table with information for the month of May.
#2.Insert values in the table rentals_may using the table rental, filtering values only for the month of May.

create table rentals_may as
select * from rental where date_format(rental_date, "%m") = 5;

#3. Create a table rentals_june to store the data from rental table with information for the month of June.
#4. Insert values in the table rentals_june using the table rental, filtering values only for the month of June.

create table rentals_june as
select * from rental where date_format(rental_date, "%m") = 6;

#How many rentals were done in the respective months?
SELECT 'Rentals May' AS rentals, COUNT(rental_id) as numberrentals FROM rentals_may
UNION SELECT 'Rentals June', COUNT(rental_id) FROM rentals_june;

#5. Check the number of rentals for each customer for May.

select customer_id, count(rental_id) as 'rentals'
from rentals_may
group by customer_id
order by count(rental_id) desc;

#6. Check the number of rentals for each customer for June.

select customer_id, count(rental_id) as 'rentals'
from rentals_june
group by customer_id
order by count(rental_id) desc;



