---Customer Revenue---
SELECT
    customer_id,
    customer_name,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC;

---Customer Orders & Spending---
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(revenue) AS total_revenue,
    SUM(quantity) AS total_units
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC;

---Top 10 Customers---
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC
LIMIT 10;

---Repeat vs One-Time Customers---
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM sales
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type
ORDER BY customer_count DESC;

---Customer Revenue Ranking---
SELECT
    customer_id,
    customer_name,
    SUM(revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS customer_rank
FROM sales
GROUP BY customer_id, customer_name
ORDER BY customer_rank;

---Customer Value Segmentation---
WITH customer_revenue AS (
    SELECT
        customer_id,
        customer_name,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY customer_id, customer_name
)

SELECT
    customer_id,
    customer_name,
    total_revenue,
    CASE
        WHEN total_revenue >= 50000 THEN 'High Value'
        WHEN total_revenue >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_revenue
ORDER BY total_revenue DESC;