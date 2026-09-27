SELECT
    seller_state,
    customer_state,
    delay_bucket,

    COUNT(*) AS reviewed_orders,

    ROUND(AVG(review_score), 2) AS avg_review_score,

    COUNT(*) FILTER (
        WHERE review_score <= 2
    ) AS dissatisfied_orders,

    ROUND(
        COUNT(*) FILTER (
            WHERE review_score <= 2
        ) * 100.0 / COUNT(*),
        2
    ) AS dissatisfaction_rate

FROM (
    SELECT DISTINCT
        o.order_id,

        s.seller_state,
        c.customer_state,

        CASE
            WHEN o.order_delivered_customer_date::date
                 <= o.order_estimated_delivery_date::date
                THEN 'On time / Early'

            WHEN o.order_delivered_customer_date::date
                 - o.order_estimated_delivery_date::date BETWEEN 1 AND 2
                THEN '1-2 days late'

            WHEN o.order_delivered_customer_date::date
                 - o.order_estimated_delivery_date::date BETWEEN 3 AND 7
                THEN '3-7 days late'

            WHEN o.order_delivered_customer_date::date
                 - o.order_estimated_delivery_date::date BETWEEN 8 AND 14
                THEN '8-14 days late'

            ELSE '15+ days late'
        END AS delay_bucket,

        r.review_score

    FROM orders o

    JOIN customers c
        ON o.customer_id = c.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN sellers s
        ON oi.seller_id = s.seller_id

    JOIN reviews r
        ON o.order_id = r.order_id

    WHERE o.order_estimated_delivery_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL
      AND r.review_score IS NOT NULL
) AS route_level

GROUP BY
    seller_state,
    customer_state,
    delay_bucket

HAVING COUNT(*) >= 30

ORDER BY
    seller_state,
    customer_state,
    CASE delay_bucket
        WHEN 'On time / Early' THEN 1
        WHEN '1-2 days late' THEN 2
        WHEN '3-7 days late' THEN 3
        WHEN '8-14 days late' THEN 4
        WHEN '15+ days late' THEN 5
    END;