---Total Revenue---
SELECT
    SUM(revenue) AS total_revenue
FROM sales;

---Total Orders---
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM sales;

---Total Customers---
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales;

---Total Units Sold---
SELECT
    SUM(quantity) AS total_units_sold
FROM sales;

---Average Order Value---
SELECT
    ROUND(
        SUM(revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales;

---Completed Orders---
SELECT
    COUNT(DISTINCT order_id) AS completed_orders
FROM sales
WHERE order_status = 'Completed';

---Cancelled Orders---
SELECT
    COUNT(DISTINCT order_id) AS cancelled_orders
FROM sales
WHERE order_status = 'Cancelled';

---One Combined KPI Query---
SELECT
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    COUNT(DISTINCT order_id)
        FILTER (WHERE order_status = 'Completed') AS completed_orders,
    COUNT(DISTINCT order_id)
        FILTER (WHERE order_status = 'Cancelled') AS cancelled_orders
FROM sales;