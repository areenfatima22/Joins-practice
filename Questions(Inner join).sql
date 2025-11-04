# PRACTICAL QUESTIONS USING INNER JOIN

# 1. Write a query to get frst_name, last_name and email of all customers who made at least 1 purchase
select distinct c.first_name,c.last_name,c.email,ph.quantity
from employee.customer c
inner join employee.purchase_history ph
on c.customer_id=ph.customer_id;

# 2.List the product_name and price_per_unit for products that has been purchased by 1 customer.
select distinct p.product_name,p.price_per_unit,ph.customer_id
from user_records.products p
inner join employee.purchase_history ph
on p.product_id=ph.product_id;

# 3.Find the first name last_name and purchase_date for customers who made a purchase
select c.first_name,c.last_name,ph.purchase_date
from employee.customer c
inner join employee.purchase_history ph
on c.customer_id = ph.customer_id;

# 4. Write a query to list the first_name,last_name and product_name fro customers who bought more than 3 units of product in single purchase.
select c.first_name,c.last_name,p.product_name,ph.quantity
from employee.customer c
inner join employee.purchase_history ph
on c.customer_id = ph.customer_id
inner join user_records.products p
on ph.product_id = p.product_id
where ph.quantity > 3;

# 5 Retrive the first_name,last_name,product_name and total-amount of all customers who spent > 500 on single purchase.
select c.first_name,c.last_name,p.product_name,
       sum(ph.total_amount) as total_spent
from employee.customer c
inner join employee.purchase_history ph
   on c.customer_id = ph.customer_id
inner join user_records.products p
   on ph.product_id = p.product_id
group by c.first_name, c.last_name, p.product_name
having sum(ph.total_amount) > 500;


# 6.Write a query to find the total no. of products bought by each customer and total amount spent on all purchases.
select c.first_name,c.last_name,c.customer_id,
       sum(ph.quantity) as total_products_bought,
	   sum(ph.total_amount) as total_spent
from employee.customer c
inner join employee.purchase_history ph
    on ph.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name;


# 7. Write the query to list the customers who purchased the higher priced products and total amount they spent.
select c.first_name,c.last_name,p.product_name,p.price_per_unit,
       sum(ph.total_amount) as total_spent
from employee.customer c
inner join employee.purchase_history ph
    on c.customer_id = ph.customer_id
inner join user_records.products p
    on ph.product_id = p.product_id
where p.price_per_unit = (select MAX(price_per_unit) from user_records.products)
group by c.customer_id, c.first_name, c.last_name, p.product_name, p.price_per_unit;


# 8. Write a query that shows customer_id, product_name and the quantity purchased for each customer more than one product.alter

select c.customer_id,c.first_name,c.last_name,p.product_name,ph.quantity
from employee.customer c
inner join employee.purchase_history ph
    on c.customer_id = ph.customer_id
inner join user_records.products p
    on ph.product_id = p.product_id
where c.customer_id in (
    select customer_id
    from employee.purchase_history
    group by customer_id
    having count(distinct product_id) > 1
);

    
# 9.List the total spending per customer and the most expensive product using inner join
select c.first_name,c.last_name,
    sum(ph.total_amount) as total_spent,
    max(p.price_per_unit) as most_expensive_product
from employee.customer c
inner join employee.purchase_history ph
    on c.customer_id = ph.customer_id
inner join user_records.products p
    on ph.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name;


# 10. Write a query to find customers who have purchased both from the "meat' and 'Dairy'
select c.first_name,c.last_name
from employee.customer c
where c.customer_id in (select ph1.customer_id
    from employee.purchase_history ph1
    inner join user_records.products p1
        on ph1.product_id = p1.product_id
    where p1.category = 'Meat'
)
and c.customer_id in (
    select ph2.customer_id
    from employee.purchase_history ph2
    inner join user_records.products p2
        on ph2.product_id = p2.product_id
    where p2.category = 'Dairy'
);

