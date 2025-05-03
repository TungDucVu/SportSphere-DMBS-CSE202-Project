-- Admin Queries

-- 1. Top 10 Customers by Total Spent
SELECT c.Customer_ID, c.first_name, c.last_name, SUM(o.total_price) AS Total_Spent
FROM Customer c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.first_name, c.last_name
ORDER BY Total_Spent DESC
LIMIT 10;

-- 2. Top 10 Products by Revenue Generated
SELECT p.Product_ID, p.name, SUM(oi.quantity * oi.price_at_purchase) AS Total_Revenue
FROM OrderItem oi
JOIN Product p ON oi.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 3. Top 10 Most Ordered Products
SELECT p.Product_ID, p.name, SUM(oi.quantity) AS Total_Ordered
FROM OrderItem oi
JOIN Product p ON oi.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.name
ORDER BY Total_Ordered DESC
LIMIT 10;

-- 4. Top 10 Delivery Agents by Rating
SELECT da.DeliveryAgent_ID, da.first_name, da.last_name, AVG(dr.rating) AS Average_Rating
FROM Delivery_Review dr
JOIN DeliveryAgent da ON dr.DeliveryAgent_ID = da.DeliveryAgent_ID
GROUP BY da.DeliveryAgent_ID, da.first_name, da.last_name
ORDER BY Average_Rating DESC
LIMIT 10;

-- 5. Average Order Cost, Total Number of Orders, Revenue per Month
SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS Month,  
    COUNT(o.Order_ID) AS Total_Orders,  
    SUM(o.total_price) AS Total_Revenue,  
    AVG(o.total_price) AS Avg_Order_Cost  
FROM orders o  
WHERE o.status = 'Delivered'
GROUP BY Month  
ORDER BY Month DESC;

-- 6. Top 10 Most Reviewed Products
SELECT p.Product_ID, p.name, COUNT(r.Product_ID) AS Total_Reviews
FROM Product_Review r
JOIN Product p ON r.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.name
ORDER BY Total_Reviews DESC
LIMIT 10;  

-- 7. Update Product Details
Select * 
FROM Product
WHERE Product_ID = 1;
UPDATE Product
SET price = 12.34, description = 'Updated description for the product.'
WHERE Product_ID = 1;  -- Change the Product_ID as needed
Select * 
FROM Product
WHERE Product_ID = 1;

-- 8. Update Stock (Store Stock)
Select * 
FROM Available_in
WHERE Store_ID = 1 AND Product_ID = 1;
UPDATE Available_in
SET store_quantity = store_quantity - 5  -- Decrease stock by 5
WHERE Store_ID = 1 AND Product_ID = 1;  -- Change Store_ID and Product_ID as needed
Select * 
FROM Available_in
WHERE Store_ID = 1 AND Product_ID = 1;

-- 9. Low Stock Alert
SELECT a.Store_ID, s.location, s.pincode, a.Product_ID, p.name, a.store_quantity
FROM Available_in a
JOIN PhysicalStore s ON a.Store_ID = s.Store_ID
JOIN Product p ON a.Product_ID = p.Product_ID
WHERE a.store_quantity < 10
ORDER BY a.store_quantity ASC;

-- 10. Store Inventory Update When Order Placed
-- use trigger for this one


-- Customer Queries

-- 0. View personal details
SELECT * FROM Customer
WHERE Customer_ID = ...;


-- 1. Search Product by Name
SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
FROM Product p
JOIN Brand b ON p.Brand_ID = b.Brand_ID
JOIN Category c ON p.Category_ID = c.Category_ID
WHERE p.name LIKE '% Shorts%';  -- Replace this term


-- 2. Search Product by Brand
SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
FROM Product p
JOIN Brand b ON p.Brand_ID = b.Brand_ID
JOIN Category c ON p.Category_ID = c.Category_ID
WHERE b.name LIKE '%Hydra%';  -- Replace this term  

-- 3. Search Product by Category
SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
FROM Product p
JOIN Brand b ON p.Brand_ID = b.Brand_ID
JOIN Category c ON p.Category_ID = c.Category_ID
WHERE c.name LIKE '%Equipment%';  -- Replace this term

-- 4. Cart Operations: Add Product
SELECT * FROM Adds_to_cart where Customer_ID = 1;
INSERT INTO Adds_to_cart (Customer_ID, Product_ID, quantity)
VALUES (1, 1, 1);  -- Change Customer_ID and Product_ID as needed
SELECT * FROM Adds_to_cart where Customer_ID = 1;

-- 5. Cart Operations: Delete Product
SELECT * FROM Adds_to_cart where Customer_ID = 1;
DELETE FROM Adds_to_cart
WHERE Customer_ID = 1 AND Product_ID = 1;  -- Change Customer_ID and Product_ID as needed
SELECT * FROM Adds_to_cart where Customer_ID = 1;

-- 6. Cart Operations: Update Quantity
SELECT * FROM Adds_to_cart where Customer_ID = 1;
UPDATE Adds_to_cart
SET quantity = quantity + 2  -- Increase quantity by 1
WHERE Customer_ID = 1 AND Product_ID = 10;  -- Change Customer_ID and Product_ID as needed
SELECT * FROM Adds_to_cart where Customer_ID = 1;

-- 7. Get Total Cart Value
SELECT SUM(p.price * ac.quantity) AS Total_Cart_Value
FROM Adds_to_cart ac
JOIN Product p ON ac.Product_ID = p.Product_ID
WHERE ac.Customer_ID = 1;  -- Change Customer_ID as needed

-- 8. Order: Place an Order

INSERT INTO orders (Customer_ID, Delivery_Agent, date, total_price, address, status)
VALUES (
   1,  
   NULL,
   CURDATE(),
   (SELECT SUM(p.price * ac.quantity)                                                                               -- Calculate order total price
   FROM Adds_to_cart ac 
   JOIN Product p ON ac.Product_ID = p.Product_ID 
   WHERE ac.Customer_ID = 1),
   'Customer Address',                                                                                              -- Customer address
   'Confirmed'                                                                                                      -- Confirmed as default
);

ALTER TABLE available_in

-- 9. View Order History
SELECT * FROM orders
WHERE Customer_ID = 1;  -- Change Customer_ID as needed

-- 10. Track Order Status
SELECT status FROM orders
WHERE Order_ID = 1;  -- Change Order_ID as needed

-- 11. Add Review for a Product
SELECT * FROM Product_Review WHERE Customer_ID = 1;
INSERT INTO Product_Review (Customer_ID, Product_ID, rating, comment, review_date)
VALUES (1, 1, 5, 'Great product!', CURDATE());  -- Change Customer_ID and Product_ID as needed
SELECT * FROM Product_Review WHERE Customer_ID = 1;

-- 12. Update Personal Details
SELECT * FROM Customer WHERE Customer_ID = 1;
UPDATE Customer
SET first_name = 'NewFirstName', last_name = 'NewLastName', street = 'New Street', city = 'New City', state = 'NS', pincode = 123456 -- Change which should be done as needed
WHERE Customer_ID = 1;  -- Change Customer_ID as needed
SELECT * FROM Customer WHERE Customer_ID = 1;


-- Delivery Agent Queries

-- 1. View Pending Orders
SELECT * FROM orders
WHERE status = 'Pending';  -- Change as needed

-- 2. Take an Order. Can only take order if status is pending and deliveryagent_id = null
UPDATE orders
SET DeliveryAgent_ID = ...
WHERE order_ID = ...;

-- 3. View All Orders 
SELECT * FROM orders
WHERE DeliveryAgentID = ...;

-- 4. Performance Track: Monthly Completed Deliveries
SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS Month, 
    COUNT(o.Order_ID) AS Total_Deliveries
FROM orders o
WHERE o.DeliveryAgent_ID = 1 AND o.status = 'Delivered'  -- Change DeliveryAgent_ID as needed
GROUP BY Month
ORDER BY Month DESC;

-- 5. Performance Track: Average Rating of Deliveries
SELECT AVG(dr.rating) AS Average_Rating
FROM Delivery_Review dr
JOIN orders o ON dr.Order_ID = o.Order_ID
WHERE o.DeliveryAgent_ID = 1;  -- Change DeliveryAgent_ID as needed

-- 6. Update Agent personal details
UPDATE DeiveryAgent
SET ...
WHERE DeliveryAgent_ID = ...;

-- 7. View Delivery Agent's Personal Details
SELECT * FROM DeliveryAgent
WHERE Customer_ID = ...;

-- 8. Update Delivery Agent's Availability Status
UPDATE DeliveryAgent
SET availability_status = ...
WHERE DeliveryAgent_ID = ...; 

-- 9. Count Total Deliveries for a Specific Month
SELECT COUNT(Order_ID) AS Total_Deliveries
FROM orders
WHERE DeliveryAgent_ID = 1 AND MONTH(date) = 1 AND YEAR(date) = 2024;  -- Change DeliveryAgent_ID and date as needed

-- 10. Get Feedback on Deliveries
SELECT dr.comment, dr.rating
FROM Delivery_Review dr
JOIN orders o ON dr.Order_ID = o.Order_ID
WHERE o.DeliveryAgent_ID = 1;  -- Change DeliveryAgent_ID as needed