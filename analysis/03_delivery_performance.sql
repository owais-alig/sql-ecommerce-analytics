-- Analysis 3: Delivery Performance
-- Which states have the worst delivery delays?

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id)                          AS total_orders,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date 
        - o.order_purchase_ts)) / 86400
    ), 1)                                               AS avg_delivery_days,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.order_estimated_delivery_date 
        - o.order_purchase_ts)) / 86400
    ), 1)                                               AS avg_estimated_days,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date 
        - o.order_estimated_delivery_date)) / 86400
    ), 1)                                               AS avg_delay_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delay_days DESC;