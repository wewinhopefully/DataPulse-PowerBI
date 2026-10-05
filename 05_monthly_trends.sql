---Monthly Revenue---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY month
ORDER BY month;

---Monthly Orders---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY month
ORDER BY month;

---Monthly Customers---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales
GROUP BY month
ORDER BY month;

---Monthly Units Sold---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY month
ORDER BY month;

---Complete Monthly KPI---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales
GROUP BY month
ORDER BY month;

---Monthly Order Status---
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY month, order_status
ORDER BY month, total_orders DESC;

---Monthly Revenue & Anomaly---
CREATE OR REPLACE VIEW vw_monthly_revenue_anomaly AS
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(revenue) AS total_revenue,
    SUM(
        CASE
            WHEN is_price_outlier = TRUE THEN revenue
            ELSE 0
        END
    ) AS outlier_revenue
FROM sales
GROUP BY month
ORDER BY month;

SELECT * FROM vw_monthly_revenue_anomaly;