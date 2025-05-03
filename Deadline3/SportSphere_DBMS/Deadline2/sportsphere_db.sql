-- Drop existing database
DROP DATABASE IF EXISTS sports_store_db;

-- Create database and use it
CREATE DATABASE sports_store_db;
USE sports_store_db;

-- Create tables (as per your schema)
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    age INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone_number BIGINT UNIQUE NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(2) NOT NULL,
    pincode INT NOT NULL,
    dob DATE,
    registration_date DATE,
    loyalty_point INT DEFAULT 0
);

CREATE TABLE Admin (
    Admin_ID INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE DeliveryAgent (
    DeliveryAgent_ID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    registration_date DATE,
    availability_status ENUM('Available', 'Busy', 'On Leave') DEFAULT 'Available'
);

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Brand (
    Brand_ID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    Brand_ID INT,
    Category_ID INT,
    FOREIGN KEY (Brand_ID) REFERENCES Brand(Brand_ID) ON DELETE SET NULL,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID) ON DELETE SET NULL
);

CREATE TABLE Shopping_cart (
    Cart_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    created_date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

CREATE TABLE CartItem (
    CartItem_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_ID INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    Cart_ID INT,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE,
    FOREIGN KEY (Cart_ID) REFERENCES Shopping_cart(Cart_ID) ON DELETE CASCADE
);

CREATE TABLE Review (
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

CREATE TABLE PhysicalStore (
    Store_ID INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pincode INT NOT NULL
);

CREATE TABLE Available_in (
    Store_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Store_ID) REFERENCES PhysicalStore(Store_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

CREATE TABLE orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    DeliveryAgent_ID INT NOT NULL,
    date DATE,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    address VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (DeliveryAgent_ID) REFERENCES DeliveryAgent(DeliveryAgent_ID) ON DELETE CASCADE
);

CREATE TABLE OrderItem (
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10,2) NOT NULL CHECK (price_at_purchase >= 0),
    status VARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

CREATE TABLE Payment (
    Order_ID INT NOT NULL,
    date DATE,
    amount DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (amount >= 0),
    method VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE
);

CREATE TABLE Shipping (
    Order_ID INT NOT NULL,
    address VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Processing',
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE
);

CREATE TABLE Manages (
    Admin_ID INT NOT NULL,
    Store_ID INT NOT NULL,
    FOREIGN KEY (Store_ID) REFERENCES PhysicalStore(Store_ID) ON DELETE CASCADE,
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE
);

CREATE TABLE InCharges (
    DeliveryAgent_ID INT NOT NULL,
    Store_ID INT NOT NULL,
    FOREIGN KEY (DeliveryAgent_ID) REFERENCES DeliveryAgent(DeliveryAgent_ID) ON DELETE CASCADE,
    FOREIGN KEY (Store_ID) REFERENCES PhysicalStore(Store_ID) ON DELETE CASCADE
);

