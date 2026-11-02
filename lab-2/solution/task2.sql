SELECT o.order_id,
       o.status,
       c.full_name AS customer,
       p.product_name,
       cat.name AS category,
       oi.quantity,
       oi.unit_price
  FROM orders AS o
           JOIN address AS a ON a.order_id = o.order_id
           JOIN customers AS c ON c.customer_id = a.customer_id
           JOIN order_items AS oi ON oi.order_id = o.order_id
           JOIN products AS p ON p.product_id = oi.product_id
           JOIN categories AS cat ON cat.category_id = p.category_id
 ORDER BY o.order_id;


SELECT cat.name AS category, p.product_name
  FROM products AS p
           JOIN categories AS cat ON cat.category_id = p.category_id
           LEFT JOIN order_items AS oi ON oi.product_id = p.product_id
 WHERE oi.order_id IS NULL;


SELECT DISTINCT c.full_name, c.phone
  FROM customers AS c
           JOIN address AS a ON a.customer_id = c.customer_id
           JOIN orders AS o ON o.order_id = a.order_id
           JOIN order_items AS oi ON oi.order_id = o.order_id
           JOIN products AS p ON p.product_id = oi.product_id
           JOIN categories AS cat ON cat.category_id = p.category_id
 WHERE cat.name = 'Laptops'
   AND o.status <> 'cancelled'
   AND c.phone IS NOT NULL;


SELECT o.status, COUNT(*) AS orders_count
  FROM orders AS o
 GROUP BY o.status
 ORDER BY orders_count DESC;


SELECT p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue, ROUND(AVG(oi.unit_price), 2) AS avg_price
  FROM order_items AS oi
           JOIN products AS p ON p.product_id = oi.product_id
           JOIN orders AS o ON o.order_id = oi.order_id
 WHERE o.status <> 'cancelled'
 GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * oi.unit_price) > 100_000
 ORDER BY revenue DESC;


SELECT cat.name AS category,
       COUNT(*) AS items_count,
       MIN(oi.unit_price) AS min_price,
       MAX(oi.unit_price) AS max_price
  FROM categories AS cat
           JOIN products AS p ON p.category_id = cat.category_id
           JOIN order_items AS oi ON oi.product_id = p.product_id
 GROUP BY cat.name
 ORDER BY cat.name;
