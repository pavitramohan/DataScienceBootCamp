use sakila;

-- 1A
select first_name, last_name from actor;

-- 1b
select concat((first_name), ' ' , upper(last_name)) as full_name from actor;

-- 2a
select actor_id, first_name, last_name from actor where actor_id = (select actor_id from actor where first_name = 'Joe');

-- 2b
select actor_id, first_name, last_name from actor where actor_id in (select actor_id from actor where last_name like '%GEN%');

-- 2c
select actor_id, first_name, last_name from actor where actor_id in (select actor_id from actor where last_name like '%LI%') order by last_name, first_namecountry;

-- 2d
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
alter table actor add column description blob;

-- 3b 
alter table actor drop column description;

-- 4a
select last_name , count(*) from actor group by last_name;

-- 4b
select last_name , count(*) from actor group by last_name having count(*) > 1;

-- 4c
update actor set first_name = 'HARPO' where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

-- 4d
update actor set first_name = 'GROUCHO' where first_name = 'HARPO' and last_name = 'WILLIAMaddressS';

-- 5a
SHOW CREATE TABLE address;

-- 6a
Select first_name, last_name, address from staff s inner join address a on a.address_id = s.address_id;

-- 6b
Select first_name, last_name, address from staff s inner join payment p on p.address_id = s.address_id;

-- 6c
select title , count(fa.actor_id) from film_actor fa inner join film fl  on fa.film_id = fl.film_id group by title ;

-- 6d
 select count(inventory_id) from inventory where film_id = ( select film_id from film where
                           title = 'Hunchback Impossible');
                           
-- 6e
select first_name, last_name, sum(amount) from 
           payment p inner join customer c on p.customer_id = c.customer_id group by last_name, first_name;
           
-- 7a
select title from film where (title like 'K%' or title like 'Q%' ) and language_id = 
          (select language_id from language where name = 'English');
-- 7b
select * from actor where actor_id in (select actor_id from film_actor where film_id in 
                     (select film_id from film where title = 'Alone Trip'));
                     
-- 7c
select first_name, last_name, email from customer where address_id in (select address_id from address where
                city_id in (select city_id from city where country_id in (select country_id from country
                           where country = 'Canada')));
                           
-- 7d
select * from film where rating = 'G';

-- 7e
select  f.film_id , f.title,  count(*) from rental r inner join inventory i inner join film f 
             on r.inventory_id = i.inventory_id and i.film_id = f.film_id
                    group by film_id order by count(*) desc;

-- 7f
select store_id, count(*)  from store s inner join payment p on s.manager_staff_id = p.staff_id group by store_id;

-- 7g
select s.store_id, city, country from store s inner join address a inner join city c
                              inner join country cn on s.address_id = a.address_id and a.city_id = c.city_id
                               and c.country_id = cn.country_id;
                               
-- 7h
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- 8a 
create view TopFiveGenres as 
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- 8b
select * from TopFiveGenres;

-- 8c
drop view TopFiveGenres;