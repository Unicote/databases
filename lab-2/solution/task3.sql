SELECT oi.order_id,
       p.product_name,
       oi.unit_price
  FROM order_items AS oi
           JOIN products AS p ON p.product_id = oi.product_id
 WHERE oi.unit_price > (SELECT AVG(oi2.unit_price)
                          FROM order_items AS oi2
                                   JOIN products AS p2 ON p2.product_id = oi2.product_id
                         WHERE p2.category_id = p.category_id);


SELECT c.full_name
  FROM customers AS c
 WHERE EXISTS (SELECT 1
                 FROM address AS a
                          JOIN orders AS o ON o.order_id = a.order_id
                WHERE a.customer_id = c.customer_id
                  AND o.status = 'delivered');


SELECT c.full_name
  FROM customers AS c
 WHERE NOT EXISTS (SELECT customer_id FROM address AS a WHERE a.customer_id = c.customer_id);


SELECT c.full_name, (SELECT COUNT(*) FROM address AS a WHERE a.customer_id = c.customer_id) AS orders_count
  FROM customers AS c
 ORDER BY orders_count DESC;
