use sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select film_id from film where title = "Hunchback Impossible" ;

select count(inventory_id), film_id from inventory 
where film_id = (select film_id from film where title = "Hunchback Impossible"); -- Q1

-- List all films whose length is longer than the average of all the films.
select avg(length) from film;

select film_id, length from film where length > (select avg(length) from film); -- Q2

-- Use subqueries to display all actors who appear in the film Alone Trip.
select film_id from film where title = "Alone Trip";

select actor_id, film_id, first_name, last_Name from film_actor 
join actor using(actor_id)
where film_id = (select film_id from film where title = "Alone Trip");  -- Q3

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select category_id from category where name = "Family";

select title, film_id, category_id from film
join film_category using (film_id) 
where category_id = (select category_id from category where name = "Family"); -- Q4

-- Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.

select first_name, last_name, email, country from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country = "Canada"; -- using join Q5

select country_id from country where country = "Canada";

select first_name, last_name, email, country from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country_id = (select country_id from country where country = "Canada"); -- using subquery Q5

-- Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select actor_id, count(film_id) from film_actor group by actor_id order by count(film_id) desc limit 1;

select film_id, title, actor_id from film 
join film_actor using(film_id)
where actor_id = (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1); -- Q6

-- Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the 
-- largest sum of payments

select customer_id, sum(amount) from payment group by customer_id order by sum(amount) desc limit 1;

select film_id, title, p.customer_id from film
join inventory using(film_id)
join rental using (inventory_id)
join payment p using (rental_id) 
where p.customer_id = (select customer_id from payment group by customer_id order by sum(amount) desc limit 1); -- Q7

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount 
-- spent by each client.

select avg(amount) from payment;

select customer_id, sum(amount) from payment 
where amount > (select avg(amount) from payment ) group by customer_id;-- Q8


