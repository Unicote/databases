BEGIN;

INSERT INTO categories (name)
VALUES ('Laptops'),
       ('Food'),
       ('Books');

INSERT INTO customers (full_name, email, password_hash)
VALUES ('abc', 'abc@abc.ru', '123123123123'),
       ('wasd', 'wasd@wasd.com', '45612313123'),
       ('amogus', 'sugoma@vk.ru', '789asdasdasdasd'),
       ('uuuu', 'uuuu@uuuu.uuuu', '12313123');

INSERT INTO products (category_id, product_name, sku)
VALUES (1, 'ASUS K501LX', 'ASUS-Laptop-1'),
       (1, 'ASUS VivoBook 15', 'ASUS-Laptop-2'),
       (1, 'Apple MacBook Pro', 'Apple-Laptop-1'),
       (2, 'Banana', 'banana-1'),
       (2, 'burger', 'burger-1'),
       (3, 'Harry Potter', 'HP-1');

INSERT INTO orders (customer_id, created_at)
VALUES (1, '2026-10-01 11:11:11+03'),
       (2, '2026-10-02 22:22:22+03'),
       (1, '2026-10-03 00:00:00+03'),
       (3, '2026-10-04 14:23:43+03');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 1),
       (1, 3, 2),
       (2, 2, 1),
       (2, 6, 1),
       (3, 4, 1),
       (3, 5, 2),
       (4, 1, 1),
       (4, 6, 3);

INSERT INTO price_history (product_id, current_price, changed_at)
VALUES (1, 99999.00, '2026-09-28 09:00:00+03'),
       (1, 89990.00, '2026-09-29 09:00:00+03'),
       (2, 64990.00, '2026-09-30 09:00:00+03'),
       (3, 189990.00, '2026-10-01 09:00:00+03'),
       (4, 123.12, '2026-10-02 09:00:00+03'),
       (5, 349.00, '2026-10-02 10:00:00+03'),
       (6, 890.00, '2026-10-01 10:00:00+03');

COMMIT;

-- ROLLBACK;
-- TRUNCATE TABLE Orders, Order_Items, Products, Customers, Price_History, Categories RESTART IDENTITY;
--
-- SELECT Current_Price
--   FROM Price_History
--  WHERE Product_Id = 1
--  ORDER BY Changed_At DESC, Price_History_Id DESC
--  LIMIT 1;