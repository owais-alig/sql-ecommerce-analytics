-- Analysis 2: Seller Performance
-- Which sellers generate the most revenue, 
-- and how do their review scores compare?

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT o.order_id)             AS total_orders,
    ROUND(SUM(oi.price), 2)                AS total_revenue,
    ROUND(AVG(r.review_score), 2)          AS avg_review_score,
    RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank
FROM sellers s
JOIN order_items oi  ON s.seller_id = oi.seller_id
JOIN orders o        ON oi.order_id = o.order_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY revenue_rank
LIMIT 20;