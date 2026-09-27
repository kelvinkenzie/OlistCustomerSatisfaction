SELECT
    CASE
        WHEN total_weight < 1000 THEN '< 1 kg'
        WHEN total_weight < 5000 THEN '1-5 kg'
        WHEN total_weight < 10000 THEN '5-10 kg'
        ELSE '10+ kg'
    END AS weight_bucket,

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

        SUM(p.product_weight_g) AS total_weight,

        o.order_delivered_customer_date::date AS actual_delivery_date,
        o.order_estimated_delivery_date::date AS estimated_delivery_date

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.order_estimated_delivery_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL

    GROUP BY
        o.order_id,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
) AS order_level

GROUP BY weight_bucket

ORDER BY delay_rate DESC;