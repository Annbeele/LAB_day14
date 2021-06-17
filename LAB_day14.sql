#1. Use the RANK() and the table of your choice: rank films by length (filter
# out the rows that have nulls or 0s in length column). In your output, only select
# the columns title, length, and the rank.
select * from film;

#select title, length, dense_rank() over (partition by length is not null and length <> 0 order by length desc) as ranking
#from film;


select title, length, dense_rank() over (order by length desc) as ranking
from film
where length is not null and length <>0;

#2. Build on top of the previous query and rank films by length within the rating category (filter out
#the rows that have nulls or 0s in length column). In your output, only select the columns title, length,
#rating and the rank.

select title, length, rating, dense_rank() over (partition by rating order by length desc) as ranking
from film
where length is not null and length <>0;


#3. How many films are there for each of the categories? Inspect the database
#structure and use appropriate join to write this query.
select * from film_category;
select * from category;

select c.name, count(fc.category_id) as num_films
from category c
join film_category fc
on c.category_id = fc.category_id
group by c.name;

#4. Which actor has appeared in the most films?
select * from film_actor;
select * from actor;

#select a.first_name, a.last_name as most_appearing_actor, dense_rank() over (partition by count(a.actor_id) order by a.actor_id desc) as ranking
#from actor a
#join film_actor fa
#on a.actor_id = fa.actor_id;


select a.first_name, a.last_name as most_appearing_actor, count(a.actor_id) as appearances
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
group by a.actor_id
order by appearances desc
limit 1;



#5. Most active customer (the customer that has rented the most number of films)

select c.first_name, c.last_name as most_active_costumer, count(r.customer_id) as num_rentals
from rental r
join customer c
on c.customer_id = r.customer_id
group by c.customer_id
order by num_rentals desc
limit 1;

#Bonus: Which is the most rented film? The answer is Bucket Brotherhood.
#This query might require using more than one join statement. Give it a try.
#We will talk about queries with multiple join statements later in the lessons.

SELECT f.title as title, count(f.film_id) as num_rentals
FROM rental r
join inventory i
on i.inventory_id = r.inventory_id
join film f
on f.film_id = i.film_id
group by f.film_id
order by num_rentals DESC
limit 1;
