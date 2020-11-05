select * from rental
order by rental_date desc;

#Lab | SQL Rolling calculations

#1. Get number of monthly active customers.

#Create a view with customer_id, Activity Date and extract Activity Month as well as Activity Year:

create or replace view cust_activity as
select customer_id,
convert(rental_date, date) as Activity_date,
date_format(convert(rental_date,date), '%m') as Activity_Month,
date_format(convert(rental_date,date), '%Y') as Activity_year
from sakila.rental;

select * from sakila.cust_activity;

#Get for each year and month, how many unique customers rented movies:

create or replace view Monthly_active_customers as
select Activity_year, Activity_Month, count(distinct customer_id) as Active_customers 
from cust_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

select * from sakila.Monthly_active_customers;

#Active users in the previous month.

with cte_activity as (
  select
  Activity_year,
  Activity_Month,
  Active_customers,
  lag(Active_customers,1) over (partition by Activity_year) as previous_month 
  from Monthly_active_customers
)
select * from cte_activity;

#3. Percentage change in the number of active customers.

create or replace view temptable1 as
with cte_activity as (
  select
  Activity_year,
  Activity_Month,
  Active_customers,
  lag(Active_customers,1) over (partition by Activity_year) as previous_month
  from Monthly_active_customers
) 
select * from cte_activity
where previous_month is not null;

select *,
round((((Active_customers - previous_month) / previous_month) *100), 2) as percchange from temptable1;

#4. Retained customers every month.

-- Get which "Active customers" where still active the next month.
with distinct_customers as (
  select distinct customer_id , Activity_Month, Activity_year
  from cust_activity
)
select d1.Activity_year, d1.Activity_Month, count(distinct d1.customer_id) as Retained_customers
from distinct_customers d1
join distinct_customers d2
on d1.customer_id = d2.customer_id and d1.activity_Month = d2.activity_Month + 1
group by d1.Activity_Month, d1.Activity_year
order by d1.Activity_year, d1.Activity_Month;

-- We get a view of the previous query.

create or replace view retained_customers_view as
with distinct_customers as (
  select distinct customer_id , Activity_Month, Activity_year
  from cust_activity
)
select d1.Activity_year, d1.Activity_Month, count(distinct d1.customer_id) as Retained_customers
from distinct_customers d1
join distinct_customers d2 on d1.customer_id = d2.customer_id
and d1.activity_Month = d2.activity_Month + 1
group by d1.Activity_Month, d1.Activity_year
order by d1.Activity_year, d1.Activity_Month;

select * from sakila.retained_customers_view;

