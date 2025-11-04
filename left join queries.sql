# Questions of LEFT JOIN and RIGHT JOIN

# 1.Write a query to list all customers and their purchase details (if available).
select c.*, ph.*
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id;


# 2.List all products and the quantity purchased by each customer, even if no purchases have been made.
select c.customer_id,c.first_name,c.last_name,p.product_name,ph.quantity
from employee.customer as c
left join employee.purchase_history as ph
    on c.customer_id = ph.customer_id
right join user_records.products as p
    on ph.product_id = p.product_id
order by c.customer_id, p.product_name;



# 3.Write a query to find all customers who haven't made any purchases.
select c.customer_id,c.first_name,c.last_name
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id
where ph.purchase_id is null;


# 4.List all customers and the total amount they spent on purchases, including those who made no purchases.
select c.customer_id,c.first_name,c.last_name,
       sum(ph.total_amount) as total_spent
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id
group by c.customer_id, c.first_name, c.last_name;


# 5.Write a query to find products that have not been purchased.
select p.product_id,p.product_name,p.category
from user_records.products p
left join employee.purchase_history ph
    on p.product_id = ph.product_id
where ph.purchase_id is null;



# 7.Write a query to find customers who purchased products.
select c.customer_id,c.first_name,c.last_name
from employee.customer c
inner join employee.purchase_history ph
    on c.customer_id = ph.customer_id
inner join user_records.products p
    on ph.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name;


# 8.List all customers who have made purchases and the corresponding product details, but include those who haven't purchased anything.
select c.customer_id,c.first_name,c.last_name,p.product_name,ph.quantity,ph.total_amount
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id
left join user_records.products p
    on ph.product_id = p.product_id
order by c.customer_id;

# RIGHT JOIN QUESTONS

# 1.Write a query to list all products and their purchase details (if available).
select p.product_id, p.product_name, ph.purchase_id, ph.customer_id, ph.quantity, ph.total_amount
from user_records.products p
left join employee.purchase_history ph
    on p.product_id = ph.product_id;


# 2.Find all purchases and their corresponding customer details, even if the customer has not been linked to a purchase.
select ph.purchase_id, ph.customer_id, ph.product_id, c.first_name, c.last_name
from employee.customer c
right join employee.purchase_history ph
    on c.customer_id = ph.customer_id;


# 3. List all customers and the product names of their purchases, even if some purchases don’t have corresponding customer data.
-- Customers with their purchased products
select c.first_name, c.last_name, p.product_name
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id
left join user_records.products p
    on ph.product_id = p.product_id

union

-- Products that exist even if no one bought them
select c.first_name, c.last_name, p.product_name
from employee.customer c
right join employee.purchase_history ph
    on c.customer_id = ph.customer_id
right join user_records.products p
    on ph.product_id = p.product_id;



# 4. Write a query to list all products purchased by customers, even if some purchases don’t have customer data.
select p.product_name, ph.purchase_id, ph.customer_id
from user_records.products p
left join employee.purchase_history ph
    on p.product_id = ph.product_id;


# 5. Write a query to list all products that have been purchased by customers, and include products that have not been purchased.
select p.product_name, c.first_name, c.last_name, ph.purchase_id
from user_records.products p
left join employee.purchase_history ph
    on p.product_id = ph.product_id
left join employee.customer c
    on ph.customer_id = c.customer_id;


# 6. List the customer details and product names for customers who have purchased a product but do not have corresponding records in the products table.
select c.first_name, c.last_name, ph.product_id
from employee.customer c
left join employee.purchase_history ph
    on c.customer_id = ph.customer_id
left join user_records.products p
    on ph.product_id = p.product_id
where p.product_id is null;
