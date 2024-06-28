Customers

CREATE TABLE customers (
	cust_id SERIAL PRIMARY KEY,
	cust_name VARCHAR(100) NOT NULL
);

Orders

CREATE TABLE orders(
	ord_id SERIAL PRIMARY KEY,
	ord_date DATE NOT NULL,
	cust_id INTEGER NOT NULL,
	FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

Project

CREATE TABLE products (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    price NUMERIC NOT NULL
);

Items

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    ord_id INTEGER NOT NULL,
    p_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (ord_id) REFERENCES orders (ord_id),
    FOREIGN KEY (p_id) REFERENCES products (p_id)
);

========================================

INSERT INTO customers (cust_name)
VALUES 
    ('Het'), ('Jay'), ('Gunjan'), ('Urvi');

INSERT INTO orders (ord_date, cust_id)
VALUES 
    ('2024-01-28', 1),      -- het first order
    ('2024-02-09', 2),     -- jay first order
    ('2024-03-16', 3),     -- gunjan first order
    ('2024-04-03', 4);    -- urvi second order

INSERT INTO products (p_name, price)
VALUES 
    ('Laptop', 55000.00),
    ('Mouse', 500.00),
    ('Keyboard', 800.00),
    ('Cable', 250.00);

INSERT INTO order_items (ord_id, p_id, quantity)
VALUES 
    (1, 1, 1),  -- het ordered 1 Laptop
    (1, 4, 2),  -- het ordered 2 Cables
    (2, 1, 1),  -- jay ordered 1 Laptop
	(2, 3, 1),  -- jay ordered 1 Keyboard
    (3, 2, 1),  -- gunjan ordered 1 Mouse
    (3, 4, 5),  -- gunjan ordered 5 Cable
	(4, 2, 6),  -- urvi ordered 6 Mouse
	(4, 3, 2);  -- urvi ordered 2 Keyboard

====================================

select * from customers;
select * from orders;
select * from products;

select * from order_items;

=====================================

CREATE VIEW billing_info AS
SELECT 
	c.cust_name,
	o.ord_date,
	p.p_name,
	p.price,
	oi.quantity,
	(oi.quantity*p.price) AS total_price
	
	FROM order_items oi 
	JOIN
		products p ON oi.p_id=p.p_id
	JOIN
		orders o ON o.ord_id=oi.ord_id
	JOIN
		customers c ON o.cust_id=c.cust_id;

=========================================

SELECT * FROM billing_info;

=========================================

SELECT p_name, SUM(total_price) from
billing_info
	GROUP BY p_name
	HAVING SUM(total_price) > 2000;


SELECT 
	COALESCE(p_name, 'Total'), 
	SUM(total_price) from billing_info
	GROUP BY ROLLUP(p_name)
	ORDER BY sum(total_price);

