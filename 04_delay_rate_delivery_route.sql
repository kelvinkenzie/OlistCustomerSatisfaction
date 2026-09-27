SELECT
    s.seller_state,
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT o.order_id) FILTER (
        WHERE o.order_delivered_customer_date::date
              > o.order_estimated_delivery_date::date
    ) AS late_orders,

    ROUND(
        COUNT(DISTINCT o.order_id) FILTER (
            WHERE o.order_delivered_customer_date::date
                  > o.order_estimated_delivery_date::date
        ) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS delay_rate

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN sellers s
    ON oi.seller_id = s.seller_id

WHERE o.order_estimated_delivery_date IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL

GROUP BY
    s.seller_state,
    c.customer_state

HAVING COUNT(DISTINCT o.order_id) >= 30

ORDER BY delay_rate DESC;