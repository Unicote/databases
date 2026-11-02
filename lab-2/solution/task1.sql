BEGIN;

ALTER TABLE orders
    ADD COLUMN status TEXT DEFAULT 'created' NOT NULL,
    ADD CHECK (status IN ('created', 'paid', 'shipped', 'delivered', 'cancelled'));

ALTER TABLE customers
    ADD COLUMN phone TEXT;

ALTER TABLE order_items
    ADD COLUMN unit_price NUMERIC(10, 2),
    ADD CHECK (unit_price >= 0);

INSERT INTO price_history (product_id, current_price, changed_at)
VALUES (1, 99999.00, '2026-07-01 00:00:00+03'),
       (2, 66666.00, '2026-07-01 00:00:00+03'),
       (3, 22222222.00, '2026-07-01 00:00:00+03'),
       (4, 111.00, '2026-07-01 00:00:00+03'),
       (5, 333.00, '2026-07-01 00:00:00+03'),
       (6, 2222.00, '2026-07-01 00:00:00+03');

-- noinspection SqlWithoutWhere
UPDATE order_items
   SET unit_price = (SELECT ph.current_price
                       FROM price_history AS ph
                      WHERE ph.product_id = order_items.product_id
                        AND ph.changed_at <=
                            (SELECT o.created_at
                               FROM orders AS o
                              WHERE o.order_id = order_items.order_id)
                      ORDER BY ph.changed_at DESC
                      LIMIT 1);

ALTER TABLE order_items
    ALTER COLUMN unit_price SET NOT NULL;

COMMIT;


-- 1.1

BEGIN;

UPDATE orders
   SET status = 'cancelled'
 WHERE order_id = 1;

UPDATE orders
   SET status = 'delivered'
 WHERE order_id IN (2, 3, 4);

UPDATE customers
   SET phone = '+7 999 000-00-10'
 WHERE customer_id = 1;

UPDATE customers
   SET phone = '+7 999 000-00-20'
 WHERE customer_id = 2;

UPDATE customers
   SET phone = '+7 999 000-00-30'
 WHERE customer_id = 3;

INSERT INTO categories(name)
VALUES ('Smartphones'),
       ('Accessories'),
       ('Toys');

INSERT INTO customers (full_name, email, password_hash, phone)
VALUES ('A A', 'aa@gmail.com', 'qwerty12', '+7 999 000-00-00'),
       ('B B', 'bb@gmail.com', 'qwertyu1', '+7 999 000-00-01'),
       ('C C', 'cc@gmail.com', 'qwerttyu', NULL),
       ('D D', 'dd@gmail.com', 'qwedsad2', '+7 999 000-00-02'),
       ('E E', 'ee@gmail.com', 'aedsfsfd', NULL),
       ('F F', 'ff@gmail.com', 'ertrtertg', '+7 999 000-00-03'),
       ('J J', 'jj@gmail.com', 'sdfsdfsf', NULL),
       ('H H', 'hh@gmail.com', 'rwerwerewr', '+7 999 000-00-04');

INSERT INTO products (category_id, product_name, sku)
VALUES (4, 'Google Pixel', 'google-pixel'),
       (4, 'Google Pixel 2', 'google-pixel-2'),
       (4, 'Google Pixel 3', 'google-pixel-3'),
       (4, 'Google Pixel 4', 'google-pixel-4'),
       (4, 'Google Pixel 5', 'google-pixel-5'),
       (4, 'Google Pixel 6', 'google-pixel-6'),
       (4, 'Google Pixel 7', 'google-pixel-7'),
       (4, 'Google Pixel 8', 'google-pixel-8'),
       (4, 'Google Pixel 9', 'google-pixel-9'),
       (4, 'Google Pixel 10', 'google-pixel-10'),
       (4, 'Google Pixel 11', 'google-pixel-11');

INSERT INTO price_history (product_id, current_price, changed_at)
VALUES (7, 99999.00, '2026-07-01 00:00:00+03'),
       (8, 99999.90, '2026-07-01 00:00:00+03'),
       (8, 99999.90, '2026-07-01 00:00:00+03'),
       (9, 99999.00, '2026-07-01 00:00:00+03'),
       (9, 99999.00, '2026-07-01 00:00:00+03'),
       (10, 99999.00, '2026-07-01 00:00:00+03'),
       (11, 99999.00, '2026-07-01 00:00:00+03'),
       (12, 99999.00, '2026-07-01 00:00:00+03'),
       (12, 99999.00, '2026-07-01 00:00:00+03'),
       (13, 99999.00, '2026-07-01 00:00:00+03'),
       (13, 99999.00, '2026-07-01 00:00:00+03'),
       (14, 99999.00, '2026-07-01 00:00:00+03'),
       (15, 99999.00, '2026-07-01 00:00:00+03'),
       (16, 99999.00, '2026-07-01 00:00:00+03'),
       (7, 99999.00, '2026-07-01 00:00:00+03');

INSERT INTO orders (created_at, status)
VALUES ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'cancelled'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       ('2026-08-03 00:00:00+03', 'delivered'),
       -- сентябрь
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'cancelled'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'delivered'),
       ('2026-09-03 00:00:00+03', 'cancelled'),
       -- октябрь
       ('2026-10-03 00:00:00+03', 'delivered'),
       ('2026-10-03 00:00:00+03', 'delivered'),
       ('2026-10-03 00:00:00+03', 'delivered'),
       ('2026-10-03 00:00:00+03', 'shipped'),
       ('2026-10-03 00:00:00+03', 'delivered'),
       ('2026-10-03 00:00:00+03', 'shipped'),
       ('2026-10-03 00:00:00+03', 'paid'),
       ('2026-10-03 00:00:00+03', 'shipped'),
       -- ноябрь
       ('2026-11-03 00:00:00+03', 'created'),
       ('2026-11-03 00:00:00+03', 'paid'),
       ('2026-11-03 00:00:00+03', 'created'),
       ('2026-11-03 00:00:00+03', 'created'),
       ('2026-11-03 00:00:00+03', 'cancelled'),
       ('2026-11-03 00:00:00+03', 'paid'),
       ('2026-11-03 00:00:00+03', 'cancelled');

INSERT INTO address(customer_id, order_id, address)
VALUES (5, 5, 'Москва, Волоколамское шоссе, д. 4'),
       (6, 6, 'Москва, Волоколамское шоссе, д. 4'),
       (1, 7, 'Москва, Волоколамское шоссе, д. 4'),
       (7, 8, 'Москва, Волоколамское шоссе, д. 4'),
       (5, 9, 'Москва, Волоколамское шоссе, д. 4'),
       (8, 10, 'Москва, Волоколамское шоссе, д. 4'),
       (2, 11, 'Москва, Волоколамское шоссе, д. 4'),
       (9, 12, 'Москва, Волоколамское шоссе, д. 4'),
       (5, 13, 'Москва, Волоколамское шоссе, д. 4'),
       (6, 14, 'Москва, Волоколамское шоссе, д. 4'),
       (10, 15, 'Москва, Волоколамское шоссе, д. 4'),
       (3, 16, 'Москва, Волоколамское шоссе, д. 4'),
       (7, 17, 'Москва, Волоколамское шоссе, д. 4'),
       (8, 18, 'Москва, Волоколамское шоссе, д. 4'),
       (1, 19, 'Москва, Волоколамское шоссе, д. 4'),
       (9, 20, 'Москва, Волоколамское шоссе, д. 4'),
       (10, 21, 'Москва, Волоколамское шоссе, д. 4'),
       (5, 22, 'Москва, Волоколамское шоссе, д. 4'),
       (6, 23, 'Москва, Волоколамское шоссе, д. 4'),
       (8, 24, 'Москва, Волоколамское шоссе, д. 4'),
       (9, 25, 'Москва, Волоколамское шоссе, д. 4'),
       (1, 26, 'Москва, Волоколамское шоссе, д. 4'),
       (5, 27, 'Москва, Волоколамское шоссе, д. 4'),
       (2, 28, 'Москва, Волоколамское шоссе, д. 4'),
       (2, 29, 'Москва, Волоколамское шоссе, д. 4'),
       (5, 30, 'Москва, Волоколамское шоссе, д. 4'),
       (6, 31, 'Москва, Волоколамское шоссе, д. 4'),
       (8, 32, 'Москва, Волоколамское шоссе, д. 4'),
       (1, 33, 'Москва, Волоколамское шоссе, д. 4'),
       (7, 34, 'Москва, Волоколамское шоссе, д. 4'),
       (9, 35, 'Москва, Волоколамское шоссе, д. 4'),
       (10, 36, 'Москва, Волоколамское шоссе, д. 4');

-- noinspection SqlInsertValues
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (5, 1, 1, 99999.00),
       (5, 14, 2, 99999.00),
       (5, 15, 1, 99999.00),
       (6, 4, 6, 99999.90),
       (6, 8, 2, 99999.90),
       (7, 10, 1, 99999.00),
       (7, 11, 1, 99999.00),
       (8, 3, 1, 99999.00),
       (9, 8, 3, 99999.90),
       (9, 9, 2, 99999.00),
       (10, 12, 1, 99999.00),
       (10, 14, 1, 99999.00),
       (11, 6, 2, 99999.00),
       (11, 10, 1, 99999.00),
       (12, 13, 1, 99999.00),
       (12, 15, 1, 99999.00),
       (13, 4, 10, 99999.90),
       (13, 9, 1, 99999.00),
       (14, 7, 1, 99999.00),
       (14, 15, 1, 99999.00),
       (15, 2, 1, 99999.00),
       (16, 6, 1, 99999.00),
       (16, 11, 2, 99999.00),
       (17, 12, 1, 99999.00),
       (17, 14, 3, 99999.00),
       (18, 5, 4, 99999.00),
       (18, 8, 2, 99999.90),
       (19, 13, 1, 99999.00),
       (20, 1, 1, 99999.00),
       (20, 15, 2, 99999.00),
       (21, 3, 1, 99999.00),
       (22, 4, 5, 99999.12),
       (22, 9, 3, 99999.00),
       (22, 10, 1, 99999.00),
       (23, 12, 2, 99999.00),
       (23, 14, 2, 99999.00),
       (24, 7, 1, 99999.00),
       (24, 15, 1, 99999.00),
       (25, 4, 8, 99999.12),
       (25, 5, 2, 99999.00),
       (26, 6, 3, 99999.00),
       (26, 11, 1, 99999.00),
       (27, 13, 1, 99999.00),
       (27, 14, 1, 99999.00),
       (28, 3, 1, 99999.00),
       (29, 8, 6, 99999.90),
       (29, 9, 1, 99999.00),
       (30, 10, 2, 99999.00),
       (30, 11, 1, 99999.00),
       (31, 12, 1, 99999.00),
       (32, 4, 12, 99999.00),
       (32, 8, 4, 99999.90),
       (33, 14, 2, 99999.00),
       (33, 15, 1, 99999.00),
       (34, 12, 1, 99999.00),
       (35, 13, 1, 99999.00),
       (35, 15, 1, 99999.00),
       (36, 2, 1, 99999.00);

COMMIT;


-- 1.2

BEGIN;
-- 1.2.1
   INSERT INTO customers (full_name, email, password_hash, phone)
   VALUES ('K K', 'kk@gmail.com', 'jtjtjjtjtjjtj', NULL)
RETURNING customer_id, full_name;

   INSERT INTO orders (status)
   VALUES ('created')
RETURNING order_id, status;

   INSERT INTO address (customer_id, order_id, address)
   VALUES ((SELECT c.customer_id FROM customers AS c WHERE c.email = 'kk@gmail.com'),
           (SELECT MAX(o.order_id) FROM orders AS o),
           'Москва, Волоколамское шоссе, д. 1')
RETURNING customer_id, order_id, address;

-- noinspection SqlInsertValues
   INSERT INTO order_items (order_id, product_id, quantity, unit_price)
   VALUES ((SELECT MAX(o.order_id) FROM orders AS o), 1, 1, 89990.00),
          ((SELECT MAX(o.order_id) FROM orders AS o), 4, 3, 123.12)
RETURNING order_id, product_id, quantity, unit_price;

-- 1.2.2
UPDATE orders
   SET status = 'paid'
 WHERE order_id = 30
   AND status = 'created';

-- 1.2.3
UPDATE orders
   SET status = 'delivered'
 WHERE status = 'shipped'
   AND created_at < '2026-10-26 00:00:00+03';

DELETE
  FROM address
 WHERE order_id = 34;

DELETE
  FROM orders
 WHERE order_id = 34
   AND status = 'cancelled';

COMMIT;

-- 1.2.4 (err)
DELETE
  FROM customers
 WHERE customer_id = 10;

-- 1.2.5
BEGIN;

SELECT COUNT(*) AS cancelled_before
  FROM orders
 WHERE status = 'cancelled';

DELETE
  FROM address
 WHERE order_id IN (SELECT o.order_id FROM orders AS o WHERE o.status = 'cancelled');

DELETE
  FROM orders
 WHERE status = 'cancelled';

SELECT COUNT(*) AS cancelled_inside
  FROM orders
 WHERE status = 'cancelled';

ROLLBACK;

SELECT COUNT(*) AS cancelled_after
  FROM orders
 WHERE status = 'cancelled';
