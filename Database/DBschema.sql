-- Create Database
CREATE DATABASE billbhai_retail_db;
USE billbhai_retail_db;

-- =========================
-- CUSTOMER
-- =========================
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    mobile_no VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    address TEXT
);

-- =========================
-- LOYALTY MEMBER
-- =========================
CREATE TABLE Loyalty_Member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNIQUE,
    points_balance INT DEFAULT 0,
    tier_level VARCHAR(50),
    joined_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- =========================
-- STAFF
-- =========================
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    role VARCHAR(50),
    email VARCHAR(100),
    mobile_no VARCHAR(15)
);

-- =========================
-- COMPANY
-- =========================
CREATE TABLE Company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(150),
    address TEXT,
    email VARCHAR(100),
    phone_no VARCHAR(15),
    gst_no VARCHAR(20) UNIQUE
);

-- =========================
-- SUPPLIER
-- =========================
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    mobile_no VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    gst_no VARCHAR(20)
);

-- =========================
-- PRODUCT
-- =========================
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    name VARCHAR(150),
    barcode VARCHAR(100) UNIQUE,
    category VARCHAR(100),
    price DECIMAL(10,2),
    size VARCHAR(50),
    description TEXT,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

-- =========================
-- INVENTORY
-- =========================
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT UNIQUE,
    stock_available INT,
    reorder_level INT,
    location VARCHAR(100),
    last_updated DATETIME,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- =========================
-- ORDERS
-- =========================
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    staff_id INT,
    order_date DATE,
    order_type VARCHAR(50),
    total_amount DECIMAL(10,2),
    checkout_mode VARCHAR(50),
    status VARCHAR(50),
    discount_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- =========================
-- DELIVERY
-- =========================
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    partner_name VARCHAR(100),
    dispatch_date DATE,
    delivery_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =========================
-- BILL
-- =========================
CREATE TABLE Bill (
    bill_no INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE,
    bill_date DATE,
    tax_amount DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =========================
-- PAYMENT
-- =========================
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_no INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (bill_no) REFERENCES Bill(bill_no)
);

-- =========================
-- INVOICE
-- =========================
CREATE TABLE Invoice (
    invoice_no INT PRIMARY KEY AUTO_INCREMENT,
    bill_no INT UNIQUE,
    invoice_date DATE,
    invoice_status VARCHAR(50),
    FOREIGN KEY (bill_no) REFERENCES Bill(bill_no)
);

-- =========================
-- RETURN
-- =========================
CREATE TABLE Return_Order (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    return_date DATE,
    reason TEXT,
    refund_amount DECIMAL(10,2),
    status VARCHAR(50),
    return_type VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =========================
-- REPORT
-- =========================
CREATE TABLE Report (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    report_type VARCHAR(100),
    generated_by INT,
    generated_at DATETIME,
    period_from DATE,
    period_to DATE,
    FOREIGN KEY (generated_by) REFERENCES Staff(staff_id)
);