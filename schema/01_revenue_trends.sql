-- ================================================
-- FILE: analysis/01_revenue_trends.sql
-- BUSINESS QUESTION: How did monthly revenue trend
-- over time, and what was the month-on-month growth?
-- ================================================

-- Step 1: Basic monthly revenue
SELECT
    DATE_TRUNC('month', o.order_purchase_ts) AS order_month,
    COUNT(DISTINCT o.order_id)               AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;

-- Step 2: Adding month-on-month growth using LAG()
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_ts) AS order_month,
        COUNT(DISTINCT o.order_id)               AS total_orders,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY order_month
)
SELECT
    order_month,
    total_orders,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month))
        / LAG(total_revenue) OVER (ORDER BY order_month) * 100, 1
    ) AS mom_growth_pct
FROM monthly
ORDER BY order_month;