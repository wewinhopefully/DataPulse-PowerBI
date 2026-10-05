---Basic regional revenue---
SELECT
    region,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

---Orders by region---
SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY region
ORDER BY total_orders DESC;

---Customers by region---
SELECT
    region,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales
GROUP BY region
ORDER BY total_customers DESC;

---Units sold by region---
SELECT
    region,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY region
ORDER BY total_units_sold DESC;

---Regional KPI table---
SELECT
    region,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

---Revenue contribution %---
SELECT
    region,
    SUM(revenue) AS regional_revenue,
    ROUND(
        100.0 * SUM(revenue)
        / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_contribution_pct
FROM sales
GROUP BY region
ORDER BY regional_revenue DESC;

---Regional Order Status---
SELECT
    region,
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY region, order_status
ORDER BY region, total_orders DESC;