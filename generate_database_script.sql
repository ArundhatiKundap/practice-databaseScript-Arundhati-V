-- Start transaction
START TRANSACTION;

CREATE DATABASE IF NOT EXISTS product_db;
USE product_db;

-- Drop tables if they exist (drop child tables first)
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

-- Create 'categories' table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create 'products' table with foreign key to 'categories'
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category_id INT,
    price DECIMAL(5,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create 'suppliers' table with foreign key to 'products'
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    product_id INT,
    location VARCHAR(100),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into 'categories'
INSERT INTO categories (name) VALUES
('Fruits'),
('Vegetables'),
('Leafy Vegetables');

-- Insert data into 'products'
INSERT INTO products (name, category_id, price) VALUES
('Mango', 1, 1.50),
('Carrot', 2, 0.80),
('Spinach', 3, 1.20);

-- Insert data into 'suppliers'
INSERT INTO suppliers (name, product_id, location) VALUES
('Fresh Farms', 1, 'Florida'),
('Green Valley', 2, 'California'),
('Leafy Love', 3, 'Washington');

-- Commit transaction
COMMIT;
