# 🗂️ SQL Joins Practice

## 📘 Overview
This repository contains SQL practice queries demonstrating the use of different **types of joins** — `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN` — using three relational tables:
- **Customer**
- **Products**
- **Purchase_History**

The purpose is to understand how joins work in relational databases, how NULL values behave in each case, and how to combine information from multiple tables to create meaningful datasets.

---

## 🧠 Learning Objectives
- Understand different join types in SQL
- Explore one-to-many and many-to-many relationships
- Retrieve complete or partial data using joins
- Practice MySQL syntax and relationships between tables

---

## 🧾 Database Tables

### 🧍 **Customer**
| Column | Description |
|--------|--------------|
| customer_id | Unique ID of each customer |
| first_name | Customer’s first name |
| last_name | Customer’s last name |
| email | Contact email |

### 📦 **Products**
| Column | Description |
|--------|--------------|
| product_id | Unique ID of each product |
| product_name | Name of the product |
| price_per_unit | Price per product |

### 🧾 **Purchase_History**
| Column | Description |
|--------|--------------|
| purchase_id | Unique ID for each purchase |
| customer_id | ID of the customer who made the purchase |
| product_id | ID of the product purchased |
| quantity | Quantity purchased |
| total_amount | Total purchase amount |
| purchase_date | Date of the purchase |

---

## 🔍 Types of Joins with Venn Diagrams

### 1️⃣ **INNER JOIN**
Retrieves only the records that have matching values in both tables.

**Query**
```sql
SELECT c.first_name, c.last_name, p.product_name
FROM customer c
INNER JOIN purchase_history ph
    ON c.customer_id = ph.customer_id
INNER JOIN products p
    ON ph.product_id = p.product_id;
