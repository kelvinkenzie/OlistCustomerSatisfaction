SELECT
    CASE
        WHEN order_value < 50 THEN '< 50'
        WHEN order_value < 100 THEN '50-99'
        WHEN order_value < 250 THEN '100-249'
        WHEN order_value < 500 THEN '250-499'
        ELSE '500+'
    END AS order_value_bucket,

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
        SUM(oi.price) AS order_value,
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

GROUP BY order_value_bucket

ORDER BY delay_rate DESC;