WITH delivery_data AS (
    SELECT
        CASE
            WHEN order_delivered_customer_date::date
                 <= order_estimated_delivery_date::date
                THEN 'On time / Early'

            WHEN order_delivered_customer_date::date
                 - order_estimated_delivery_date::date BETWEEN 1 AND 2
                THEN '1-2 days late'

            WHEN order_delivered_customer_date::date
                 - order_estimated_delivery_date::date BETWEEN 3 AND 7
                THEN '3-7 days late'

            WHEN order_delivered_customer_date::date
                 - order_estimated_delivery_date::date BETWEEN 8 AND 14
                THEN '8-14 days late'

            ELSE '15+ days late'
        END AS delay_bucket

    FROM orders

    WHERE order_estimated_delivery_date IS NOT NULL
      AND order_delivered_customer_date IS NOT NULL
)

SELECT
    delay_bucket,
    COUNT(*) AS order_count,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage

FROM delivery_data

GROUP BY delay_bucket

ORDER BY
    CASE delay_bucket
        WHEN 'On time / Early' THEN 1
        WHEN '1-2 days late' THEN 2
        WHEN '3-7 days late' THEN 3
        WHEN '8-14 days late' THEN 4
        WHEN '15+ days late' THEN 5
    END;