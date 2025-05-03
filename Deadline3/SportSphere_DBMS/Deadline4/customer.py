import tkinter as tk
from tkinter import messagebox
import mysql.connector

CUSTOMER_ID = 1

def run_query(query, fetch=True, params=()):
   try:
      conn = mysql.connector.connect(
         host="localhost",
         user="root",
         password="Vuductung2005*",
         database="sports_store_db"
      )
      cursor = conn.cursor()
      cursor.execute(query, params)

      data = cursor.fetchall() if fetch else None
      conn.commit()
      cursor.close()
      conn.close()
      return data

   except mysql.connector.Error as err:
      messagebox.showerror("Database Error", f"Error: {err}")
      return None

def show_search():
   update_window = tk.Toplevel()
   update_window.title("Search Product by Name")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Name", "name_entry"),
      ("Brand", "brand_entry"),
      ("Category", "category_entry")
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   def submit():
      try:
         name = entries["name_entry"].get().strip()
         brand = entries["brand_entry"].get().strip()
         category = entries["category_entry"].get().strip()

         if name: 
            names = run_query("""
                  SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
                  FROM Product p
                  JOIN Brand b ON p.Brand_ID = b.Brand_ID
                  JOIN Category c ON p.Category_ID = c.Category_ID
                  WHERE p.name LIKE %s;
                  """, fetch=True, params=(f"%{name}%",))
            if not names:
                  messagebox.showinfo("Search Results", "No matches found.")
            else:
                  result = "\n".join([" | ".join(str(cell) for cell in row) for row in names])
                  messagebox.showinfo("Search Results", result)

         if brand: 
            brands = run_query("""
                  SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
                  FROM Product p
                  JOIN Brand b ON p.Brand_ID = b.Brand_ID
                  JOIN Category c ON p.Category_ID = c.Category_ID
                  WHERE b.name LIKE %s;
                  """, fetch=True, params=(f"%{brand}%",))
            if not brands:
                  messagebox.showinfo("Search Results", "No matches found.")
            else:
                  result = "\n".join([" | ".join(str(cell) for cell in row) for row in brands])
                  messagebox.showinfo("Search Results", result)

         if category: 
            categories = run_query("""
                  SELECT p.Product_ID, p.name AS Product_Name, p.price, b.name AS Brand_Name, c.name AS Category_Name
                  FROM Product p
                  JOIN Brand b ON p.Brand_ID = b.Brand_ID
                  JOIN Category c ON p.Category_ID = c.Category_ID
                  WHERE c.name LIKE %s; 
                  """, fetch=True, params=(f"%{category}%",))
            if not categories:
                  messagebox.showinfo("Search Results", "No matches found.")
            else:
                  result = "\n".join([" | ".join(str(cell) for cell in row) for row in categories])
                  messagebox.showinfo("Search Results", result)

      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")


   tk.Button(update_window, text="Search", command=submit).pack(pady=10)

def view_cart():
   rows = run_query("""
      SELECT p.Product_ID AS ProductID, p.name AS Name, ac.quantity AS Quantity
      FROM Adds_to_cart ac
      JOIN Product p on p.Product_ID = ac.Product_ID
      WHERE ac.Customer_ID = %s;
      """, fetch=True, params=(CUSTOMER_ID,))
   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Search Results", result)
   else:
      messagebox.showinfo("Warning", "Your cart is empty!")

def show_add_cart():
   update_window = tk.Toplevel()
   update_window.title("Add to Cart")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Product ID", "product_entry"),
      ("Quantity", "quantity_entry"),
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   # Optional: add a Submit or Update button
   def submit():
      try:
         product_id = entries["product_entry"].get().strip()
         quantity = entries["quantity_entry"].get().strip()
      
         if not product_id or not quantity:
               raise ValueError("Product ID and Quantity is required.")
         try:
            product_id = int(product_id)
            quantity = int(quantity)

            run_query("""
            INSERT INTO Adds_to_cart (Customer_ID, Product_ID, quantity)
            VALUES (%s, %s, %s);
            """, fetch=False, params=(CUSTOMER_ID, product_id, quantity))
                        
            messagebox.showinfo("Success", "Items added!")

         except ValueError:
               raise ValueError("Product ID and Quatity must be an integer.")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   tk.Button(update_window, text="Add product", command=submit).pack(pady=10)

def show_del_cart():
   update_window = tk.Toplevel()
   update_window.title("Delete from Cart")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Product ID", "product_entry"),
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   # Optional: add a Submit or Update button
   def submit():
      try:
         product_id = entries["product_entry"].get().strip()
      
         if not product_id:
               raise ValueError("Product ID is required.")
         try:
            product_id = int(product_id)

            rows = run_query("""
            DELETE FROM Adds_to_cart
            WHERE Customer_ID = %s AND Product_ID = %s;
            """, fetch=False, params=(CUSTOMER_ID, product_id))
                        
            messagebox.showinfo("Success", "Items deleted!")

         except ValueError:
               raise ValueError("Product ID and Quatity must be an integer.")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   tk.Button(update_window, text="Delete Product", command=submit).pack(pady=10)

def show_update_cart():
   update_window = tk.Toplevel()
   update_window.title("Update Item quantity")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Product ID", "product_entry"),
      ("Quantity", "quantity_entry"),
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   # Optional: add a Submit or Update button
   def submit():
      try:
         product_id = entries["product_entry"].get().strip()
         quantity = entries["quantity_entry"].get().strip()
      
         if not product_id or not quantity:
               raise ValueError("Product ID and Quantity is required.")
         try:
            product_id = int(product_id)
            quantity = int(quantity)

            rows = run_query("""
            UPDATE Adds_to_cart
            SET quantity = %s
            WHERE Customer_ID = %s AND Product_ID = %s;
            """, fetch=False, params=(quantity, CUSTOMER_ID, product_id))
            
            
            messagebox.showinfo("Success", "Quantity changed!")

         except ValueError:
               raise ValueError("Product ID and Quatity must be an integer.")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   tk.Button(update_window, text="Update", command=submit).pack(pady=10)

def get_total_cart_value():
   rows = run_query("""
      SELECT SUM(p.price * ac.quantity) AS Total_Cart_Value
      FROM Adds_to_cart ac
      JOIN Product p ON ac.Product_ID = p.Product_ID
      WHERE ac.Customer_ID = %s;
      """, fetch= True, params=(CUSTOMER_ID,))
   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Cart value", result)

def view_order_history():
      rows = run_query("""
         SELECT *
         FROM Orders
         WHERE Customer_ID = %s
         ORDER BY date DESC
      """, fetch=True, params=(CUSTOMER_ID,))
      if rows:
         result = "\n".join([" | ".join(map(str, row)) for row in rows])
         messagebox.showinfo("Order History", result)

def track_order_status():
      rows = run_query("""
         SELECT * 
         FROM orders
         WHERE Customer_ID = %s AND (status = 'Pending' OR status = 'Confirmed')
         ORDER BY date DESC;
      """, fetch=True, params=(CUSTOMER_ID,))
      if rows:
         result = "\n".join([" | ".join(map(str, row)) for row in rows])
         messagebox.showinfo("Order Status", result)
      else:
         messagebox.showinfo("Order Status", "No pending orders found")

def show_add_review():
   update_window = tk.Toplevel()
   update_window.title("Review Item")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Product ID", "product_entry"),
      ("Rating", "rating_entry"),
      ("Review", "review_entry"),
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   # Optional: add a Submit or Update button
   def submit():
      try:
         product_id = entries["product_entry"].get().strip()
         rating = entries["rating_entry"].get().strip()
         review = entries["review_entry"].get().strip()
      
         if not product_id:
               raise ValueError("Product ID is required.")
         try:
            product_id = int(product_id)
            rating = int(rating)

            rows = run_query("""
               INSERT INTO Product_Review (Customer_ID, Product_ID, rating, comment, review_date)
               VALUES (%s, %s, %s, %s, CURDATE());
            """, fetch=False, params=(CUSTOMER_ID, product_id, rating, review))
            

            messagebox.showinfo("Success", "Review added!")

         except ValueError:
               raise ValueError("Product ID and rating must be an integer.")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   tk.Button(update_window, text="Add Review", command=submit).pack(pady=10)

def show_update_customer_info():
   update_window = tk.Toplevel()
   update_window.title("Update Personal Info")
   update_window.geometry("350x700")

   fields = [
      ("First Name", "first_name_entry"),
      ("Last Name", "last_name_entry"),
      ("Age", "age_entry"),
      ("Email", "email_entry"),
      ("Password", "password_entry"),
      ("Phone Number", "phone_entry"),
      ("Street", "street_entry"),
      ("City", "city_entry"),
      ("State (2 letters)", "state_entry"),
      ("Pincode", "pincode_entry"),
      ("Date of Birth (YYYY-MM-DD)", "dob_entry")
]

   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack(pady=2)
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   def submit():
      try:
         first_name = entries["first_name_entry"].get().strip()
         last_name = entries["last_name_entry"].get().strip()
         age = entries["age_entry"].get().strip()
         email = entries["email_entry"].get().strip()
         password = entries["password_entry"].get().strip()
         phone = entries["phone_entry"].get().strip()
         street = entries["street_entry"].get().strip()
         city = entries["city_entry"].get().strip()
         state = entries["state_entry"].get().strip()
         pincode = entries["pincode_entry"].get().strip()
         dob = entries["dob_entry"].get().strip()

         if first_name:
               run_query("""
                  UPDATE Customer
                  SET first_name = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(first_name, CUSTOMER_ID))

         if last_name:
               run_query("""
                  UPDATE Customer
                  SET last_name = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(last_name, CUSTOMER_ID))

         if age:
               try:
                  age_val = int(age)
                  if age_val < 0:
                     raise ValueError("Age cannot be negative.")
               except ValueError:
                  raise ValueError("Age must be a valid integer.")
               run_query("""
                  UPDATE Customer
                  SET age = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(age_val, CUSTOMER_ID))

         if email:
               run_query("""
                  UPDATE Customer
                  SET email = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(email, CUSTOMER_ID))

         if password:
               run_query("""
                  UPDATE Customer
                  SET password = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(password, CUSTOMER_ID))

         if phone:
               try:
                  phone_val = int(phone)
               except ValueError:
                  raise ValueError("Phone number must be a valid number.")
               run_query("""
                  UPDATE Customer
                  SET phone_number = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(phone_val, CUSTOMER_ID))

         if street:
               run_query("""
                  UPDATE Customer
                  SET street = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(street, CUSTOMER_ID))

         if city:
               run_query("""
                  UPDATE Customer
                  SET city = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(city, CUSTOMER_ID))

         if state:
               run_query("""
                  UPDATE Customer
                  SET state = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(state.upper(), CUSTOMER_ID))

         if pincode:
               try:
                  pincode_val = int(pincode)
               except ValueError:
                  raise ValueError("Pincode must be an integer.")
               run_query("""
                  UPDATE Customer
                  SET pincode = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(pincode_val, CUSTOMER_ID))

         if dob:
               run_query("""
                  UPDATE Customer
                  SET dob = %s
                  WHERE Customer_ID = %s;
               """, fetch=False, params=(dob, CUSTOMER_ID))

         messagebox.showinfo("Success", "Customer updated successfully!")

      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")

   tk.Button(update_window, text="Update Info", command=submit).pack(pady=20)

def show_place_order():   
   update_window = tk.Toplevel()
   update_window.title("Review Item")
   update_window.geometry("300x450")  # You can adjust the size as needed

   cart = run_query("""
      SELECT p.Product_ID AS ProductID, p.name AS Name, ac.quantity AS Quantity
      FROM Adds_to_cart ac
      JOIN Product p on p.Product_ID = ac.Product_ID
      WHERE ac.Customer_ID = %s;
      """, fetch=True, params=(CUSTOMER_ID,))
   if cart:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in cart])

      cart_window = tk.Toplevel()
      cart_window.title("Your Cart")
      cart_window.geometry("400x300")
      label = tk.Label(cart_window, text=result, justify="left", anchor="w")
      label.pack(padx=10, pady=10, fill="both", expand=True)
   else:
      messagebox.showinfo("Cart", "Your cart is empty.")

   fields = [
      ("Address", "address_entry"),
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   # Optional: add a Submit or Update button
   def submit():
      address = entries["address_entry"].get().strip()
   
      if not address:
            raise ValueError("Address is required.")
      try:
         run_query("""
               INSERT INTO orders (Customer_ID, date, total_price, address, status)
               VALUES (
                  1,  
                  CURDATE(),
                  (SELECT SUM(p.price * ac.quantity)                                                                               
                  FROM Adds_to_cart ac 
                  JOIN Product p ON ac.Product_ID = p.Product_ID 
                  WHERE ac.Customer_ID = 1),
                  %s,                                                                                              
                  'Confirmed'                                                                                                      
               );
               """, fetch=False, params=(address,))
         
         run_query("""
            DELETE FROM Adds_to_cart
            WHERE Customer_ID = %s;
         """, fetch=False, params=(CUSTOMER_ID,))
         messagebox.showinfo("Success", "Order placed!")
      
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   tk.Button(update_window, text="Place Order", command=submit).pack(pady=10)

def view_customer_info():
   rows = run_query("SELECT * FROM DeliveryAgent WHERE DeliveryAgent_ID = %s", params=(CUSTOMER_ID,))
   if rows:
      messagebox.showinfo("My Details", str(rows[0]))

root = tk.Tk()
root.title("Customer Interface")
tk.Label(root, text="HELLO CUSTOMER ID " + str(CUSTOMER_ID) + " !").pack()

# Buttons for customer functions
tk.Button(root, text="Search", command=show_search).pack()
tk.Button(root, text="View cart", command=view_cart).pack()
tk.Button(root, text="Add to cart", command=show_add_cart).pack()
tk.Button(root, text="Delete from cart", command=show_del_cart).pack()
tk.Button(root, text="Update item quantity in cart", command=show_update_cart).pack()
tk.Button(root, text="Place Order", command=show_place_order).pack()
tk.Button(root, text="Get Total Cart Value", command=get_total_cart_value).pack()
tk.Button(root, text="View Order History", command=view_order_history).pack()
tk.Button(root, text="Track Order Status", command=track_order_status).pack()
tk.Button(root, text="Give Review on Items", command=show_add_review).pack()
tk.Button(root, text="View Personal Info", command=view_customer_info).pack()
tk.Button(root, text="Update Personal Info", command=show_update_customer_info).pack()

root.mainloop()