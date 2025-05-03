import tkinter as tk
import mysql.connector
from tkinter import messagebox

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


def top_10_customers():
   rows = run_query("""
   SELECT c.Customer_ID, c.first_name, c.last_name, SUM(o.total_price) AS Total_Spent
   FROM Customer c
   JOIN orders o ON c.Customer_ID = o.Customer_ID
   GROUP BY c.Customer_ID, c.first_name, c.last_name
   ORDER BY Total_Spent DESC
   LIMIT 10;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Top 10 customer", result)

def top_10_products_by_revenue():
   rows = run_query("""
   SELECT p.Product_ID, p.name, SUM(oi.quantity * oi.price_at_purchase) AS Total_Revenue
   FROM OrderItem oi
   JOIN Product p ON oi.Product_ID = p.Product_ID
   GROUP BY p.Product_ID, p.name
   ORDER BY Total_Revenue DESC
   LIMIT 10;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Top 10 product by revenue", result)

def top_10_most_order_products():
   rows = run_query("""
   SELECT p.Product_ID, p.name, SUM(oi.quantity) AS Total_Ordered
   FROM OrderItem oi
   JOIN Product p ON oi.Product_ID = p.Product_ID
   GROUP BY p.Product_ID, p.name
   ORDER BY Total_Ordered DESC
   LIMIT 10;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Top 10 Most Ordered Products", result)

def top_10_delivery_agent_by_rating():
   rows = run_query("""
   SELECT da.DeliveryAgent_ID, da.first_name, da.last_name, AVG(dr.rating) AS Average_Rating
   FROM Delivery_Review dr
   JOIN DeliveryAgent da ON dr.DeliveryAgent_ID = da.DeliveryAgent_ID
   GROUP BY da.DeliveryAgent_ID, da.first_name, da.last_name
   ORDER BY Average_Rating DESC
   LIMIT 10;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Top 10 Delivery Agents by Rating", result)

def avg_oc_on_rev_per_month():
   rows = run_query("""
   SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS Month,  
    COUNT(o.Order_ID) AS Total_Orders,  
    SUM(o.total_price) AS Total_Revenue,  
    AVG(o.total_price) AS Avg_Order_Cost  
   FROM orders o  
   WHERE o.status = 'Delivered'
   GROUP BY Month  
   ORDER BY Month DESC;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Average Order Cost, Total Number of Orders, Revenue per Month", result)

def top_10_most_reviewed_product():
   rows = run_query("""
   SELECT p.Product_ID, p.name, COUNT(r.Product_ID) AS Total_Reviews
   FROM Product_Review r
   JOIN Product p ON r.Product_ID = p.Product_ID
   GROUP BY p.Product_ID, p.name
   ORDER BY Total_Reviews DESC
   LIMIT 10; 
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Top 10 Most Reviewed Products", result)

def low_stock_alert():
   rows = run_query("""
   SELECT a.Store_ID, s.location, s.pincode, a.Product_ID, p.name, a.store_quantity
   FROM Available_in a
   JOIN PhysicalStore s ON a.Store_ID = s.Store_ID
   JOIN Product p ON a.Product_ID = p.Product_ID
   WHERE a.store_quantity < 10
   ORDER BY a.store_quantity ASC;
   """)

   if rows:
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Low Stock Alert (Under 10)", result)

def show_update_product():
   update_window = tk.Toplevel()
   update_window.title("Update Product")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Product ID", "id_entry"),
      ("Name", "name_entry"),
      ("Description", "desc_entry"),
      ("Price", "price_entry"),
      ("Brand ID", "brand_entry"),
      ("Category ID", "category_entry")
   ]
   
   entries = {}

   for label_text, var_name in fields:
      tk.Label(update_window, text=label_text).pack()
      entry = tk.Entry(update_window, width=30)
      entry.pack()
      entries[var_name] = entry

   def submit():
      try:
         product_id = entries["id_entry"].get().strip()
         name = entries["name_entry"].get().strip()
         desc = entries["desc_entry"].get().strip()
         price = entries["price_entry"].get().strip()
         brand_id = entries["brand_entry"].get().strip()
         category_id = entries["category_entry"].get().strip()

         if not product_id:
               raise ValueError("Product ID is required.")
         try:
               product_id = int(product_id)
         except ValueError:
               raise ValueError("Product ID must be an integer.")

         if name:
               run_query("""
                  UPDATE Product
                  SET name = %s
                  WHERE Product_ID = %s;
               """, fetch=False, params=(name, product_id))

         if desc:
               run_query("""
                  UPDATE Product
                  SET description = %s
                  WHERE Product_ID = %s;
               """, fetch=False, params=(desc, product_id))

         if price:
               try:
                  price_val = float(price)
                  if price_val < 0:
                     raise ValueError("Price cannot be negative.")
               except ValueError:
                  raise ValueError("Price must be a non-negative number.")
               
               run_query("""
                  UPDATE Product
                  SET price = %s
                  WHERE Product_ID = %s;
               """, fetch=False, params=(price_val, product_id))

         if brand_id:
               try:
                  brand_id_val = int(brand_id)
               except ValueError:
                  raise ValueError("Brand ID must be an integer.")
               
               run_query("""
                  UPDATE Product
                  SET Brand_ID = %s
                  WHERE Product_ID = %s;
               """, fetch=False, params=(brand_id_val, product_id))

         if category_id:
               try:
                  category_id_val = int(category_id)
               except ValueError:
                  raise ValueError("Category ID must be an integer.")
               
               run_query("""
                  UPDATE Product
                  SET Category_ID = %s
                  WHERE Product_ID = %s;
               """, fetch=False, params=(category_id_val, product_id))

         
         messagebox.showinfo("Success", "Product updated successfully!")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   
   tk.Button(update_window, text="Submit", command=submit).pack(pady=10)

def show_update_stock():
   update_window = tk.Toplevel()
   update_window.title("Update Stock")
   update_window.geometry("300x450")  # You can adjust the size as needed

   fields = [
      ("Store ID", "store_entry"),
      ("Product ID", "product_entry"),
      ("Amount (+ for increase - for decrease)", "amount_entry"),
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
         store_id = entries["store_entry"].get().strip()
         amount = entries["amount_entry"].get().strip()
      
         if not product_id or not store_id:
               raise ValueError("Product ID and Store ID is required.")
         try:
               product_id = int(product_id)
               store_id = int(store_id)
               amount = int(amount)
         except ValueError:
               raise ValueError("Product ID and Store ID and Amount must be an integer.")

         if amount:
               run_query("""
                  UPDATE Available_in
                  SET store_quantity = store_quantity + %s  
                  WHERE Store_ID = %s AND Product_ID = %s;
               """, fetch=False, params=(amount, store_id, product_id))

         
         messagebox.showinfo("Success", "Stock updated successfully!")
         
      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")
   
   
   tk.Button(update_window, text="Submit", command=submit).pack(pady=10)


# GUI layout
root = tk.Tk()
root.title("Admin Form")

tk.Button(root, text="Top 10 customer", command=top_10_customers).pack()
tk.Button(root, text="Top 10 product by revenue", command=top_10_products_by_revenue).pack()
tk.Button(root, text="Top 10 Delivery Agents by Rating", command=top_10_delivery_agent_by_rating).pack()
tk.Button(root, text="Average Order Cost, Total Number of Orders, Revenue per Month", command=avg_oc_on_rev_per_month).pack()
tk.Button(root, text="Top 10 Most Reviewed Products", command=top_10_most_reviewed_product).pack()
tk.Button(root, text="Low Stock Alert (Under 10)", command=low_stock_alert).pack()
tk.Button(root, text="Update Product", command=show_update_product).pack()
tk.Button(root, text="Update Store Stock", command=show_update_stock).pack()

root.mainloop()