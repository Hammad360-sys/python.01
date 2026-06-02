--   ASSIGNMENT 03 — GROUP BY, HAVING & SUBQUERIES
--   Database  : BikeStores
--   Topics    : GROUP BY · Aggregate Functions · HAVING
--               Subqueries · JOINs with GROUP BY

-- QUESTION ;1

SELECT
	customer_id,
	count(order_id) as order_count
from 
	sales.orders
GROUP by
	customer_id
ORDER by
	order_count DESC;


-- QUESTION ;2

SELECT
	store_id,
	count(order_id) as total_orders
from
	sales.orders
group by
	store_id

-- QUESTION ;3

-- -- Net revenue formula: SUM( quantity * list_price * (1 - discount) )

SELECT
    order_id,
    SUM(quantity * list_price * (1 - discount)) AS net_revenue
FROM sales.order_items
GROUP BY order_id
ORDER BY net_revenue DESC;

-- QUESTION ;4

-- (rounded to 2 decimal places).
-- (Hint: use ROUND())

select
	category_id,
	ROUND(AVG(list_price), 2) AS avg_price
from
	production.products
group by
	category_id

-- QUESTION ;5

SELECT
    YEAR(order_date) AS order_year,
    COUNT(order_id) AS total_orders
FROM sales.orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- QUESTION ;6

--SELECT
--	CUSTOMER_ID,
--	COUNT(ORDER_ID) AS ORDER_COUNT
--FROM
--	SALES.ORDERS
--GROUP BY
--	CUSTOMER_ID
--HAVING
--	COUNT(CUSTOMER_ID) >5
-- there is no customers who have placed MORE than 5 orders in total



SELECT
    customer_id,
    COUNT(order_id) AS order_count
FROM sales.orders
GROUP BY customer_id
ORDER BY order_count DESC;

SELECT
    customer_id,
    COUNT(order_id) AS order_count
FROM sales.orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2;


-- QUESTION ;7

SELECT
    category_id,
    ROUND(AVG(list_price), 2) AS avg_price
FROM production.products
GROUP BY category_id
HAVING AVG(list_price) > 1500;

-- QUESTION 8

SELECT
    customer_id,
    YEAR(order_date) AS order_year,
    COUNT(order_id) AS order_count
FROM sales.orders
WHERE YEAR(order_date) = 2017
GROUP BY customer_id, YEAR(order_date)
HAVING COUNT(order_id) >= 2;

--question 9

SELECT *
FROM sales.orders
WHERE customer_id IN (
    SELECT customer_id
    FROM sales.customers
    WHERE city = 'Houston'
);

-- question 10

SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price > (
    SELECT AVG(list_price)
    FROM production.products
);

-- QUESTION ;11

SELECT
    product_name,
    list_price
FROM production.products
WHERE category_id IN (
    SELECT category_id
    FROM production.categories
    WHERE category_name IN ('Mountain Bikes', 'Road Bikes')
);

-- QUESTION ;12

--SELECT
--    customer_id,
--    first_name,
--    last_name
--FROM sales.customers
--WHERE customer_id NOT IN (
--    SELECT customer_id
--    FROM sales.orders
--);
-- its dost's work

-- QUESTION ;13

SELECT
    c.city,
    COUNT(o.order_id) AS total_orders
FROM sales.orders o
INNER JOIN sales.customers c
    ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

--QUESTION ;14

SELECT
    s.first_name + ' ' + s.last_name AS staff_name,
    COUNT(o.order_id) AS order_count
FROM sales.staffs s
INNER JOIN sales.orders o
    ON s.staff_id = o.staff_id
GROUP BY s.first_name, s.last_name
ORDER BY order_count DESC;

-- QUESTION ;15

SELECT
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
FROM sales.customers c
INNER JOIN sales.orders o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount)) > 10000
ORDER BY total_spent DESC;