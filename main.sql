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
    Brand_ID INT,
    Category_ID INT,
    FOREIGN KEY (Brand_ID) REFERENCES Brand(Brand_ID) ON DELETE SET NULL,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID) ON DELETE SET NULL
);

CREATE TABLE orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    DeliveryAgent_ID INT NOT NULL,
    date DATE,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    address VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (DeliveryAgent_ID) REFERENCES DeliveryAgent(DeliveryAgent_ID) ON DELETE CASCADE
);

CREATE TABLE Product_Review (
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

CREATE TABLE Delivery_Review (
    Order_ID INT NOT NULL,
    DeliveryAgent_ID INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (DeliveryAgent_ID) REFERENCES DeliveryAgent(DeliveryAgent_ID) ON DELETE CASCADE
);

CREATE TABLE PhysicalStore (
    Store_ID INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pincode INT NOT NULL
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

CREATE TABLE Adds_to_cart (
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity >= 1),
    PRIMARY KEY (Customer_ID, Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

CREATE TABLE OrderItem (
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity >= 1),
    price_at_purchase DECIMAL(10,2) NOT NULL CHECK (price_at_purchase >= 0),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

CREATE TABLE Available_in (
    Store_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    store_quantity INT NOT NULL DEFAULT 0 CHECK (store_quantity >= 0), 
    FOREIGN KEY (Store_ID) REFERENCES PhysicalStore(Store_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

INSERT INTO Admin (email, password)
VALUES
('turbold@example.com', 'adminpass1'),
('tung@example.com', 'adminpass2'),
('gaurav@example.com', 'adminpass3'),
('aditya@example.com', 'adminpass4');

-- Customers (Indian)
INSERT INTO Customer (first_name, last_name, age, email, password, phone_number, street, city, state, pincode, dob, registration_date, loyalty_point)
VALUES
('Aarav', 'Patel', 28, 'aarav.patel@example.com', 'pass123', 9123456780, 'Linking Road', 'Mumbai', 'MH', 400052, '1995-03-15', '2023-01-01', 100),
('Ananya', 'Sharma', 26, 'ananya.sharma@example.com', 'ananya456', 9123456781, 'Marine Drive', 'Mumbai', 'MH', 400002, '1997-05-20', '2023-01-02', 150),
('Rohan', 'Singhania', 32, 'rohan.s@example.com', 'rohan789', 9123456782, 'Connaught Place', 'Delhi', 'DL', 110001, '1991-08-12', '2023-01-03', 200),
('Priyanka', 'Reddy', 29, 'priyanka.reddy@example.com', 'priyaPass', 9123456783, 'Jubilee Hills', 'Hyderabad', 'TS', 500033, '1994-02-28', '2023-01-04', 75),
('Vikram', 'Joshi', 35, 'vikram.joshi@example.com', 'vikramJ', 9123456784, 'Koramangala', 'Bengaluru', 'KA', 560034, '1988-11-05', '2023-01-05', 300),
('Neha', 'Gupta', 27, 'neha.gupta@example.com', 'nehaG2023', 9123456785, 'Banjara Hills', 'Hyderabad', 'TS', 500034, '1996-07-19', '2023-01-06', 120),
('Arjun', 'Kapoor', 31, 'arjun.kapoor@example.com', 'arjunK123', 9123456786, 'Park Street', 'Kolkata', 'WB', 700016, '1992-09-25', '2023-01-07', 180),
('Ishaan', 'Chopra', 26, 'ishaan.c@example.com', 'ishaanSecure', 9123456787, 'Salt Lake City', 'Kolkata', 'WB', 700091, '1997-04-14', '2023-01-08', 90),
('Aditya', 'Verma', 34, 'aditya.verma@example.com', 'adityaVPass', 9123456788, 'Koregaon Park', 'Pune', 'MH', 411001, '1989-12-01', '2023-01-09', 250),
('Sneha', 'Mishra', 28, 'sneha.mishra@example.com', 'snehaM789', 9123456789, 'FC Road', 'Pune', 'MH', 411004, '1995-06-30', '2023-01-10', 160),
('Rahul', 'Srinivasan', 29, 'rahul.s@example.com', 'rahulSrin', 9123456790, 'T Nagar', 'Chennai', 'TN', 600017, '1994-03-22', '2023-01-11', 140),
('Divya', 'Menon', 25, 'divya.menon@example.com', 'divyaM123', 9123456791, 'Boat Club Road', 'Chennai', 'TN', 600006, '1998-08-15', '2023-01-12', 110),
('Rajesh', 'Mehta', 37, 'rajesh.mehta@example.com', 'rajeshM', 9123456792, 'C Scheme', 'Jaipur', 'RJ', 302001, '1986-10-10', '2023-01-13', 400),
('Kavita', 'Yadav', 26, 'kavita.yadav@example.com', 'kavitaY', 9123456793, 'Tonk Road', 'Jaipur', 'RJ', 302015, '1997-01-05', '2023-01-14', 95),
('Sanjay', 'Malhotra', 33, 'sanjay.m@example.com', 'sanjayM', 9123456794, 'Sector 17', 'Chandigarh', 'CH', 160017, '1990-07-07', '2023-01-15', 220),
('Anjali', 'Khanna', 28, 'anjali.khanna@example.com', 'anjaliK', 9123456795, 'Sector 34', 'Chandigarh', 'CH', 160034, '1995-02-18', '2023-01-16', 170),
('Vivek', 'Bhatia', 30, 'vivek.bhatia@example.com', 'vivekB', 9123456796, 'Gomti Nagar', 'Lucknow', 'UP', 226010, '1993-04-09', '2023-01-17', 190),
('Shweta', 'Saxena', 27, 'shweta.saxena@example.com', 'shwetaS', 9123456797, 'Hazratganj', 'Lucknow', 'UP', 226001, '1996-11-23', '2023-01-18', 130),
('Nitin', 'Agarwal', 36, 'nitin.agarwal@example.com', 'nitinA', 9123456798, 'SG Highway', 'Ahmedabad', 'GJ', 380054, '1987-05-16', '2023-01-19', 280),
('Pooja', 'Trivedi', 25, 'pooja.trivedi@example.com', 'poojaT', 9123456799, 'Law Garden', 'Ahmedabad', 'GJ', 380006, '1998-09-30', '2023-01-20', 105),
('Ravi', 'Nair', 31, 'ravi.nair@example.com', 'raviN', 9123456800, 'MG Road', 'Kochi', 'KL', 682011, '1992-12-24', '2023-01-21', 210),
('Lakshmi', 'Pillai', 26, 'lakshmi.pillai@example.com', 'lakshmiP', 9123456801, 'Marine Drive', 'Kochi', 'KL', 682031, '1997-03-19', '2023-01-22', 115),
('Amit', 'Deshpande', 34, 'amit.desh@example.com', 'amitDesh', 9123456802, 'Civil Lines', 'Nagpur', 'MH', 440001, '1989-06-12', '2023-01-23', 240),
('Shilpa', 'Rao', 29, 'shilpa.rao@example.com', 'shilpaR', 9123456803, 'Wardha Road', 'Nagpur', 'MH', 440025, '1994-08-07', '2023-01-24', 175),
('Karan', 'Thakur', 32, 'karan.thakur@example.com', 'karanT', 9123456804, 'Dalhousie Square', 'Kolkata', 'WB', 700001, '1991-09-14', '2023-01-25', 195),
('Deepika', 'Venkatesan', 27, 'deepika.v@example.com', 'deepikaV', 9123456805, 'Palace Road', 'Mysuru', 'KA', 570001, '1996-04-02', '2023-01-26', 125),
('Rajiv', 'Choudhury', 35, 'rajiv.choudhury@example.com', 'rajivC', 9123456806, 'Ballygunge', 'Kolkata', 'WB', 700019, '1988-10-31', '2023-01-27', 260),
('Sunita', 'Prasad', 28, 'sunita.prasad@example.com', 'sunitaP', 9123456807, 'Fraser Road', 'Patna', 'BR', 800001, '1995-07-18', '2023-01-28', 155),
('Vishal', 'Seth', 30, 'vishal.seth@example.com', 'vishalS', 9123456808, 'Boring Road', 'Patna', 'BR', 800023, '1993-02-09', '2023-01-29', 185),
('Anika', 'Ranganathan', 25, 'anika.r@example.com', 'anikaR', 9123456809, 'Race Course Road', 'Coimbatore', 'TN', 641018, '1998-05-21', '2023-01-30', 135),
('Rohit', 'Pandey', 29, 'rohit.pandey@example.com', 'rohitP@123', 9123456810, 'Aundh Road', 'Pune', 'MH', 411007, '1994-01-15', '2023-01-31', 150),
('Meera', 'Kulkarni', 32, 'meera.k@example.com', 'meeraKsecure', 9123456811, 'Baner Road', 'Pune', 'MH', 411045, '1991-03-02', '2023-02-01', 180),
('Aakash', 'Mishra', 28, 'aakash.mishra@example.com', 'aakashM', 9123456812, 'DLF Cyber City', 'Gurgaon', 'HR', 122002, '1995-04-20', '2023-02-02', 125),
('Snehal', 'Desai', 26, 'snehal.desai@example.com', 'snehalD', 9123456813, 'MG Road', 'Surat', 'GJ', 395003, '1997-06-12', '2023-02-03', 110),
('Manish', 'Verma', 35, 'manish.verma@example.com', 'manishV@123', 9123456814, 'Rajpur Road', 'Dehradun', 'UK', 248001, '1988-09-09', '2023-02-04', 300),
('Ritika', 'Arora', 24, 'ritika.arora@example.com', 'ritikaA', 9123456815, 'Sector 21', 'Gurgaon', 'HR', 122015, '1999-05-18', '2023-02-05', 105),
('Anurag', 'Singh', 30, 'anurag.singh@example.com', 'anuragS', 9123456816, 'Golf Course Road', 'Noida', 'UP', 201309, '1993-02-24', '2023-02-06', 200),
('Preeti', 'Nair', 27, 'preeti.nair@example.com', 'preetiN2023', 9123456817, 'Technopark', 'Trivandrum', 'KL', 695581, '1996-07-07', '2023-02-07', 130),
('Kunal', 'Rao', 33, 'kunal.rao@example.com', 'kunalRsecure', 9123456818, 'Race Course Road', 'Dehradun', 'UK', 248003, '1990-08-15', '2023-02-08', 195),
('Tanvi', 'Ghosh', 25, 'tanvi.ghosh@example.com', 'tanviG', 9123456819, 'Salt Lake Sector V', 'Kolkata', 'WB', 700091, '1998-04-05', '2023-02-09', 160),
('Ishan', 'Puri', 28, 'ishan.puri@example.com', 'ishanP', 9123456820, 'Civil Lines', 'Kanpur', 'UP', 208001, '1995-01-29', '2023-02-10', 140),
('Aditi', 'Shetty', 30, 'aditi.shetty@example.com', 'aditiS', 9123456821, 'Brigade Road', 'Bengaluru', 'KA', 560025, '1993-03-08', '2023-02-11', 180),
('Yash', 'Agarwal', 26, 'yash.agarwal@example.com', 'yashA', 9123456822, 'Malviya Nagar', 'Jaipur', 'RJ', 302017, '1997-10-14', '2023-02-12', 90),
('Harsha', 'Rangan', 31, 'harsha.rangan@example.com', 'harshaR', 9123456823, 'Ambattur', 'Chennai', 'TN', 600053, '1992-06-23', '2023-02-13', 170),
('Payal', 'Kapoor', 29, 'payal.kapoor@example.com', 'payalK@secure', 9123456824, 'Shastri Nagar', 'Meerut', 'UP', 250004, '1994-11-12', '2023-02-14', 115),
('Abhishek', 'Jain', 34, 'abhishek.jain@example.com', 'abhishekJ', 9123456825, 'Jawahar Nagar', 'Bhopal', 'MP', 462003, '1989-12-03', '2023-02-15', 270),
('Sanya', 'Mehta', 25, 'sanya.mehta@example.com', 'sanyaM123', 9123456826, 'RNT Marg', 'Indore', 'MP', 452001, '1998-09-22', '2023-02-16', 125),
('Mohit', 'Khare', 30, 'mohit.khare@example.com', 'mohitK', 9123456827, 'Alkapuri', 'Vadodara', 'GJ', 390007, '1993-07-13', '2023-02-17', 190),
('Shruti', 'Patil', 28, 'shruti.patil@example.com', 'shrutiP', 9123456828, 'Kothrud', 'Pune', 'MH', 411038, '1995-05-01', '2023-02-18', 140),
('Vimal', 'Chauhan', 36, 'vimal.chauhan@example.com', 'vimalC', 9123456829, 'Paldi', 'Ahmedabad', 'GJ', 380007, '1987-11-26', '2023-02-19', 290);

-- Delivery Agents (Indian)
INSERT INTO DeliveryAgent (first_name, last_name, age, email, password, phone_number, date_of_birth, registration_date, availability_status)
VALUES
('Rahul', 'Sharma', 27, 'rahul.sharma@delivery.com', 'rahulPass', '9876543210', '1996-08-14', '2023-02-01', 'Available'),
('Priyanka', 'Singh', 25, 'priyanka.singh@delivery.com', 'priyankaPass', '9876543211', '1998-03-21', '2023-02-02', 'Busy'),
('Amit', 'Kumar', 30, 'amit.kumar@delivery.com', 'amitPass', '9876543212', '1993-11-05', '2023-02-03', 'Available'),
('Ravi', 'Verma', 28, 'ravi.verma@delivery.com', 'raviPass', '9876543213', '1995-07-12', '2023-02-04', 'Available'),
('Sneha', 'Yadav', 26, 'sneha.yadav@delivery.com', 'snehaPass', '9876543214', '1997-09-18', '2023-02-05', 'On Leave'),
('Vikram', 'Singh', 32, 'vikram.singh@delivery.com', 'vikramPass', '9876543215', '1991-04-25', '2023-02-06', 'Available'),
('Anjali', 'Gupta', 29, 'anjali.gupta@delivery.com', 'anjaliPass', '9876543216', '1994-12-30', '2023-02-07', 'Busy'),
('Rajesh', 'Patel', 34, 'rajesh.patel@delivery.com', 'rajeshPass', '9876543217', '1989-06-15', '2023-02-08', 'Available'),
('Kavita', 'Joshi', 27, 'kavita.joshi@delivery.com', 'kavitaPass', '9876543218', '1996-03-22', '2023-02-09', 'Available'),
('Arjun', 'Reddy', 31, 'arjun.reddy@delivery.com', 'arjunPass', '9876543219', '1992-11-08', '2023-02-10', 'Busy'),
('Pooja', 'Desai', 25, 'pooja.desai@delivery.com', 'poojaPass', '9876543220', '1998-05-19', '2023-02-11', 'Available'),
('Nitin', 'Mehta', 33, 'nitin.mehta@delivery.com', 'nitinPass', '9876543221', '1990-08-14', '2023-02-12', 'On Leave'),
('Deepak', 'Rao', 30, 'deepak.rao@delivery.com', 'deepakPass', '9876543222', '1993-02-28', '2023-02-13', 'Available'),
('Manish', 'Sharma', 28, 'manish.sharma@delivery.com', 'manishPass', '9876543230', '1996-10-12', '2023-02-14', 'Available'),
('Meena', 'Kaur', 26, 'meena.kaur@delivery.com', 'meenaPass', '9876543231', '1997-01-05', '2023-02-15', 'Busy'),
('Harish', 'Verma', 31, 'harish.verma@delivery.com', 'harishPass', '9876543232', '1992-07-21', '2023-02-16', 'Available');

INSERT INTO Category (Category_ID, name) VALUES
(001, 'Clothing'),
(002, 'Shoes'),
(003, 'Protective Gear'),
(004, 'Bags & Backpacks'),
(005, 'Equipment'),
(006, 'Accessories'),
(007, 'Outdoor & Adventure Gear');


INSERT INTO Brand (Brand_ID, name, description) VALUES
(001, 'StrikerX', 'Global sports brand known for quality gear'),
(002, 'AeroSwift', 'Popular athletic brand with innovative designs'),
(003, 'TitanForge', 'Known for fitness and gym equipment'),
(004, 'VortexEdge', 'Athletic and lifestyle footwear and apparel'),
(005, 'HydraFit', 'Leading brand for swimming gear'),
(006, 'GladiatorPro', 'Boxing and combat sports equipment'),
(007, 'PeakTrail', 'Outdoor and trekking equipment specialists');


-- Products
INSERT INTO Product (Product_ID, name, description, price, Brand_ID, Category_ID) VALUES
(001, 'Compression Tights', 'Breathable, stretch-fit running tights', 49.99, 002, 001),
(002, 'Running Shorts', 'Lightweight shorts for high-speed running', 29.99, 002, 001),
(003, 'Sweat-Wicking T-Shirt', 'Keeps you dry during intense workouts', 24.99, 002, 001),
(004, 'Soccer Jersey', 'Pro-fit soccer jersey with moisture control', 39.99, 001, 001),
(005, 'Goalkeeper Jersey', 'Padded goalkeeper jersey with added protection', 44.99, 001, 001),
(006, 'Wetsuit', 'High-durability wetsuit for swimming & surfing', 89.99, 005, 001),
(007, 'Hiking Jacket', 'Waterproof, wind-resistant hiking jacket', 79.99, 007, 001),
(008, 'Road Running Shoes', 'Ultra-light running shoes for speed', 119.99, 002, 002),
(009, 'Trail Running Shoes', 'Designed for rough outdoor trails', 119.99, 002, 002),
(010, 'Firm Ground Soccer Cleats', 'Optimum grip soccer cleats for firm surfaces', 89.99, 001, 003),
(011, 'Goalkeeper Gloves', 'Extra traction and durability for keepers', 79.99, 001, 003),
(012, 'Waterproof Hiking Boots', 'All-terrain, weatherproof boots', 129.99, 007, 001),
(013, 'Running Sunglasses', 'UV-protected lightweight running glasses', 34.99, 002, 006),
(014, 'Skate Helmet', 'Impact-resistant helmet for extreme sports', 59.99, 004, 003),
(015, 'Boxing Mouthguard', 'Shock-absorbing mouthguard for combat sports', 19.99, 006, 003),
(016, 'Weightlifting Belt', 'Supports lower back during heavy lifts', 46.59, 003, 003),
(017, 'Knee Sleeves', 'Reduces joint stress and improves stability', 29.99, 003, 003),
(018, 'Hydration Backpack', 'Lightweight pack with built-in water reservoir', 49.99, 007, 004),
(019, 'Soccer Boot Bag', 'Durable bag for carrying cleats and gear', 25.99, 001, 004),
(020, 'MMA Gear Bag', 'Spacious gym bag for fighters', 54.99, 006, 004),
(021, 'Adjustable Dumbbells', 'Compact, space-saving dumbbell set', 179.59, 003, 005),
(022, 'Olympic Barbell', 'Professional-grade weightlifting bar', 149.99, 003, 005),
(023, 'Punching Bag', 'Heavy-duty punching bag for boxing training', 129.99, 006, 005),
(024, 'Speed Bag', 'Improves reflexes and striking speed', 49.99, 006, 005),
(025, 'Professional Soccer Ball', 'Official match ball', 34.99, 001, 005),
(026, 'Kickboard', 'Training aid for improving swimming techniques', 29.99, 005, 005),
(027, 'Trekking Poles', 'Lightweight and adjustable hiking poles', 39.99, 007, 006),
(028, 'Waterproof Phone Case', 'Protects your phone while swimming or kayaking', 18.99, 005, 006),
(029, 'Compression Arm Sleeves', 'Provides muscle support and enhances circulation', 14.99, 002, 006),
(030, 'Trekking Lantern', 'Rechargeable lantern for night camping', 29.99, 007, 007),
(031, 'Sleeping Bag', 'Lightweight and warm for all seasons', 79.99, 007, 007),
(032, 'Camping Stove', 'Compact and fuel-efficient outdoor stove', 59.99, 007, 007),
(033, 'Diving Mask', 'Anti-fog, wide-view diving mask', 49.99, 005, 007),
(034, 'Snorkel', 'Ergonomic and easy-breath snorkel tube', 19.99, 005, 007),
(035, 'Skateboard', 'Pro-quality skateboard for street and park', 88.99, 004, 005),
(036, 'BMX Frame', 'Lightweight and durable BMX frame for stunts', 149.59, 004, 005),
(037, 'Snowboard', 'High-performance snowboard for all conditions', 199.49, 004, 005),
(038, 'Survival Whistle', 'Emergency whistle with built-in compass', 19.99, 007, 006),
(039, 'CrossFit Bag', 'Versatile training bag for all gym needs', 64.89, 006, 004),
(040, 'Yoga Mat Bag', 'Compact bag to carry your yoga essentials', 29.99, 002, 004),
(041, 'Water Bottle', 'BPA-free sports bottle with cooling insulation', 14.99, 002, 006),
(042, 'Football Gloves', 'Enhanced grip gloves for football players', 34.99, 001, 003),
(043, 'Baseball Bat', 'Lightweight yet powerful bat for home runs', 79.99, 004, 005),
(044, 'Gymnastics Rings', 'Adjustable rings for strength training', 49.99, 003, 005),
(045, 'Climbing Rope', 'Durable, high-tension rope for rock climbing', 59.99, 007, 007),
(046, 'Soccer Shin Guards', 'Lightweight yet protective shin guards', 19.99, 001, 003),
(047, 'Foldable Camping Chair', 'Compact and durable chair for outdoor trips', 39.99, 007, 007),
(048, 'Tennis Racket', 'High-performance racket for professional play', 129.99, 004, 005),
(049, 'Ski Goggles', 'Anti-fog and UV-protected ski goggles', 59.99, 004, 005),
(050, 'Portable Air Pump', 'Compact air pump for balls and inflatables', 24.99, 002, 006);

INSERT INTO PhysicalStore (location, city, state, pincode)  
VALUES  
('Phoenix Marketcity', 'Mumbai', 'MH', 400059),  
('Forum Mall', 'Bengaluru', 'KA', 560029),  
('South City Mall', 'Kolkata', 'WB', 700068),  
('Ambience Mall', 'Gurgaon', 'HR', 122002),  
('Select Citywalk', 'New Delhi', 'DL', 110017),  
('Lulu Mall', 'Kochi', 'KL', 682024),  
('Express Avenue', 'Chennai', 'TN', 600002),  
('Elante Mall', 'Chandigarh', 'CH', 160002);  


INSERT INTO orders (Customer_ID, DeliveryAgent_ID, date, total_price, address, status)
VALUES
(1, 1, '2024-01-10', 169.98, 'Linking Road, Mumbai, MH 400052', 'Delivered'),
(3, 2, '2024-01-15', 24.99, 'Connaught Place, Delhi 110001', 'Delivered'),
(2, 3, '2024-01-22', 59.90, 'MG Road, Bengaluru, KA 560001', 'Delivered'),
(4, 1, '2024-01-28', 89.99, 'Park Street, Kolkata, WB 700016', 'Delivered'),
(5, 4, '2024-02-02', 129.90, 'Banjara Hills, Hyderabad, TS 500034', 'Delivered'),
(3, 2, '2024-02-08', 39.99, 'Connaught Place, Delhi 110001', 'Delivered'),
(6, 5, '2024-02-12', 74.99, 'Anna Nagar, Chennai, TN 600040', 'Delivered'),
(7, 6, '2024-02-18', 199.99, 'Andheri West, Mumbai, MH 400058', 'Delivered'),
(8, 3, '2024-02-22', 159.98, 'Jayanagar, Bengaluru, KA 560011', 'Delivered'),
(9, 7, '2024-02-26', 104.97, 'Salt Lake City, Kolkata, WB 700091', 'Delivered'),
(10, 4, '2024-03-01', 59.99, 'DLF Phase 2, Gurgaon, HR 122002', 'Shipped'),
(11, 1, '204-03-05', 49.99, 'Sector 17, Chandigarh, CH 160017', 'Processing'),
(12, 6, '2024-03-07', 89.95, 'Kukatpally, Hyderabad, TS 500072', 'Shipped'),
(13, 5, '2024-03-10', 129.99, 'T. Nagar, Chennai, TN 600017', 'Delivered'),
(14, 2, '2024-03-12', 64.95, 'MG Road, Pune, MH 411001', 'Processing'),
(15, 7, '2024-03-15', 74.99, 'Hazratganj, Lucknow, UP 226001', 'Processing'),
(16, 8, '2024-03-17', 299.94, 'Sector 62, Noida, UP 201301', 'Shipped'),
(17, 3, '2024-03-19', 159.90, 'Indiranagar, Bengaluru, KA 560038', 'Processing'),
(18, 4, '2024-03-20', 59.99, 'Lajpat Nagar, Delhi 110024', 'Shipped'),
(19, 5, '2024-03-21', 109.99, 'Viman Nagar, Pune, MH 411014', 'Delivered');


INSERT INTO Product_Review (Customer_ID, Product_ID, rating, comment, review_date) 
VALUES
(1, 10, 5, 'Amazing product! Highly recommend.', '2024-02-01'),
(1, 20, 4, 'Good quality, but shipping was slow.', '2024-02-02'),
(1, 5, 3, 'Average product, nothing special.', '2024-02-03'),
(4, 15, 2, 'Not satisfied, expected better.', '2024-02-04'),
(5, 25, 5, 'Exceeded my expectations!', '2024-02-05'),
(6, 30, 4, 'Very useful, worth the price.', '2024-02-06'),
(7, 40, 1, 'Defective item, very disappointed.', '2024-02-07'),
(2, 10, 5, 'Fantastic product, will buy again.', '2024-02-08'),
(2, 20, 3, 'Okay for the price.', '2024-02-09'),
(10, 22, 4, 'Nice design, works well.', '2024-02-10'),
(11, 32, 2, 'Not as described, poor quality.', '2024-02-11'),
(12, 42, 5, 'Superb! Love it.', '2024-02-12'),
(13, 8, 3, 'Decent but not great.', '2024-02-13'),
(14, 18, 4, 'Meets expectations, good buy.', '2024-02-14'),
(15, 28, 1, 'Worst purchase ever.', '2024-02-15'),
(16, 28, 5, 'Outstanding quality!', '2024-02-16'),
(17, 28, 3, 'Could be better.', '2024-02-17'),
(18, 9, 4, 'Good but a little expensive.', '2024-02-18'),
(19, 19, 2, 'Disappointed, not worth it.', '2024-02-19'),
(20, 29, 5, 'Perfect! Highly recommended.', '2024-02-20'),
(25, 39, 4, 'Nice and sturdy.', '2024-02-21'),
(25, 49, 3, 'Works fine, but not impressive.', '2024-02-22'),
(25, 7, 2, 'Poor quality, not recommended.', '2024-02-23'),
(25, 17, 5, 'Absolutely love it!', '2024-02-24'),
(25, 27, 4, 'Pretty good overall.', '2024-02-25');

INSERT INTO Delivery_Review (Order_ID, DeliveryAgent_ID, rating, comment, review_date) VALUES
(1, 3, 5, 'Excellent service!', '2024-03-01'),
(2, 7, 4, 'Quick delivery, but packaging could be better.', '2024-03-02'),
(3, 12, 3, 'Late delivery, but the agent was polite.', '2024-03-03'),
(4, 5, 5, 'Fast and friendly!', '2024-03-04'),
(5, 14, 2, 'Delivery was delayed.', '2024-03-05'),
(6, 8, 4, 'Good service overall.', '2024-03-06'),
(7, 1, 5, 'Perfect timing!', '2024-03-07'),
(8, 9, 3, 'Agent was confused about the address.', '2024-03-08'),
(9, 6, 4, 'Came earlier than expected.', '2024-03-09'),
(10, 11, 5, 'Very polite and professional.', '2024-03-10'),
(11, 16, 1, 'Order was damaged.', '2024-03-11'),
(12, 4, 2, 'Too slow.', '2024-03-12'),
(13, 13, 5, 'Best delivery experience!', '2024-03-13'),
(14, 2, 3, 'Mediocre service.', '2024-03-14'),
(15, 10, 4, 'Satisfied with the delivery.', '2024-03-15');

-- Relational tables

INSERT INTO Available_in (Store_ID, Product_ID, store_quantity) 
VALUES
-- Phoenix Marketcity (Mumbai) - 50 products
(1, 1, 10), (1, 2, 14), (1, 3, 16), (1, 4, 10), (1, 5, 17), 
(1, 6, 10), (1, 7, 11), (1, 8, 20), (1, 9, 12), (1, 10, 20), 
(1, 11, 20), (1, 12, 16), (1, 13, 16), (1, 14, 16), (1, 15, 16), 
(1, 16, 17), (1, 17, 12), (1, 18, 18), (1, 19, 10), (1, 20, 20), 
(1, 21, 11), (1, 22, 17), (1, 23, 14), (1, 24, 17), (1, 25, 10), 
(1, 26, 10), (1, 27, 20), (1, 28, 15), (1, 29, 10), (1, 30, 10), 
(1, 31, 17), (1, 32, 15), (1, 33, 18), (1, 34, 20), (1, 35, 13), 
(1, 36, 13), (1, 37, 18), (1, 38, 19), (1, 39, 14), (1, 40, 12), 
(1, 41, 12), (1, 42, 16), (1, 43, 11), (1, 44, 15), (1, 45, 14), 
(1, 46, 19), (1, 47, 20), (1, 48, 18), (1, 49, 20), (1, 50, 20),

-- Forum Mall (Bengaluru) - 40+ products
(2, 3, 14), (2, 4, 10), (2, 6, 16), (2, 8, 11), (2, 10, 15), 
(2, 12, 18), (2, 14, 18), (2, 16, 13), (2, 18, 11), (2, 19, 10), 
(2, 21, 14), (2, 23, 13), (2, 25, 15), (2, 27, 15), (2, 29, 17), 
(2, 30, 11), (2, 32, 19), (2, 34, 15), (2, 36, 18), (2, 38, 12), 
(2, 39, 18), (2, 40, 14), (2, 41, 16), (2, 43, 20), (2, 45, 19), 
(2, 46, 11), (2, 48, 15), (2, 49, 17), (2, 50, 17),

-- South City Mall (Kolkata) - 35+ products
(3, 2, 19), (3, 5, 19), (3, 7, 20), (3, 9, 13), (3, 11, 11), 
(3, 13, 16), (3, 15, 13), (3, 17, 18), (3, 19, 12), (3, 21, 18), 
(3, 22, 20), (3, 24, 16), (3, 26, 15), (3, 28, 18), (3, 30, 20), 
(3, 32, 17), (3, 34, 14), (3, 35, 15), (3, 37, 18), (3, 39, 12), 
(3, 41, 20), (3, 42, 20), (3, 44, 10), (3, 46, 14), (3, 48, 9), 
(3, 50, 12),

-- Ambience Mall (Gurgaon) - 40+ products
(4, 1, 15), (4, 3, 15), (4, 5, 16), (4, 6, 19), (4, 7, 13), 
(4, 10, 14), (4, 12, 10), (4, 15, 9), (4, 17, 16), (4, 18, 16), 
(4, 20, 11), (4, 22, 13), (4, 24, 18), (4, 26, 12), (4, 28, 10), 
(4, 30, 17), (4, 32, 11), (4, 34, 17), (4, 36, 16), (4, 38, 10), 
(4, 39, 10), (4, 40, 14), (4, 42, 12), (4, 44, 20), (4, 45, 13), 
(4, 47, 9), (4, 48, 19), (4, 50, 10),

-- Select Citywalk (New Delhi) - 30+ products
(5, 4, 10), (5, 8, 20), (5, 10, 15), (5, 12, 16), (5, 14, 16), 
(5, 16, 16), (5, 18, 19), (5, 19, 19), (5, 21, 16), (5, 23, 20), 
(5, 25, 20), (5, 27, 18), (5, 29, 13), (5, 31, 16), (5, 33, 20), 
(5, 35, 10), (5, 37, 17), (5, 39, 11), (5, 41, 16), (5, 42, 13), 
(5, 44, 19), (5, 46, 11), (5, 48, 18), (5, 49, 12), (5, 50, 15),

-- Lulu Mall (Kochi) - 35+ products
(6, 2, 17), (6, 5, 10), (6, 7, 19), (6, 9, 11), (6, 11, 11), 
(6, 13, 12), (6, 15, 12), (6, 17, 14), (6, 19, 9), (6, 21, 17), 
(6, 23, 13), (6, 25, 9), (6, 27, 17), (6, 29, 12), (6, 31, 13), 
(6, 33, 15), (6, 35, 18), (6, 37, 14), (6, 39, 20), (6, 41, 13), 
(6, 42, 14), (6, 44, 10), (6, 46, 16), (6, 48, 16), (6, 50, 10),

-- Express Avenue (Chennai) - 40+ products
(7, 1, 9), (7, 3, 13), (7, 5, 12), (7, 6, 17), (7, 7, 18), 
(7, 9, 10), (7, 10, 14), (7, 12, 16), (7, 14, 14), (7, 15, 11), 
(7, 17, 11), (7, 19, 13), (7, 20, 20), (7, 22, 19), (7, 24, 11), 
(7, 26, 18), (7, 28, 19), (7, 30, 20), (7, 32, 17), (7, 34, 10), 
(7, 35, 19), (7, 37, 18), (7, 39, 15), (7, 41, 17), (7, 42, 13), 
(7, 44, 11), (7, 46, 12), (7, 48, 11), (7, 50, 13),

-- Elante Mall (Chandigarh) - 30+ products
(8, 3, 11), (8, 4, 18), (8, 6, 13), (8, 8, 14), (8, 10, 18), 
(8, 12, 20), (8, 14, 15), (8, 16, 13), (8, 18, 17), (8, 19, 10), 
(8, 21, 15), (8, 23, 18), (8, 25, 19), (8, 27, 10), (8, 29, 16), 
(8, 31, 10), (8, 33, 16), (8, 35, 19), (8, 37, 17), (8, 39, 11), 
(8, 41, 13), (8, 42, 13), (8, 44, 18), (8, 46, 19), (8, 48, 14), 
(8, 50, 18);


INSERT INTO InCharges (DeliveryAgent_ID, Store_ID)
VALUES 
(1, 1), (2, 1), 
(3, 2), (4, 2), 
(5, 3), (6, 3), 
(7, 4), (8, 4), 
(9, 5), (10, 5), 
(11, 6), (12, 6), 
(13, 7), (14, 7), 
(15, 8), (16, 8);

INSERT INTO Manages (Admin_ID, Store_ID)
VALUES 
(1, 1), (1, 2),  
(2, 3), (2, 4),  
(3, 5), (3, 6),  
(4, 7), (4, 8);  

INSERT INTO OrderItem (Order_ID, Product_ID, quantity, price_at_purchase)
VALUES
(1, 1, 1, 49.99),  -- Compression Tights (Product_ID 1)
(1, 8, 1, 119.99),  -- Road Running Shoes (Product_ID 8)
(2, 3, 1, 24.99),     -- Sweat-Wicking T-Shirt (Product_ID 3)
(3, 5, 2, 29.95),  -- Workout Shorts (Product_ID 5)
(4, 7, 1, 89.99),   -- Running Backpack (Product_ID 7)
(5, 2, 2, 64.95),     -- Yoga Mat (Product_ID 2)
(6, 4, 1, 39.99),  -- Training Cap (Product_ID 4)
(7, 6, 1, 74.99),   -- Smartwatch (Product_ID 6)
(3, 9, 1, 15.99),  -- Water Bottle (Product_ID 9)
(3, 10, 3, 9.95),  -- Athletic Socks (Product_ID 10)
(4, 11, 1, 59.99),  -- Foam Roller (Product_ID 11)
(5, 12, 1, 89.95),    -- Adjustable Dumbbells (Product_ID 12)
(6, 13, 1, 129.99),-- Fitness Tracker (Product_ID 13)
(7, 14, 1, 199.99), -- Treadmill (Product_ID 14)
(8, 8, 1, 119.99),    -- Road Running Shoes (Product_ID 8)
(8, 4, 1, 39.99),     -- Training Cap (Product_ID 4)
(9, 3, 2, 24.99),   -- Sweat-Wicking T-Shirt (Product_ID 3)
(9, 1, 1, 49.99),   -- Compression Tights (Product_ID 1)
(10, 7, 1, 89.99), -- Running Backpack (Product_ID 7)
(10, 12, 1, 89.95),-- Adjustable Dumbbells (Product_ID 12)
(11, 15, 1, 59.99);   -- Resistance Bands (Product_ID 15)

INSERT INTO Adds_to_cart (Customer_ID, Product_ID, quantity)
VALUES
(1, 10, 1), 
(2, 8, 1), (2, 39, 2), 
(4, 39, 9), 
(5, 34, 5),
(6, 46, 7), 
(7, 39, 6), 
(8, 7, 3), (8, 33, 8), 
(9, 49, 3),
(14, 8, 7), (14, 38, 6), 
(15, 8, 3), 
(17, 11, 8), 
(18, 37, 1), (18, 24, 4), 
(19, 33, 2), 
(22, 9, 5), (22, 6, 8), (22, 38, 9),
(25, 20, 1), 
(26, 20, 6), (26, 38, 6), 
(27, 9, 6), (27, 8, 1),
(28, 2, 10), 
(29, 43, 2), 
(30, 9, 10), (30, 48, 2), 
(32, 31, 10),
(34, 16, 7), (34, 6, 10), 
(35, 40, 5), (36, 18, 9),
(36, 46, 10),
(37, 48, 10), 
(39, 48, 7), 
(40, 42, 1), (40, 41, 5), (40, 2, 9), (40, 10, 3), 
(41, 47, 10), (41, 44, 4), 
(43, 17, 7), (43, 48, 8),
(44, 39, 9), 
(46, 45, 9), 
(50, 12, 9), (50, 25, 10), (50, 17, 4);

-- top 10 customer
SELECT c.Customer_ID, c.first_name, c.last_name, SUM(o.total_price) AS Total_spent
FROM Customer c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- top 10 product on revenue generating
SELECT p.Product_ID, p.name, SUM(o.quantity * o.price_at_purchase) AS Total_Revenue
FROM OrderItem o
JOIN Product p ON o.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- top 10 most ordered Product
SELECT p.Product_ID, p.name, o.quantity AS Total_quantity
FROM OrderItem o
JOIN Product p ON o.Product_ID = p.Product_ID
ORDER BY Total_quantity DESC
LIMIT 10;

-- top 10 DeliveryAgent on rating
SELECT da.DeliveryAgent_ID, da.first_name, da.last_name, dr.comment, dr.rating
FROM Delivery_Review dr
JOIN DeliveryAgent da ON dr.DeliveryAgent_ID = da.DeliveryAgent_ID
ORDER BY dr.rating DESC
LIMIT 10;

-- avg order cost, total number of order, revenue per month
SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS Month,  
    COUNT(o.Order_ID) AS Total_Orders,  
    SUM(o.total_price) AS Total_Revenue,  
    AVG(o.total_price) AS Avg_Order_Cost  
FROM orders o  
WHERE o.status = "Delivered"
GROUP BY Month  
ORDER BY Month DESC;

-- top 10 most reviewed product
SELECT p.Product_ID, p.name, COUNT(*) AS Total_Reviews
FROM Product_Review r
JOIN Product p ON r.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.name
ORDER BY Total_Reviews DESC
LIMIT 10;  

-- low stock alert
SELECT a.Store_ID, s.location, s.pincode, a.Product_ID, p.name, a.store_quantity
FROM Available_in a
JOIN PhysicalStore s ON a.Store_ID = s.Store_ID
JOIN Product p ON a.Product_ID = p.Product_ID
WHERE a.store_quantity < 10
ORDER BY a.store_quantity ASC;


