---Total rows---
SELECT COUNT(*) AS total_rows
FROM sales;

---Data Show---
SELECT *
FROM sales
LIMIT 10;

---Duplicate orders---
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY order_id
HAVING COUNT(*) > 1;

---Invalid quantity---
SELECT COUNT(*) AS invalid_quantity
FROM sales
WHERE quantity <= 0;

---Invalid price---
SELECT COUNT(*) AS invalid_price
FROM sales
WHERE unit_price <= 0;

---Revenue check---
SELECT COUNT(*) AS revenue_errors
FROM sales
WHERE revenue <> quantity * unit_price;

---Outlier count---
SELECT
    COUNT(*) AS price_outliers
FROM sales
WHERE is_price_outlier = TRUE;