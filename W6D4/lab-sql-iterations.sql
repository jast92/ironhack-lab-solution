use sakila;

#1. Write a query to find what is the total business done by each store.

select sto.store_id, sum(p.amount) as TotalBusiness
from store sto
join staff sta
on sto.manager_staff_id = sta.staff_id 
join payment p
on sta.staff_id = p.staff_id 
group by sto.store_id;

#2. Convert the previous query into a stored procedure.

drop procedure if exists proc_totalbusiness;

delimiter $$
create procedure proc_totalbusiness()
begin
	select sto.store_id, sum(p.amount) as TotalBusiness
	from store sto
	join staff sta
	on sto.manager_staff_id = sta.staff_id 
	join payment p
	on sta.staff_id = p.staff_id 
	group by sto.store_id;
end $$
delimiter ;

call proc_totalbusiness();

#3. Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

drop procedure if exists proc_businessperstore;

delimiter $$
create procedure proc_businessperstore(
in storeid int)
begin
	select sto.store_id, sum(p.amount) as TotalBusiness
	from store sto
	join staff sta
	on sto.manager_staff_id = sta.staff_id 
	join payment p
	on sta.staff_id = p.staff_id
    where sto.store_id = storeid;
end $$
delimiter ;

call proc_businessperstore(2);

#4. Update the previous query. Declare a variable total_sales_value of float type,
#that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.

drop procedure if exists proc_businessperstore_float;

delimiter $$
create procedure proc_businessperstore_float(
in storeid int,
out total_sales_value float)
begin
	select sum(p.amount) into total_sales_value
	from store sto
	join staff sta
	on sto.manager_staff_id = sta.staff_id 
	join payment p
	on sta.staff_id = p.staff_id
    where sto.store_id = storeid;
end $$
delimiter ;

call proc_businessperstore_float(2, @total_sales_value);
select round(@total_sales_value, 2) as 'Total Sales Value Store 2';

#4. In the previous query, add another variable flag.
#If the total sales value for the store is over 30.000, then label it as green_flag,
#otherwise label is as red_flag. Update the stored procedure
#that takes an input as the store_id and returns total sales value for that store and flag value.

drop procedure if exists proc_businessperstore_flag;

delimiter $$
create procedure proc_businessperstore_flag(
in storeid int,
out total_sales_value float,
out flag varchar(25))
begin
	select sum(p.amount) into total_sales_value
	from store sto
	join staff sta
	on sto.manager_staff_id = sta.staff_id 
	join payment p
	on sta.staff_id = p.staff_id
    where sto.store_id = storeid;
    
	select case
    when sum(p.amount) > 30000 then set flag = "green flag"
    else set flag = "red flag"
    end 
	from store sto
	join staff sta
	on sto.manager_staff_id = sta.staff_id 
	join payment p
	on sta.staff_id = p.staff_id
    where sto.store_id = storeid;

end $$
delimiter ;

call proc_businessperstore_flag(2, @total_sales_value, @flag);
select round(@total_sales_value, 2) as 'Total Sales Value Store 2', @flag as "Status of Total Sales";
