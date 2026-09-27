SELECT
    CASE
        WHEN t.product_category_name_english IN (
            'home_comfort',
            'home_confort',
            'home_comfort_2'
        ) THEN 'home_comfort'

        WHEN t.product_category_name_english IN (
            'home_appliances',
            'home_appliances_2'
        ) THEN 'home_appliances'

        ELSE t.product_category_name_english
    END AS product_category,

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

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN product_category_translation t
    ON p.product_category_name = t.product_category_name

WHERE o.order_estimated_delivery_date IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL
  AND t.product_category_name_english IS NOT NULL

GROUP BY
    CASE
        WHEN t.product_category_name_english IN (
            'home_comfort',
            'home_confort',
            'home_comfort_2'
        ) THEN 'home_comfort'

        WHEN t.product_category_name_english IN (
            'home_appliances',
            'home_appliances_2'
        ) THEN 'home_appliances'

        ELSE t.product_category_name_english
    END

HAVING COUNT(DISTINCT o.order_id) >= 300
ORDER BY delay_rate DESC;