Creating a small project in Postgre is a great way to get hands-on practice with database concepts,  queries, and database management. Here, I'll outline a project idea along with a set of tables, relationships, and practice queries to help you gain a solid understanding of Postgre.

Project Overview: Bookstore Management System
Objective
Develop a Postgre database for a bookstore to manage books, authors, publishers, and customer orders.

Project Steps
Define the Schema: Identify and define the tables and their relationships.
Create the Database: Write  scripts to create tables and establish relationships.
Insert Sample Data: Populate tables with sample data.
Practice Queries: Write and execute  queries to retrieve and manipulate data.

Step 1: Define the Schema
Authors: Information about book authors.
Books: Details of books available in the bookstore.
Publishers: Information about the publishers of the books.
Customers: Details of customers.
Orders: Records of orders placed by customers.
Order_Items: Details of books in each order.

-- Step 2: Create the Database
-- Here's the  script to create the necessary tables and establish relationships:


-- Create table for Authors
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE
);

-- Create table for Publishers
CREATE TABLE publishers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255)
);

-- Create table for Books
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author_id INT REFERENCES authors(id),
    publisher_id INT REFERENCES publishers(id),
    publish_date DATE,
    price DECIMAL(10, 2)
);

-- Create table for Customers
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- Create table for Orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Create table for Order Items
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    book_id INT REFERENCES books(id),
    quantity INT,
    price DECIMAL(10, 2)
);


-- Step 3: Insert Sample Data
-- Populate the tables with sample data for practice:



-- Insert data into Authors
INSERT INTO authors (first_name, last_name, birthdate) VALUES
('George', 'Orwell', '1903-06-25'),
('J.K.', 'Rowling', '1965-07-31'),
('J.R.R.', 'Tolkien', '1892-01-03');

-- Insert data into Publishers
INSERT INTO publishers (name, address) VALUES
('Penguin Random House', 'New York, NY'),
('HarperCollins', 'London, UK'),
('Hachette Livre', 'Paris, France');

-- Insert data into Books
INSERT INTO books (title, author_id, publisher_id, publish_date, price) VALUES
('1984', 1, 1, '1949-06-08', 19.99),
('Harry Potter and the Sorcerer''s Stone', 2, 2, '1997-06-26', 24.99),
('The Hobbit', 3, 3, '1937-09-21', 14.99);

-- Insert data into Customers
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901'),
('Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012');

-- Insert data into Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-01-15', 34.98),
(2, '2023-01-20', 24.99),
(3, '2023-01-25', 14.99);

-- Insert data into Order Items
INSERT INTO order_items (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 19.99),
(1, 3, 1, 14.99),
(2, 2, 1, 24.99),
(3, 3, 1, 14.99);


-- Step 4: Practice Queries
-- Here are some practice queries to help you explore and manipulate the data:

-- Basic Queries

-- Retrieve all books and their authors:

SELECT books.title, authors.first_name, authors.last_name
FROM books
JOIN authors ON books.author_id = authors.id;

-- List all customers who placed orders:

SELECT DISTINCT customers.first_name, customers.last_name
FROM customers
JOIN orders ON customers.id = orders.customer_id;

-- Show all orders and their total amounts:

SELECT orders.id, customers.first_name, customers.last_name, orders.total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.id;
Aggregate Queries

-- Calculate the total sales amount:

SELECT SUM(total_amount) AS total_sales
FROM orders;

-- Find the most popular book (based on quantity sold):

SELECT books.title, SUM(order_items.quantity) AS total_sold
FROM order_items
JOIN books ON order_items.book_id = books.id
GROUP BY books.title
ORDER BY total_sold DESC
LIMIT 1;

-- Complex Queries

-- List all books that have not been ordered:

SELECT books.title
FROM books
LEFT JOIN order_items ON books.id = order_items.book_id
WHERE order_items.book_id IS NULL;

-- Find customers who have ordered more than one book:

SELECT customers.first_name, customers.last_name, COUNT(order_items.id) AS books_ordered
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
GROUP BY customers.first_name, customers.last_name
HAVING COUNT(order_items.id) > 1;

-- Retrieve the total number of books sold by each author:

SELECT authors.first_name, authors.last_name, SUM(order_items.quantity) AS total_sold
FROM authors
JOIN books ON authors.id = books.author_id
JOIN order_items ON books.id = order_items.book_id
GROUP BY authors.first_name, authors.last_name
ORDER BY total_sold DESC;


-- Update and Delete Queries
-- Update the price of a book:

UPDATE books
SET price = price * 1.10
WHERE id = 1;

-- Delete a customer who has not placed any orders:

DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);

-- Additional Course Practice Queries
-- Find the average price of books by each publisher:

SELECT publishers.name, AVG(books.price) AS average_price
FROM publishers
JOIN books ON publishers.id = books.publisher_id
GROUP BY publishers.name;

-- List all customers who ordered books published by a specific publisher:

SELECT DISTINCT customers.first_name, customers.last_name, publishers.name AS publisher
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN books ON order_items.book_id = books.id
JOIN publishers ON books.publisher_id = publishers.id
WHERE publishers.name = 'Penguin Random House';

-- Identify authors who have more than one book in the bookstore:

SELECT authors.first_name, authors.last_name, COUNT(books.id) AS book_count
FROM authors
JOIN books ON authors.id = books.author_id
GROUP BY authors.first_name, authors.last_name
HAVING COUNT(books.id) > 1;

-- This project provides a comprehensive overview of how to design, implement, and query a relational database in Postgre. It covers various aspects of database management, including schema creation, data manipulation, and complex query execution.