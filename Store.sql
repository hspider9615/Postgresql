INSERT INTO customers (cust_name)
VALUES
	('Het'), ('Jay'), ('Gunjan'), ('Urvi');

INSERT INTO orders (ord_date, cust_id, price)
VALUES
    ('2024-01-01', 1, 250.00),
    ('2024-01-15', 1, 300.00),
    ('2024-02-01', 2, 150.00),
    ('2024-03-01', 3, 450.00),
    ('2024-04-04', 2, 550.00);

CREATE TABLE orders (
	ord_id SERIAL PRIMARY KEY,
	ord_date DATE NOT NULL,
	price NUMERIC NOT NULL,
	cust_id INTEGER NOT NULL,
	FOREIGN KEY (cust_id) REFERENCES
	customers (cust_id)
);


SELECT c.cust_name, SUM(o.price) FROM customers c
	INNER JOIN
	orders o
ON c.cust_id=o.cust_id
	GROUP BY cust_name;

SELECT * FROM customers c
	RIGHT JOIN
	orders o
ON c.cust_id=o.cust_id;


SELECT * FROM orders o
	RIGHT JOIN
	customers c
ON c.cust_id=o.cust_id;