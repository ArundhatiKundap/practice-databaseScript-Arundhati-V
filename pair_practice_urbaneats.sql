-- Start Transaction
START TRANSACTION;
-- create database --branchmenu
CREATE DATABASE IF NOT EXISTS UrbanEats;
USE UrbanEats;

-- Drop tables in reverse order of dependencies
DROP TABLE IF EXISTS OrderInvoice;
DROP TABLE IF EXISTS BranchMenu;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS GeneralMenu;
DROP TABLE IF EXISTS Location;

-- Create Location table
CREATE TABLE Location (
    zip_code VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100),
    branch_address VARCHAR(255),
    branch_phone VARCHAR(20)
);

-- Create GeneralMenu table
CREATE TABLE GeneralMenu (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_description TEXT,
    is_vegetarian BOOLEAN
);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    zip_code VARCHAR(10),
    FOREIGN KEY (zip_code) REFERENCES Location(zip_code)
);

-- Create BranchMenu table
CREATE TABLE BranchMenu (
    branch_menu_id INT PRIMARY KEY,
    zip_code VARCHAR(10),
    item_id INT,
    price DECIMAL(5,2),
    available_status BOOLEAN,
    FOREIGN KEY (zip_code) REFERENCES Location(zip_code),
    FOREIGN KEY (item_id) REFERENCES GeneralMenu(item_id)
);

-- Create OrderInvoice table
CREATE TABLE OrderInvoice (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    zip_code VARCHAR(10),
    order_date DATE,
    total_amount DECIMAL(8,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (zip_code) REFERENCES Location(zip_code)
);

-- Insert sample data into Location
INSERT INTO Location (zip_code, branch_name, branch_address, branch_phone) VALUES
('10001', 'Urban Eats Downtown', '123 Main St, City Center', '123-456-7890'),
('10002', 'Urban Eats Uptown', '456 High St, Uptown', '987-654-3210');

-- Insert sample data into GeneralMenu
INSERT INTO GeneralMenu (item_id, item_name, item_description, is_vegetarian) VALUES
(1, 'Veggie Burger', 'Grilled veggie patty with lettuce and tomato', TRUE),
(2, 'Chicken Wrap', 'Spicy chicken wrap with sauce', FALSE),
(3, 'Caesar Salad', 'Classic salad with croutons and cheese', TRUE);

-- Insert sample data into Customer
INSERT INTO Customer (customer_id, name, email, phone, zip_code) VALUES
(101, 'Alice Smith', 'alice@example.com', '111-222-3333', '10001'),
(102, 'Bob Johnson', 'bob@example.com', '444-555-6666', '10002');

-- Insert sample data into BranchMenu
INSERT INTO BranchMenu (branch_menu_id, zip_code, item_id, price, available_status) VALUES
(1, '10001', 1, 7.99, TRUE),
(2, '10001', 2, 8.99, TRUE),
(3, '10002', 1, 7.49, TRUE),
(4, '10002', 3, 6.99, FALSE);

-- Insert sample data into OrderInvoice
INSERT INTO OrderInvoice (customer_id, zip_code, order_date, total_amount, status) VALUES
(101, '10001', '2025-07-07', 16.98, 'Completed'),
(102, '10002', '2025-07-06', 14.48, 'Pending');

-- Commit Transaction
COMMIT;
