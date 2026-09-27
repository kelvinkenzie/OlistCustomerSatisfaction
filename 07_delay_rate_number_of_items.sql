SELECT
    CASE
        WHEN item_count = 1 THEN '1 item'
        WHEN item_count = 2 THEN '2 items'
        WHEN item_count = 3 THEN '3 items'
        ELSE '4+ items'
    END AS item_count_bucket,

    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE actual_delivery_date > estimated_delivery_date
    ) AS late_orders,

    ROUND(
        COUNT(*) FILTER (
            WHERE actual_delivery_date > estimated_delivery_date
        ) * 100.0 / COUNT(*),
        2
    ) AS delay_rate

FROM (
    SELECT
        o.order_id,
        COUNT(oi.order_item_id) AS item_count,
        o.order_delivered_customer_date::date AS actual_delivery_date,
        o.order_estimated_delivery_date::date AS estimated_delivery_date

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_estimated_delivery_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL

    GROUP BY
        o.order_id,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
) AS order_level

GROUP BY item_count_bucket

ORDER BY delay_rate DESC;