USE sports_store_db;

-- Populate the tables

-- Admins
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
INSERT INTO Product (Product_ID, name, description, price, stock_quantity, Brand_ID, Category_ID) VALUES
(001, 'Compression Tights', 'Breathable, stretch-fit running tights', 49.99, 120, 002, 001),
(002, 'Running Shorts', 'Lightweight shorts for high-speed running', 29.99, 150, 002, 001),
(003, 'Sweat-Wicking T-Shirt', 'Keeps you dry during intense workouts', 24.99, 180, 002, 001),
(004, 'Soccer Jersey', 'Pro-fit soccer jersey with moisture control', 39.99, 130, 001, 001),
(005, 'Goalkeeper Jersey', 'Padded goalkeeper jersey with added protection', 44.99, 100, 001, 001),
(006, 'Wetsuit', 'High-durability wetsuit for swimming & surfing', 89.99, 90, 005, 001),
(007, 'Hiking Jacket', 'Waterproof, wind-resistant hiking jacket', 79.99, 110, 007, 001),
(008, 'Road Running Shoes', 'Ultra-light running shoes for speed', 119.99, 95, 002, 002),
(009, 'Trail Running Shoes', 'Designed for rough outdoor trails', 119.99, 80, 002, 002),
(010, 'Firm Ground Soccer Cleats', 'Optimum grip soccer cleats for firm surfaces', 89.99, 150, 001, 003),
(011, 'Goalkeeper Gloves', 'Extra traction and durability for keepers', 79.99, 130, 001, 003),
(012, 'Waterproof Hiking Boots', 'All-terrain, weatherproof boots', 129.99, 85, 007, 001),
(013, 'Running Sunglasses', 'UV-protected lightweight running glasses', 34.99, 200, 002, 006),
(014, 'Skate Helmet', 'Impact-resistant helmet for extreme sports', 59.99, 120, 004, 003),
(015, 'Boxing Mouthguard', 'Shock-absorbing mouthguard for combat sports', 19.99, 250, 006, 003),
(016, 'Weightlifting Belt', 'Supports lower back during heavy lifts', 46.59, 140, 003, 003),
(017, 'Knee Sleeves', 'Reduces joint stress and improves stability', 29.99, 160, 003, 003),
(018, 'Hydration Backpack', 'Lightweight pack with built-in water reservoir', 49.99, 90, 007, 004),
(019, 'Soccer Boot Bag', 'Durable bag for carrying cleats and gear', 25.99, 130, 001, 004),
(020, 'MMA Gear Bag', 'Spacious gym bag for fighters', 54.99, 75, 006, 004),
(021, 'Adjustable Dumbbells', 'Compact, space-saving dumbbell set', 179.59, 80, 003, 005),
(022, 'Olympic Barbell', 'Professional-grade weightlifting bar', 149.99, 60, 003, 005),
(023, 'Punching Bag', 'Heavy-duty punching bag for boxing training', 129.99, 90, 006, 005),
(024, 'Speed Bag', 'Improves reflexes and striking speed', 49.99, 80, 006, 005),
(025, 'Professional Soccer Ball', 'Official match ball', 34.99, 200, 001, 005),
(026, 'Kickboard', 'Training aid for improving swimming techniques', 29.99, 150, 005, 005),
(027, 'Trekking Poles', 'Lightweight and adjustable hiking poles', 39.99, 120, 007, 006),
(028, 'Waterproof Phone Case', 'Protects your phone while swimming or kayaking', 18.99, 300, 005, 006),
(029, 'Compression Arm Sleeves', 'Provides muscle support and enhances circulation', 14.99, 250, 002, 006),
(030, 'Trekking Lantern', 'Rechargeable lantern for night camping', 29.99, 110, 007, 007),
(031, 'Sleeping Bag', 'Lightweight and warm for all seasons', 79.99, 100, 007, 007),
(032, 'Camping Stove', 'Compact and fuel-efficient outdoor stove', 59.99, 90, 007, 007),
(033, 'Diving Mask', 'Anti-fog, wide-view diving mask', 49.99, 80, 005, 007),
(034, 'Snorkel', 'Ergonomic and easy-breath snorkel tube', 19.99, 200, 005, 007),
(035, 'Skateboard', 'Pro-quality skateboard for street and park', 88.99, 70, 004, 005),
(036, 'BMX Frame', 'Lightweight and durable BMX frame for stunts', 149.59, 50, 004, 005),
(037, 'Snowboard', 'High-performance snowboard for all conditions', 199.49, 40, 004, 005),
(038, 'Survival Whistle', 'Emergency whistle with built-in compass', 19.99, 500, 007, 006),
(039, 'CrossFit Bag', 'Versatile training bag for all gym needs', 64.89, 80, 006, 004),
(040, 'Yoga Mat Bag', 'Compact bag to carry your yoga essentials', 29.99, 150, 002, 004),
(041, 'Water Bottle', 'BPA-free sports bottle with cooling insulation', 14.99, 400, 002, 006),
(042, 'Football Gloves', 'Enhanced grip gloves for football players', 34.99, 120, 001, 003),
(043, 'Baseball Bat', 'Lightweight yet powerful bat for home runs', 79.99, 90, 004, 005),
(044, 'Gymnastics Rings', 'Adjustable rings for strength training', 49.99, 75, 003, 005),
(045, 'Climbing Rope', 'Durable, high-tension rope for rock climbing', 59.99, 60, 007, 007),
(046, 'Soccer Shin Guards', 'Lightweight yet protective shin guards', 19.99, 180, 001, 003),
(047, 'Foldable Camping Chair', 'Compact and durable chair for outdoor trips', 39.99, 100, 007, 007),
(048, 'Tennis Racket', 'High-performance racket for professional play', 129.99, 85, 004, 005),
(049, 'Ski Goggles', 'Anti-fog and UV-protected ski goggles', 59.99, 95, 004, 005),
(050, 'Portable Air Pump', 'Compact air pump for balls and inflatables', 24.99, 200, 002, 006);

INSERT INTO PhysicalStore (street, city, state, pincode)  
VALUES  
('Phoenix Marketcity', 'Mumbai', 'MH', 400059),  
('Forum Mall', 'Bengaluru', 'KA', 560029),  
('South City Mall', 'Kolkata', 'WB', 700068),  
('Ambience Mall', 'Gurgaon', 'HR', 122002),  
('Select Citywalk', 'New Delhi', 'DL', 110017),  
('Lulu Mall', 'Kochi', 'KL', 682024),  
('Express Avenue', 'Chennai', 'TN', 600002),  
('Elante Mall', 'Chandigarh', 'CH', 160002);  


INSERT INTO orders (Customer_ID, DeliveryAgent_ID, date, total_amount, address, status)
VALUES
(1, 1, '2023-02-10', 169.98, 'Linking Road, Mumbai, MH 400052', 'Delivered'),  -- Total = 49.99 + 119.99
(3, 2, '2023-02-11', 24.99, 'Connaught Place, Delhi 110001', 'Shipped'),       -- Total = 24.99
(2, 3, '2023-02-12', 59.90, 'MG Road, Bengaluru, KA 560001', 'Processing'),   -- Total = 29.95 x 2
(4, 1, '2023-02-13', 89.99, 'Park Street, Kolkata, WB 700016', 'Delivered'),   -- Total = 89.99
(5, 4, '2023-02-14', 129.90, 'Banjara Hills, Hyderabad, TS 500034', 'Shipped'), -- Total = 64.95 x 2
(3, 2, '2023-02-15', 39.99, 'Connaught Place, Delhi 110001', 'Processing'),   -- Total = 39.99
(6, 5, '2023-02-16', 74.99, 'Anna Nagar, Chennai, TN 600040', 'Delivered'),    -- Total = 74.99
(7, 6, '2023-02-17', 199.99, 'Andheri West, Mumbai, MH 400058', 'Delivered'),  -- Total = 199.99
(8, 3, '2023-02-18', 159.98, 'Jayanagar, Bengaluru, KA 560011', 'Shipped'),    -- Total = 119.99 + 39.99
(9, 7, '2023-02-19', 104.97, 'Salt Lake City, Kolkata, WB 700091', 'Processing'), -- Total = 24.99 x 2 + 54.99
(10, 4, '2023-02-20', 59.99, 'DLF Phase 2, Gurgaon, HR 122002', 'Shipped'),    -- Total = 59.99
(11, 1, '2023-02-21', 49.99, 'Sector 17, Chandigarh, CH 160017', 'Delivered'), -- Total = 49.99
(12, 6, '2023-02-22', 89.95, 'Kukatpally, Hyderabad, TS 500072', 'Processing'), -- Total = 89.95
(13, 5, '2023-02-23', 129.99, 'T. Nagar, Chennai, TN 600017', 'Delivered'),    -- Total = 129.99
(14, 2, '2023-02-24', 64.95, 'MG Road, Pune, MH 411001', 'Processing'),        -- Total = 64.95
(15, 7, '2023-02-25', 74.99, 'Hazratganj, Lucknow, UP 226001', 'Delivered'),   -- Total = 74.99
(16, 8, '2023-02-26', 299.94, 'Sector 62, Noida, UP 201301', 'Shipped'),       -- Total = 99.98 x 3
(17, 3, '2023-02-27', 159.90, 'Indiranagar, Bengaluru, KA 560038', 'Processing'), -- Total = 79.95 x 2
(18, 4, '2023-02-28', 59.99, 'Lajpat Nagar, Delhi 110024', 'Shipped'),         -- Total = 59.99
(19, 5, '2023-03-01', 109.99, 'Viman Nagar, Pune, MH 411014', 'Delivered');    -- Total = 109.99

INSERT INTO OrderItem (Order_ID, Product_ID, quantity, price_at_purchase, status)
VALUES
(1, 1, 1, 49.99, 'Delivered'),  -- Compression Tights (Product_ID 1)
(1, 8, 1, 119.99, 'Delivered'),  -- Road Running Shoes (Product_ID 8)
(2, 3, 1, 24.99, 'Shipped'),     -- Sweat-Wicking T-Shirt (Product_ID 3)
(3, 5, 2, 29.95, 'Processing'),  -- Workout Shorts (Product_ID 5)
(4, 7, 1, 89.99, 'Delivered'),   -- Running Backpack (Product_ID 7)
(5, 2, 2, 64.95, 'Shipped'),     -- Yoga Mat (Product_ID 2)
(6, 4, 1, 39.99, 'Processing'),  -- Training Cap (Product_ID 4)
(7, 6, 1, 74.99, 'Delivered'),   -- Smartwatch (Product_ID 6)
(3, 9, 1, 15.99, 'Processing'),  -- Water Bottle (Product_ID 9)
(3, 10, 3, 9.95, 'Processing'),  -- Athletic Socks (Product_ID 10)
(4, 11, 1, 59.99, 'Delivered'),  -- Foam Roller (Product_ID 11)
(5, 12, 1, 89.95, 'Shipped'),    -- Adjustable Dumbbells (Product_ID 12)
(6, 13, 1, 129.99, 'Processing'),-- Fitness Tracker (Product_ID 13)
(7, 14, 1, 199.99, 'Delivered'), -- Treadmill (Product_ID 14)
(8, 8, 1, 119.99, 'Shipped'),    -- Road Running Shoes (Product_ID 8)
(8, 4, 1, 39.99, 'Shipped'),     -- Training Cap (Product_ID 4)
(9, 3, 2, 24.99, 'Delivered'),   -- Sweat-Wicking T-Shirt (Product_ID 3)
(9, 1, 1, 49.99, 'Delivered'),   -- Compression Tights (Product_ID 1)
(10, 7, 1, 89.99, 'Processing'), -- Running Backpack (Product_ID 7)
(10, 12, 1, 89.95, 'Processing'),-- Adjustable Dumbbells (Product_ID 12)
(11, 15, 1, 59.99, 'Shipped');   -- Resistance Bands (Product_ID 15)

INSERT INTO Review (Customer_ID, Product_ID, rating, comment, review_date) 
VALUES
(1, 10, 5, 'Amazing product! Highly recommend.', '2025-02-01'),
(2, 20, 4, 'Good quality, but shipping was slow.', '2025-02-02'),
(3, 5, 3, 'Average product, nothing special.', '2025-02-03'),
(4, 15, 2, 'Not satisfied, expected better.', '2025-02-04'),
(5, 25, 5, 'Exceeded my expectations!', '2025-02-05'),
(6, 30, 4, 'Very useful, worth the price.', '2025-02-06'),
(7, 40, 1, 'Defective item, very disappointed.', '2025-02-07'),
(8, 50, 5, 'Fantastic product, will buy again.', '2025-02-08'),
(9, 12, 3, 'Okay for the price.', '2025-02-09'),
(10, 22, 4, 'Nice design, works well.', '2025-02-10'),
(11, 32, 2, 'Not as described, poor quality.', '2025-02-11'),
(12, 42, 5, 'Superb! Love it.', '2025-02-12'),
(13, 8, 3, 'Decent but not great.', '2025-02-13'),
(14, 18, 4, 'Meets expectations, good buy.', '2025-02-14'),
(15, 28, 1, 'Worst purchase ever.', '2025-02-15'),
(16, 38, 5, 'Outstanding quality!', '2025-02-16'),
(17, 48, 3, 'Could be better.', '2025-02-17'),
(18, 9, 4, 'Good but a little expensive.', '2025-02-18'),
(19, 19, 2, 'Disappointed, not worth it.', '2025-02-19'),
(20, 29, 5, 'Perfect! Highly recommended.', '2025-02-20'),
(21, 39, 4, 'Nice and sturdy.', '2025-02-21'),
(22, 49, 3, 'Works fine, but not impressive.', '2025-02-22'),
(23, 7, 2, 'Poor quality, not recommended.', '2025-02-23'),
(24, 17, 5, 'Absolutely love it!', '2025-02-24'),
(25, 27, 4, 'Pretty good overall.', '2025-02-25');

INSERT INTO Available_in (Store_ID, Product_ID) 
VALUES
-- Phoenix Marketcity (Mumbai) - 50 products
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
(1, 21), (1, 22), (1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),
(1, 31), (1, 32), (1, 33), (1, 34), (1, 35), (1, 36), (1, 37), (1, 38), (1, 39), (1, 40),
(1, 41), (1, 42), (1, 43), (1, 44), (1, 45), (1, 46), (1, 47), (1, 48), (1, 49), (1, 50),

-- Forum Mall (Bengaluru) - 40+ products
(2, 3), (2, 4), (2, 6), (2, 8), (2, 10), (2, 12), (2, 14), (2, 16), (2, 18), (2, 19),
(2, 21), (2, 23), (2, 25), (2, 27), (2, 29), (2, 30), (2, 32), (2, 34), (2, 36), (2, 38),
(2, 39), (2, 40), (2, 41), (2, 43), (2, 45), (2, 46), (2, 48), (2, 49), (2, 50),

-- South City Mall (Kolkata) - 35+ products
(3, 2), (3, 5), (3, 7), (3, 9), (3, 11), (3, 13), (3, 15), (3, 17), (3, 19), (3, 21),
(3, 22), (3, 24), (3, 26), (3, 28), (3, 30), (3, 32), (3, 34), (3, 35), (3, 37), (3, 39),
(3, 41), (3, 42), (3, 44), (3, 46), (3, 48), (3, 50),

-- Ambience Mall (Gurgaon) - 40+ products
(4, 1), (4, 3), (4, 5), (4, 6), (4, 7), (4, 10), (4, 12), (4, 15), (4, 17), (4, 18),
(4, 20), (4, 22), (4, 24), (4, 26), (4, 28), (4, 30), (4, 32), (4, 34), (4, 36), (4, 38),
(4, 39), (4, 40), (4, 42), (4, 44), (4, 45), (4, 47), (4, 48), (4, 50),

-- Select Citywalk (New Delhi) - 30+ products
(5, 4), (5, 8), (5, 10), (5, 12), (5, 14), (5, 16), (5, 18), (5, 19), (5, 21), (5, 23),
(5, 25), (5, 27), (5, 29), (5, 31), (5, 33), (5, 35), (5, 37), (5, 39), (5, 41), (5, 42),
(5, 44), (5, 46), (5, 48), (5, 49), (5, 50),

-- Lulu Mall (Kochi) - 35+ products
(6, 2), (6, 5), (6, 7), (6, 9), (6, 11), (6, 13), (6, 15), (6, 17), (6, 19), (6, 21),
(6, 23), (6, 25), (6, 27), (6, 29), (6, 31), (6, 33), (6, 35), (6, 37), (6, 39), (6, 41),
(6, 42), (6, 44), (6, 46), (6, 48), (6, 50),

-- Express Avenue (Chennai) - 40+ products
(7, 1), (7, 3), (7, 5), (7, 6), (7, 7), (7, 9), (7, 10), (7, 12), (7, 14), (7, 15),
(7, 17), (7, 19), (7, 20), (7, 22), (7, 24), (7, 26), (7, 28), (7, 30), (7, 32), (7, 34),
(7, 35), (7, 37), (7, 39), (7, 41), (7, 42), (7, 44), (7, 46), (7, 48), (7, 50),

-- Elante Mall (Chandigarh) - 30+ products
(8, 3), (8, 4), (8, 6), (8, 8), (8, 10), (8, 12), (8, 14), (8, 16), (8, 18), (8, 19),
(8, 21), (8, 23), (8, 25), (8, 27), (8, 29), (8, 31), (8, 33), (8, 35), (8, 37), (8, 39),
(8, 41), (8, 42), (8, 44), (8, 46), (8, 48), (8, 50);
;

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
