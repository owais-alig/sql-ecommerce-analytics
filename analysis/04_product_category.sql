-- Analysis 4: Product Category Performance
-- Which categories generate most revenue and have best ratings?

SELECT
    ct.product_category_name_english    AS category,
    COUNT(DISTINCT o.order_id)          AS total_orders,
    ROUND(SUM(oi.price), 2)             AS total_revenue,
    ROUND(AVG(r.review_score), 2)       AS avg_review_score,
    RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank
FROM order_items oi
JOIN orders o        ON oi.order_id = o.order_id
JOIN products p      ON oi.product_id = p.product_id
JOIN category_translation ct 
                     ON p.product_category_name = ct.product_category_name
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY ct.product_category_name_english
ORDER BY revenue_rank
LIMIT 15;