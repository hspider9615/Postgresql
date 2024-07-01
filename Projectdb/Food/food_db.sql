-- Country
CREATE TABLE country(
	id SERIAL PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL 
);

-- Address
CREATE TABLE address(
	id SERIAL PRIMARY KEY,
	unit_name VARCHAR(50),
	street_name VARCHAR(50),
	address_line1 VARCHAR(200) NOT NULL,
	address_line2 VARCHAR(200),
	city VARCHAR(50) NOT NULL,
	state VARCHAR(50),
	pin_code VARCHAR(20) NOT NULL,
	country_id INT NOT NULL REFERENCES country(id)
);

-- Customer
CREATE TABLE customer(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

-- Customer address
CREATE TABLE customer_address(
	id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL REFERENCES customer(id),
	address_id INT NOT NULL REFERENCES address(id)
);

-- Restaurant
CREATE TABLE restaurant(
	id SERIAL PRIMARY KEY,
	restaurant_name VARCHAR(200) NOT NULL,
	address_id INT NOT NULL REFERENCES address(id)
);

-- Menu items
CREATE TABLE menu_item (
    id SERIAL PRIMARY KEY,
    restaurant_id INT NOT NULL REFERENCES restaurant(id),
    item_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Deliver Driver
CREATE TABLE delivery_driver (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

-- Order status
CREATE TABLE order_status (
    id SERIAL PRIMARY KEY,
    status_value VARCHAR(50) NOT NULL
);

-- Food order
CREATE TABLE food_order (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(id),
    restaurant_id INT NOT NULL REFERENCES restaurant(id),
    customer_address_id INT NOT NULL REFERENCES customer_address(id),
    order_status_id INT NOT NULL REFERENCES order_status(id),
    assigned_driver_id INT REFERENCES delivery_driver(id),
    order_datetime TIMESTAMP NOT NULL,
    delivery_fee DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    requested_delivery_datetime TIMESTAMP NOT NULL,
    cust_driver_rating DECIMAL(3, 2),
    cust_restaurant_rating DECIMAL(3, 2)
);

-- Order menu items
CREATE TABLE order_menu_item (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES food_order(id) ON DELETE CASCADE,
    menu_item_id INT REFERENCES menu_item(id) ON DELETE CASCADE,
    qty_ordered INT
);

================================================================

-- Rename unit_name to unit_number
ALTER TABLE address RENAME COLUMN unit_name TO unit_number;

-- Rename street_name to street_number
ALTER TABLE address RENAME COLUMN street_name TO street_number;

================================================================
-- Insert query

-- Country
INSERT INTO country (country_name) VALUES 
('India');

select * from country;


-- Address
INSERT INTO address (unit_number, street_number, address_line1, address_line2, city, state, pin_code, country_id) VALUES
    ('101', '12', 'MG Road', 'Near Mall', 'Surat', 'Gujarat', '395006', 1),
    ('202', '45', 'Main Street', 'Opposite Park', 'Mumbai', 'Maharashtra', '400001', 1),
    ('303', '78', 'Beach Road', 'Next to Temple', 'Goa', 'Goa', '403001', 1),
    ('404', '98', 'Market Street', 'Behind Plaza', 'New Delhi', 'Delhi', '110001', 1),
    ('505', '65', 'Mount Road', 'Near Lake', 'Chennai', 'Tamil Nadu', '600001', 1),
    ('606', '32', 'River Avenue', 'By the Hill', 'Guwahati', 'Assam', '781001', 1),
    ('707', '21', 'Park Avenue', 'Across Stadium', 'Ahmedabad', 'Gujarat', '380001', 1),
    ('808', '43', 'Station Road', 'Near Theater', 'Pune', 'Maharashtra', '411001', 1),
    ('909', '87', 'Forest Street', 'Beside Garden', 'Bangalore', 'Karnataka', '560001', 1),
    ('1010', '54', 'University Road', 'Opposite College', 'Hyderabad', 'Telangana', '500001', 1);

select * from address;

-- Customer
INSERT INTO customer (first_name, last_name) VALUES
    ('Rahul', 'Sharma'),
    ('Priya', 'Patel'),
    ('Amit', 'Verma'),
    ('Neha', 'Singh'),
    ('Vijay', 'Gupta'),
    ('Pooja', 'Saxena'),
    ('Ravi', 'Reddy'),
    ('Deepika', 'Menon'),
    ('Ankit', 'Kumar'),
    ('Nisha', 'Shah');

select * from customer;

-- Customer address
INSERT INTO customer_address (customer_id, address_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

select * from customer_address;


-- Restaurant
INSERT INTO restaurant (restaurant_name, address_id) VALUES
    ('Spice Delight', 1),
    ('Ocean View Restaurant', 2),
    ('Golden Grills', 3),
    ('Green Leaf Bistro', 4),
    ('Sunset Lounge', 5),
    ('Sizzling Salsa', 6),
    ('Urban Bite', 7),
    ('Fusion Flavors', 8),
    ('Café Bliss', 9),
    ('Pasta Paradise', 10);

select * from restaurant;


-- Menu items
INSERT INTO menu_item (restaurant_id, item_name, price) VALUES
(1, 'Paneer Butter Masala', 250.00),
(1, 'Butter Naan', 40.00),
(2, 'Chicken Tandoori', 350.00),
(2, 'Mutton Biryani', 300.00),
(3, 'Masala Dosa', 150.00),
(3, 'Idli Sambhar', 100.00),
(4, 'Chole Bhature', 180.00),
(4, 'Paneer Tikka', 220.00),
(5, 'Vada Pav', 50.00),
(5, 'Pav Bhaji', 120.00);

select * from menu_item;


-- Deliver driver
INSERT INTO delivery_driver (first_name, last_name) VALUES
('Raj', 'Singh'),
('Ajay', 'Kumar'),
('Kunal', 'Mehta'),
('Sunil', 'Patel'),
('Rahul', 'Verma'),
('Naveen', 'Sharma'),
('Manoj', 'Rao'),
('Santosh', 'Gupta'),
('Ashok', 'Joshi'),
('Dinesh', 'Desai');

select * from delivery_driver;

-- Order status
INSERT INTO order_status (status_value) VALUES
('Pending'),
('Confirmed'),
('Prepared'),
('Out for Delivery'),
('Delivered'),
('Confirmed'),
('Prepared'),
('Out for Delivery'),
('Delivered'),
('Cancelled');

select * from order_status;

-- Food order
INSERT INTO food_order (id, customer_id, restaurant_id, customer_address_id, order_status_id, assigned_driver_id, order_datetime, delivery_fee, total_amount, requested_delivery_datetime, cust_driver_rating, cust_restaurant_rating) VALUES
(1, 1, 1, 1, 1, 1, '2023-06-01 10:00:00', 50.00, 300.00, '2023-06-01 10:30:00', 4.5, 4.8),
(2, 2, 2, 2, 2, 2, '2023-06-02 11:00:00', 60.00, 400.00, '2023-06-02 11:30:00', 4.0, 4.7),
(3, 3, 3, 3, 3, 3, '2023-06-03 12:00:00', 70.00, 250.00, '2023-06-03 12:30:00', 4.8, 4.9),
(4, 4, 4, 4, 4, 4, '2023-06-04 13:00:00', 80.00, 500.00, '2023-06-04 13:30:00', 4.2, 4.5),
(5, 5, 5, 5, 5, 5, '2023-06-05 14:00:00', 50.00, 200.00, '2023-06-05 14:30:00', 4.6, 4.8),
(6, 6, 6, 6, 6, 6, '2023-06-06 15:00:00', 60.00, 350.00, '2023-06-06 15:30:00', 4.1, 4.4),
(7, 7, 7, 7, 7, 7, '2023-06-07 16:00:00', 70.00, 450.00, '2023-06-07 16:30:00', 4.7, 4.9),
(8, 8, 8, 8, 8, 8, '2023-06-08 17:00:00', 80.00, 300.00, '2023-06-08 17:30:00', 4.0, 4.6),
(9, 9, 9, 9, 9, 9, '2023-06-09 18:00:00', 50.00, 400.00, '2023-06-09 18:30:00', 4.9, 5.0),
(10, 10, 10, 10, 10, 10, '2023-06-10 19:00:00', 60.00, 250.00, '2023-06-10 19:30:00', 4.3, 4.7);

select * from food_order;

-- Order menu item
INSERT INTO order_menu_item (order_id, menu_item_id, qty_ordered) VALUES
(1, 1, 2),
(1, 2, 4),
(2, 3, 1),
(2, 4, 2),
(3, 5, 3),
(3, 6, 2),
(4, 7, 1),
(4, 8, 1),
(5, 9, 4),
(5, 10, 3),
(6, 1, 1),
(6, 4, 1),
(7, 3, 2),
(7, 5, 2),
(8, 7, 2),
(8, 9, 1),
(9, 2, 3),
(9, 6, 1),
(10, 8, 2),
(10, 10, 3);

select * from order_menu_item;

========================================================
-- Display to combine data in one table view
	
SELECT 
    food_order.id AS order_id,
    customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name,
    restaurant.restaurant_name,
    menu_item.item_name,
    menu_item.price,
    order_menu_item.qty_ordered,
    food_order.order_datetime,
    food_order.delivery_fee,
    food_order.total_amount,
    order_status.status_value AS order_status,
    delivery_driver.first_name AS driver_first_name,
    delivery_driver.last_name AS driver_last_name,
    address.street_number || ' ' || address.address_line1 || ', ' || 
    address.address_line2 || ', ' || address.city || ', ' || 
    address.state || ', ' || address.pin_code AS full_address,
    food_order.cust_driver_rating,
    food_order.cust_restaurant_rating
FROM 
    food_order
JOIN 
    customer ON food_order.customer_id = customer.id
JOIN 
    restaurant ON food_order.restaurant_id = restaurant.id
JOIN 
    address ON restaurant.address_id = address.id
JOIN 
    order_status ON food_order.order_status_id = order_status.id
JOIN 
    delivery_driver ON food_order.assigned_driver_id = delivery_driver.id
JOIN 
    customer_address ON food_order.customer_address_id = customer_address.id
JOIN 
    address AS cust_address ON customer_address.address_id = cust_address.id
JOIN 
    order_menu_item ON food_order.id = order_menu_item.order_id
JOIN 
    menu_item ON order_menu_item.menu_item_id = menu_item.id
ORDER BY 
    food_order.id;

