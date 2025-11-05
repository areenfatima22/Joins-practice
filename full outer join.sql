#  Questions (FULL OUTER JOIN)


# 1.Write a query to list all customers and all products, even if no purchase exists.
SELECT c.first_name, c.last_name, p.product_name
FROM customer c
LEFT JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
LEFT JOIN products p
    ON ph.product_id = p.product_id

UNION

SELECT c.first_name, c.last_name, p.product_name
FROM customer c
RIGHT JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
RIGHT JOIN products p
    ON ph.product_id = p.product_id;


# 2.List all products and customers, including those who haven’t made a purchase or been linked to a product.
SELECT c.first_name, c.last_name, p.product_name
FROM customer c
LEFT JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
LEFT JOIN products p
    ON ph.product_id = p.product_id

UNION

SELECT c.first_name, c.last_name, p.product_name
FROM customer c
RIGHT JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
RIGHT JOIN products p
    ON ph.product_id = p.product_id;


# 3.Find all customers and products where no purchase has occurred, including customers who have never made a purchase.
SELECT c.first_name, c.last_name, p.product_name
FROM customer c
FULL OUTER JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
FULL OUTER JOIN products p
    ON ph.product_id = p.product_id;


# 4.Write a query that shows all customers and their corresponding purchases, as well as products that no one has purchased, using FULL OUTER JOIN.
SELECT p.product_name, ph.purchase_id, ph.customer_id
FROM products p
LEFT JOIN purchase_history ph
    ON p.product_id = ph.product_id;


# 5. How can a FULL OUTER JOIN help in identifying data discrepancies in tables?
SELECT p.product_name, c.first_name, c.last_name, ph.purchase_id
FROM products p
LEFT JOIN purchase_history ph
    ON p.product_id = ph.product_id
LEFT JOIN customer c
    ON ph.customer_id = c.customer_id;


# 6. Write a query to list all customers and products where no purchase has occurred, even if some customers have no purchase records.
SELECT c.customer_id, c.first_name, c.last_name, p.product_name
FROM employee.customer c
LEFT JOIN employee.purchase_history ph
    ON c.customer_id = ph.customer_id
LEFT JOIN user_records.products p
    ON ph.product_id = p.product_id
WHERE ph.purchase_id IS NULL

UNION

SELECT c.customer_id, c.first_name, c.last_name, p.product_name
FROM employee.customer c
RIGHT JOIN employee.purchase_history ph
    ON c.customer_id = ph.customer_id
RIGHT JOIN user_records.products p
    ON ph.product_id = p.product_id
WHERE ph.purchase_id IS Null;


# 7.Write a query to list the total purchase amount per customer, showing all customers and products, even if no purchase has occurred.
SELECT c.customer_id, c.first_name, c.last_name,
       COALESCE(SUM(ph.total_amount), 0) AS total_spent
FROM employee.customer c
LEFT JOIN employee.purchase_history ph
    ON c.customer_id = ph.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;



# 8.Can you use FULL OUTER JOIN to detect customers who bought products but have never been recorded in the products table?
SELECT c.customer_id, c.first_name, c.last_name, ph.product_id
FROM employee.customer c
FULL OUTER JOIN employee.purchase_history ph
    ON c.customer_id = ph.customer_id
FULL OUTER JOIN user_records.products p
    ON ph.product_id = p.product_id
WHERE p.product_id IS NULL AND ph.product_id IS NOT NULL;



# 10.How would you use a FULL OUTER JOIN to combine the purchases and products tables and include all records from both tables?
SELECT ph.purchase_id, ph.customer_id, p.product_id, p.product_name, ph.total_amount
FROM employee.purchase_history ph
LEFT JOIN user_records.products p
    ON ph.product_id = p.product_id

UNION

SELECT ph.purchase_id, ph.customer_id, p.product_id, p.product_name, ph.total_amount
FROM employee.purchase_history ph
RIGHT JOIN user_records.products p
    ON ph.product_id = p.product_id;
