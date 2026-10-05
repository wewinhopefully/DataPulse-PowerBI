---Overall KPI View---
CREATE OR REPLACE VIEW vw_overall_kpis AS
SELECT
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales;

---Run---
SELECT * FROM vw_overall_kpis;

---Regional Performance View---
CREATE OR REPLACE VIEW vw_regional_performance AS
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
GROUP BY region;

---Run---
SELECT * FROM vw_regional_performance;

---Product Performance View---
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    product_category,
    product_name,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY product_category, product_name;

---Run---
SELECT * FROM vw_product_performance
LIMIT 10;

---Monthly Performance View---
CREATE OR REPLACE VIEW vw_monthly_performance AS
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
GROUP BY month;

---Run---
SELECT * FROM vw_monthly_performance;

---Customer Performance View---
CREATE OR REPLACE VIEW vw_customer_performance AS
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units,
    SUM(revenue) AS total_revenue,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales
GROUP BY customer_id, customer_name;

---Run---
SELECT * FROM vw_customer_performance
LIMIT 10;

---Order Status---
CREATE OR REPLACE VIEW vw_order_status_summary AS
SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY order_status;

---Run---
SELECT * FROM vw_order_status_summary;

---Region × Category Revenue---
CREATE OR REPLACE VIEW vw_region_category_performance AS
SELECT
    region,
    product_category,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY region, product_category;

---Run---
SELECT * FROM vw_region_category_performance;

---outlier_orders---
SELECT
    region,
    COUNT(*) AS outlier_orders,
    SUM(revenue) AS outlier_revenue
FROM sales
WHERE is_price_outlier = TRUE
GROUP BY region
ORDER BY outlier_orders DESC;

---anomaly_analysis---
CREATE OR REPLACE VIEW vw_anomaly_analysis AS
SELECT
    region,
    COUNT(*) AS outlier_orders,
    SUM(revenue) AS outlier_revenue
FROM sales
WHERE is_price_outlier = TRUE
GROUP BY region
ORDER BY outlier_revenue DESC;

---Run---
SELECT *
FROM vw_anomaly_analysis;

---
CREATE OR REPLACE VIEW vw_customer_performance AS
SELECT
    customer_id,
    MAX(customer_name)::VARCHAR(100) AS customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units,
    SUM(revenue) AS total_revenue,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales
GROUP BY customer_id;
SELECT * FROM vw_customer_performance;

---Product Category Anomaly Analysis---
CREATE OR REPLACE VIEW vw_product_category_anomalies AS
SELECT
    product_category,
    product_name,
    COUNT(*) AS outlier_orders,
    SUM(revenue) AS outlier_revenue
FROM sales
WHERE is_price_outlier = TRUE
GROUP BY product_category, product_name
ORDER BY outlier_revenue DESC;

SELECT * FROM vw_product_category_anomalies;