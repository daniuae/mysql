
SELECT 
    customer_id,
    customer_name,
    order_id,
    order_date
FROM (
    SELECT 
        c.customer_id,
        c.customer_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_id
            ORDER BY o.order_date DESC
        ) AS rn
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
) latest_orders
WHERE rn = 1;

SELECT 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE (o.customer_id, o.order_date) IN (
    SELECT 
        customer_id,
        MAX(order_date)
    FROM orders
    GROUP BY customer_id
);
