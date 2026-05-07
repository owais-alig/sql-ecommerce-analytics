-- Analysis 5: RFM Customer Segmentation
-- Segment customers by Recency, Frequency, Monetary value

WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_ts)                    AS last_purchase,
        COUNT(DISTINCT o.order_id)                  AS frequency,
        ROUND(SUM(oi.price + oi.freight_value), 2)  AS monetary
    FROM customers c
    JOIN orders o       ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        EXTRACT(DAY FROM (MAX(last_purchase) OVER () - last_purchase)) AS recency_days,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY last_purchase DESC)     AS r_score,
        NTILE(5) OVER (ORDER BY frequency)              AS f_score,
        NTILE(5) OVER (ORDER BY monetary)               AS m_score
    FROM rfm_base
)
SELECT
    customer_unique_id,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score < 3  THEN 'Recent Customers'
        WHEN r_score < 3 AND f_score >= 3  THEN 'At Risk'
        ELSE 'Lost'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC
LIMIT 20;