SELECT
    product_category,
    delay_bucket,

    COUNT(*) AS reviewed_orders,

    ROUND(AVG(review_score), 2) AS avg_review_score,

    ROUND(
        COUNT(*) FILTER (
            WHERE review_score <= 2
        ) * 100.0 / COUNT(*),
        2
    ) AS dissatisfaction_rate

FROM (
    SELECT DISTINCT
        o.order_id,

        t.product_category_name_english AS product_category,

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

    JOIN reviews r
        ON o.order_id = r.order_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    LEFT JOIN product_category_translation t
        ON p.product_category_name = t.product_category_name

    WHERE o.order_estimated_delivery_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL
      AND r.review_score IS NOT NULL
      AND t.product_category_name_english IS NOT NULL
) AS order_category_level

GROUP BY
    product_category,
    delay_bucket

ORDER BY
    product_category,
    CASE delay_bucket
        WHEN 'On time / Early' THEN 1
        WHEN '1-2 days late' THEN 2
        WHEN '3-7 days late' THEN 3
        WHEN '8-14 days late' THEN 4
        WHEN '15+ days late' THEN 5
    END;