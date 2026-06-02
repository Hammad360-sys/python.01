-- FIRST Q: A

select
	p.product_name,
	p.list_price,
	c.category_name
from 
	production.products p
inner join
	production.categories c
on p.category_id = c.category_id

-- 2 question

select
	c.first_name + '  ' + last_name AS full_name,
	o.order_id,
	o.order_date
from
	sales.customers c
INNER JOIN
	sales.orders o
on c.customer_id = o.customer_id;

-- 3 QUESTION

SELECT
    p.product_name,
    p.list_price,
    c.category_name,
    b.brand_name
FROM production.products p
INNER JOIN production.categories c
    ON p.category_id = c.category_id
INNER JOIN production.brands b
    ON p.brand_id = b.brand_id
ORDER BY
    b.brand_name ASC,
    p.product_name ASC;



4 QUESTION;

select
	p.product_name,
	oi.order_id,
	oi.item_id
FROM
	production.products p
LEFT JOIN
	sales.order_items oi
	ON p.product_id = oi.product_id
ORDER BY
	oi.order_id ASC;	
	

5:QUESTION ;

select
    p.product_id,
    p.product_name
FROM production.products p
LEFT JOIN sales.order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

6: QUESTION
\
SELECT
    s.store_name,
    s.store_id,
    o.order_id,
    o.order_date
FROM sales.stores s
LEFT JOIN sales.orders o
    ON s.store_id = o.store_id;

7 :QUESTION

--select
-- find first and lastname as fullname to the sales_id
	select
    s.first_name + ' ' + s.last_name AS staff_name,
    m.first_name + ' ' + m.last_name AS manager_name
FROM sales.staffs s
INNER JOIN sales.staffs m
    ON s.manager_id = m.staff_id;

8: QUESTION

SELECT
    s.store_name,
    b.brand_name
FROM sales.stores s
CROSS JOIN production.brands b;

-- Expected rows = (Number of Stores) × (Number of Brands)
-- In the BikeStores sample database:
-- 3 Stores × 9 Brands = 27 rows

9: QUESTION

--SELECT 
-- O.ORDER_ID
--    P.PRODUCT_NAME
--    FROM sales.customers c
--INNER JOIN sales.orders o

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.order_id,
    o.order_date,
    p.product_name,
    p.list_price
FROM sales.customers c
INNER JOIN sales.orders o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
INNER JOIN production.products p
    ON oi.product_id = p.product_id
ORDER BY
    o.order_date ASC,
    full_name ASC;

-- ASWERS COMPLETES;;