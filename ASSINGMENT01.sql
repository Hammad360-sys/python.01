-- FIRST ASSINGMENT

-- Question 1 — SELECT & WHERE??

SELECT
	first_name,
	last_name,
	city,
	phone
from 
	sales.customers
where 
	state = 'CA'
AND 
	phone IS NOT NULL;
--COMPLETE


-- 2nd QUESTION;

SELECT
	product_id,
	product_name,
	list_price,
	model_year
FROM
	production.products
ORDER BY
	model_year DESC, list_price ASC;
---COMPLETE


-- QUESTION:3

SELECT TOP 5
	product_name,
	list_price
FROM 
	production.products
ORDER BY list_price DESC;

SELECT TOP 5 PERCENT *
FROM production.products
ORDER BY list_price ASC;
---COMPLETE

-- QUESTION; 4

SELECT *
FROM PRODUCTION.products
ORDER BY list_price DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-----part 2
SELECT *
FROM production.products
ORDER BY list_price DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;


----part 3
SELECT *
FROM PRODUCTION.products
ORDER BY list_price DESC
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;
---COMPLETE

--QUESTION:5

SELECT
	distinct state
FROM
	sales.customers
ORDER BY
	state ASC;

---------section:b
select
	distinct state,city
from
	sales.customers
ORDER BY
	state ASC, city ASC;

---section: c
select
	distinct model_year
from
	production.products
ORDER BY
	model_year;

------section:d
SELECT
	COUNT
		(DISTINCT model_year) AS unique_model_years
FROM
	production.products;
---COMPLETE

---QUESTION:6

SELECT 
	product_id, 
	product_name, 
	brand_id, 
	category_id, 
	list_price
FROM
	production.products
WHERE 
	list_price BETWEEN 500 AND 1500
  AND (model_year = 2019 OR model_year = 2020)
ORDER BY 
	list_price ASC;
AND 
	model_year IN (2019, 2020);

---------COMPLETE--------