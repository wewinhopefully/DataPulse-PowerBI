---Monthly Revenue + Previous Month Revenue---
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY month
)

SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue
FROM monthly_revenue
ORDER BY month;

---Month-over-Month Growth %---
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY month
),

revenue_with_previous AS (
    SELECT
        month,
        total_revenue,
        LAG(total_revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    month,
    total_revenue,
    previous_month_revenue,
    ROUND(
        100.0 * (total_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_pct
FROM revenue_with_previous
ORDER BY month;

---Rank Products by Revenue---
SELECT
    product_name,
    SUM(revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM sales
GROUP BY product_name
ORDER BY revenue_rank;

---Rank Products Within Each Category---
SELECT
    product_category,
    product_name,
    SUM(revenue) AS total_revenue,
    RANK() OVER (
        PARTITION BY product_category
        ORDER BY SUM(revenue) DESC
    ) AS category_rank
FROM sales
GROUP BY product_category, product_name
ORDER BY product_category, category_rank;

---Regional Revenue Ranking---
SELECT
    region,
    SUM(revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM sales
GROUP BY region
ORDER BY revenue_rank;

---Running Revenue Total---
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue) AS monthly_revenue
    FROM sales
    GROUP BY month
)

SELECT
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month;