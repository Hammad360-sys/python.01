--04 ASSINGMENT
-- staff members and customers. 
-- Build a unified list showing full name and email for all of them. 
-- Make sure no one is accidentally listed twice.

SELECT
    first_name + ' ' + last_name AS full_name,
    email
FROM sales.customers

UNION

SELECT
    first_name + ' ' + last_name AS full_name,
    email
FROM sales.staffs;


-- QUESTION 2

SELECT
    STATE
FROM
    sales.stores

INTERSECT

SELECT
    STATE
FROM SALES.customers;

--QUESTION 03

--SELECT
--    store_id
--from
--    sales.stores
--EXCEPT
--SELECT DISTINCT store_id
--FROM sales.orders
--WHERE YEAR(order_date) = 2018;

SELECT 
    s.store_id
FROM 
    sales.stores s
WHERE NOT EXISTS (
    SELECT 1
    FROM sales.orders o
    WHERE o.store_id = s.store_id
      AND o.order_date >= '2018-01-01' 
      AND o.order_date < '2019-01-01'
);

--SELECT 
--    s.store_id
--FROM 
--    sales.stores s
--LEFT JOIN 
--    sales.orders o 
--    ON s.store_id = o.store_id 
--    AND o.order_date >= '2018-01-01' 
--    AND o.order_date < '2019-01-01'
--WHERE 
--    o.store_id IS NULL;


--QUESTION 4

WITH CategoryAvg AS
(
    SELECT
        category_id,
        AVG(list_price) AS avg_price
    FROM production.products
    GROUP BY category_id
)
SELECT
    p.category_id,
    p.product_name,
    p.list_price,
    c.avg_price
FROM production.products p
JOIN CategoryAvg c
    ON p.category_id = c.category_id


--QUESTION 5

WITH StaffOrders AS
(
    SELECT
        staff_id,
        COUNT(*) AS order_count
    FROM sales.orders
    GROUP BY staff_id
)
SELECT
    staff_id,
    order_count
FROM StaffOrders
WHERE order_count >
(
    SELECT AVG(order_count)
    FROM StaffOrders
);

--QUESTION 6

WITH StoreRevenue AS
(
    SELECT
        o.store_id,
        YEAR(o.order_date) AS order_year,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
    FROM sales.orders o
    JOIN sales.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.store_id,
        YEAR(o.order_date)
)
SELECT
    store_id,
    order_year,
    total_revenue
FROM StoreRevenue
WHERE total_revenue > 1000000;


--QUESTION 7

CREATE TABLE sales.honar_score (
    card_number INT PRIMARY KEY,

    customer_id INT NOT NULL,

    points INT
        CHECK (points >= 0),

    tier VARCHAR(10)
        CHECK (tier IN ('Bronze', 'Silver', 'Gold')),

    join_date DATE NOT NULL,

    CONSTRAINT FK_loyalty_customer
        FOREIGN KEY (customer_id)
        REFERENCES sales.customers(customer_id)
        ON DELETE CASCADE
);
SELECT * from sales.honar_score

INSERT INTO sales.loyalty_cards
VALUES (1001, 1, 500, 'Gold', '2024-01-15');

INSERT INTO sales.loyalty_cards
VALUES (1002, 2, 150, 'Silver', '2024-03-22');

INSERT INTO sales.loyalty_cards
VALUES (1003, 3, 0, 'Bronze', '2024-06-01');

INSERT INTO sales.loyalty_cards
VALUES (1001, 4, 100, 'Gold', '2024-07-01');

INSERT INTO sales.loyalty_cards
VALUES (1004, 1, -50, 'Silver', '2024-08-01');

INSERT INTO sales.loyalty_cards
VALUES (1005, 5, 200, 'Diamond', '2024-09-01');

SELECT * from sales.loyalty_cards

--QUESTION 8

ALTER TABLE test_orders
ADD CONSTRAINT CHK_test_orders_dates
CHECK (
    shipped_date IS NULL
    OR shipped_date >= order_date
);

-- FAIL
INSERT INTO test_orders
VALUES (4, '2024-04-10', '2024-04-08');

-- PASS
INSERT INTO test_orders
VALUES (5, '2024-04-10', '2024-04-15');

--DONST EXISIT

--QUESTION 9

SELECT
    order_id,
    order_date,
    shipped_date,
    CASE
        WHEN shipped_date IS NULL THEN 'Pending'
        WHEN DATEDIFF(DAY, order_date, shipped_date) <= 2 THEN 'Fast'
        WHEN DATEDIFF(DAY, order_date, shipped_date) BETWEEN 3 AND 5 THEN 'Normal'
        ELSE 'Delayed'
    END AS shipping_speed
FROM sales.orders;

--QUESTION 10

SELECT
    store_id,
    product_id,
    quantity,
    CASE
        WHEN quantity = 0 THEN 'Out of Stock'
        WHEN quantity BETWEEN 1 AND 10 THEN 'Low Stock'
        WHEN quantity BETWEEN 11 AND 50 THEN 'Sufficient'
        ELSE 'Well Stocked'
    END AS stock_status
FROM production.stocks
ORDER BY
    store_id,
    quantity ASC;

--COMPLETE