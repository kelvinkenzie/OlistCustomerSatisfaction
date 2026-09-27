SELECT
    COUNT(*) AS total_delivered_orders,

    COUNT(*) FILTER (
        WHERE order_delivered_customer_date::date
              > order_estimated_delivery_date::date
    ) AS late_orders,

    ROUND(
        COUNT(*) FILTER (
            WHERE order_delivered_customer_date::date
                  > order_estimated_delivery_date::date
        ) * 100.0 / COUNT(*),
        2
    ) AS late_delivery_rate,

    ROUND(
        AVG(
            order_delivered_customer_date::date
            - order_estimated_delivery_date::date
        ) FILTER (
            WHERE order_delivered_customer_date::date
                  > order_estimated_delivery_date::date
        ),
        2
    ) AS avg_delay_days,

    MAX(
        order_delivered_customer_date::date
        - order_estimated_delivery_date::date
    ) AS max_delay_days

FROM orders
WHERE order_delivered_customer_date IS NOT NULL;