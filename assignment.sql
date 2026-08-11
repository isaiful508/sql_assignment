-- Active: 1785962553536@@127.0.0.1@5432@bookstore_db
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

SELECT * from customer;

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

SELECT * from orders;