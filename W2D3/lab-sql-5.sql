use sakila;

#Lab 5

#1. Drop column picture from staff.

alter table staff drop column picture;

#2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer.
#Update the database accordingly.

select * from customer where first_name = 'tammy';

select * from staff;

delete from staff where first_name = 'tammy';

insert into staff values (
3,
(select first_name from customer where first_name = 'tammy' and last_name = 'sanders'),
(select last_name from customer where first_name = 'tammy' and last_name = 'sanders'),
(select address_id from customer where first_name = 'tammy' and last_name = 'sanders'),
(select email from customer where first_name = 'tammy' and last_name = 'sanders'),
2,
1,
(select first_name from customer where first_name = 'tammy' and last_name = 'sanders'), 
'',
(current_timestamp));

select * from staff;

#3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1 today.

select * from rental;

#Look up values in other tables
#rental_id
select rental_id from rental order by rental_id desc limit 1;

#inventory_id
select film_id from film where title = 'Academy Dinosaur';

select * from inventory where film_id = 1;
select inventory_id from inventory where ((film_id = (select film_id from film where title = 'Academy Dinosaur'))
and (store_id = (select store_id from staff where first_name = 'mike' and last_name = 'hillyer'))) limit 1;

select * from customer where first_name = 'charlotte' and last_name = 'hunter';

select staff_id from staff where first_name = 'mike' and last_name = 'hillyer';

insert into rental (rental_id, rental_date, inventory_id, customer_id, staff_id) values (
16050,
current_timestamp,
1,
130,
1);

select * from rental
order by rental_id desc
limit 10;

#insert into rental values (
#(select (max(rental_id) + 1) from rental),
#current_timestamp,
#(select inventory_id from inventory where ((film_id = (select film_id from film where title = 'Academy Dinosaur'))
#and (store_id = (select store_id from staff where first_name = 'mike' and last_name = 'hillyer'))) limit 1),
#(select customer_id from customer where first_name = 'charlotte' and last_name = 'hunter'),
#(current_timestamp + 3),
#(select staff_id from staff where first_name = 'mike' and last_name = 'hillyer'),
#current_timestamp,
#Null);

#3. Delete non-active users, but first, create a backup table deleted_users to store customer_id,
#email, and the date the user was deleted.

DROP TABLE IF EXISTS custback1;

CREATE TABLE custback1 (
select * from customer);

DROP TABLE IF EXISTS custback2;

CREATE TABLE custback2 (
select * from customer);

delete from custback2 where active = 1;

alter table custback2 drop column; 