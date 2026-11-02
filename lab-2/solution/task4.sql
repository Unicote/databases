  WITH order_stat AS (SELECT oi.order_id,
                             p.category_id,
                             oi.quantity,
                             oi.unit_price
                        FROM order_items AS oi
                                 JOIN orders AS o ON o.order_id = oi.order_id
                                 JOIN products AS p ON p.product_id = oi.product_id
                       WHERE o.status <> 'cancelled'),

       order_amounts AS (SELECT os.order_id,
                                os.category_id,
                                os.quantity * os.unit_price AS amount
                           FROM order_stat AS os),

       category_sales AS (SELECT oa.category_id,
                                 SUM(oa.amount) AS revenue,
                                 COUNT(DISTINCT oa.order_id) AS orders_count
                            FROM order_amounts AS oa
                           GROUP BY oa.category_id)

SELECT cat.name AS категория,
       cs.revenue AS выручка,
       cs.orders_count AS количество_заказов,
       ROUND(100 * cs.revenue / (SELECT SUM(cs2.revenue) FROM category_sales AS cs2), 1) AS доля_выручки
  FROM category_sales AS cs
           JOIN categories AS cat ON cat.category_id = cs.category_id
 ORDER BY cs.revenue DESC;
