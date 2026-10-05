---Category-wise Revenue---
SELECT
    product_category,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC;

---Product-wise Revenue---
SELECT
    product_name,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC;

---Category KPI---
SELECT
    product_category,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC;

---Top 10 Products---
SELECT
    product_name,
    SUM(revenue) AS total_revenue,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;

---Product Category Contribution %---
SELECT
    product_category,
    SUM(revenue) AS category_revenue,
    ROUND(
        100.0 * SUM(revenue)
        / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_contribution_pct
FROM sales
GROUP BY product_category
ORDER BY category_revenue DESC;

---Category × Order Status---
SELECT
    product_category,
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY product_category, order_status
ORDER BY product_category, total_orders DESC;