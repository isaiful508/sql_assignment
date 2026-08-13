
CREATE TABLE books(
    id SERIAL PRIMARY KEY UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK(price > 0),
    stock INTEGER NOT NULL CHECK(stock >= 0),
    published_year DATE
)



INSERT INTO books (title, author, price, stock, published_year) VALUES
    ('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, '1999-10-20'),
    ('Clean Code', 'Robert C. Martin', 35.00, 5, '2008-08-01'),
    ('You Don''t Know JS', 'Kyle Simpson', 30.00, 8, '2014-01-28'),
    ('Refactoring', 'Martin Fowler', 50.00, 3, '1999-07-08'),
    ('Database Design Principles', 'Jane Smith', 20.00, 0, '2018-05-15')

SELECT * from books;

CREATE TABLE customer(
    id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(25) unique NOT NULL,
    joined_date DATE NOT NULL DEFAULT CURRENT_DATE
)

INSERT INTO customer (name, email, joined_date) VALUES
('Alice', 'alice@example.com', '2023-01-15'),
('Bob', 'bob@example.com', '2023-01-16'),
('Charlie', 'charlie@example.com', '2023-01-17')



CREATE TABLE orders(
    id SERIAL PRIMARY KEY UNIQUE,
    customer_id INTEGER NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    order_date DATE NOT NULL DEFAULT CURRENT_DATE
)

INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
(1, 2, 1, '2024-03-10'),
(2, 1, 1, '2024-02-20'),
(1, 3, 2, '2024-03-05')

select * from orders;

SELECT title from books where stock = 0;
    
SELECT * from books where price = (SELECT max(price) from books);
--  Find the total number of orders placed by each customer.

SELECT c.name, COUNT(o.id) as total_orders
FROM orders o
JOIN customer c ON o.customer_id = c.id
GROUP BY c.name;

-- Calculate the total revenue generated from book sales.
SELECT SUM(b.price * o.quantity) as total_revenue
FROM orders o
JOIN books b ON o.book_id = b.id;

-- List all customers who have placed more than one order.
SELECT c.name, COUNT(o.id) as order_count
FROM orders o
JOIN customer c ON o.customer_id = c.id
GROUP BY c.name
HAVING COUNT(o.id) > 1;

-- Find the average price of books in the store.
SELECT ROUND(AVG(b.price), 2) as avg_book_price
FROM books b;

-- Increase the price of all books published before 2000 by 10%.
UPDATE books
SET price = price * 1.10
WHERE published_year < '2000-01-01';

DELETE from customer as c where c.id NOT IN (SELECT customer_id from orders);