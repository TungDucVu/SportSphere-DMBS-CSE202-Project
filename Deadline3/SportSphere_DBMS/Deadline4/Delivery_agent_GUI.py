import tkinter as tk
from tkinter import messagebox
import mysql.connector

AGENT_ID = 1  # You can dynamically set this on login screen later

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

# 1. View Pending Orders
def view_pending_orders():
   rows = run_query("SELECT * FROM orders WHERE status = 'Pending'")
   if rows:
      result = "\n".join(str(row) for row in rows)
      messagebox.showinfo("Pending Orders", result)

# 2. Take an Order
def take_order():
   def submit():
      try:
         order_id = int(entry.get())
         run_query(
            "UPDATE orders SET DeliveryAgent_ID = %s WHERE Order_ID = %s AND status = 'Pending' AND DeliveryAgent_ID IS NULL",
            fetch=False,
            params=(AGENT_ID, order_id)
         )
         messagebox.showinfo("Success", f"Order {order_id} taken successfully.")
         top.destroy()
      except Exception as e:
         messagebox.showerror("Error", str(e))

   top = tk.Toplevel()
   top.title("Take Order")
   tk.Label(top, text="Enter Order ID:").pack()
   entry = tk.Entry(top)
   entry.pack()
   tk.Button(top, text="Submit", command=submit).pack()

# 3. View My Orders
def view_my_orders():
   rows = run_query("SELECT * FROM orders WHERE DeliveryAgent_ID = %s", params=(AGENT_ID,))
   if rows:
      result = "\n".join(str(row) for row in rows)
      messagebox.showinfo("My Orders", result)

# 4. Monthly Completed Deliveries
def monthly_deliveries():
   rows = run_query("""
   SELECT DATE_FORMAT(o.date, '%Y-%m') AS Month, COUNT(o.Order_ID) AS Total_Deliveries
   FROM orders o
   WHERE o.DeliveryAgent_ID = %s AND o.status = 'Delivered'
   GROUP BY Month ORDER BY Month DESC
   """, params=(AGENT_ID,))
   if rows:
      result = "\n".join(str(row) for row in rows)
      messagebox.showinfo("Monthly Deliveries", result)

# 5. Average Rating
def avg_rating():
   rows = run_query("""
   SELECT AVG(dr.rating) AS Average_Rating
   FROM Delivery_Review dr
   JOIN orders o ON dr.Order_ID = o.Order_ID
   WHERE o.DeliveryAgent_ID = %s
   """, params=(AGENT_ID,))
   if rows and rows[0][0] is not None:
      messagebox.showinfo("Average Rating", f"{rows[0][0]:.2f}")
   else:
      messagebox.showinfo("Average Rating", "No ratings found.")

# 6. Update Personal Details
def show_update_agent_info():
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
         dob = entries["dob_entry"].get().strip()

         if first_name:
               run_query("""
                  UPDATE DeliveryAgent
                  SET first_name = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(first_name, AGENT_ID))

         if last_name:
               run_query("""
                  UPDATE DeliveryAgent
                  SET last_name = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(last_name, AGENT_ID))

         if age:
               try:
                  age_val = int(age)
                  if age_val < 0:
                     raise ValueError("Age cannot be negative.")
               except ValueError:
                  raise ValueError("Age must be a valid integer.")
               run_query("""
                  UPDATE DeliveryAgent
                  SET age = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(age_val, AGENT_ID))

         if email:
               run_query("""
                  UPDATE DeliveryAgent
                  SET email = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(email, AGENT_ID))

         if password:
               run_query("""
                  UPDATE DeliveryAgent
                  SET password = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(password, AGENT_ID))

         if phone:
               try:
                  phone_val = int(phone)
               except ValueError:
                  raise ValueError("Phone number must be a valid number.")
               run_query("""
                  UPDATE DeliveryAgent
                  SET phone_number = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(phone_val, AGENT_ID))

         if dob:
               run_query("""
                  UPDATE DeliveryAgent
                  SET dob = %s
                  WHERE DeliveryAgent_ID = %s;
               """, fetch=False, params=(dob, AGENT_ID))

         messagebox.showinfo("Success", "Agent updated successfully!")

      except Exception as e:
         messagebox.showerror("Error", f"Something went wrong: {e}")

   tk.Button(update_window, text="Update Info", command=submit).pack(pady=20)

# 7. View Personal Details
def view_details():
   rows = run_query("SELECT * FROM DeliveryAgent WHERE DeliveryAgent_ID = %s", params=(AGENT_ID,))
   if rows:
      messagebox.showinfo("My Details", str(rows[0]))

# 8. Update Availability
def update_availability():
   top = tk.Toplevel()
   top.title("Update Availability")

   tk.Label(top, text="Set status (Available/Busy/On leave):").pack()
   status_entry = tk.Entry(top)
   status_entry.pack()

   def submit():
      status = status_entry.get().strip()
      if status not in ["Available", "Busy", "On Leave"]:
         messagebox.showerror("Input Error", "Enter 'Available' or 'Busy' or 'On Leave'")
         return
      run_query("UPDATE DeliveryAgent SET availability_status = %s WHERE DeliveryAgent_ID = %s",
                fetch=False, params=(status, AGENT_ID))
      messagebox.showinfo("Success", "Status updated.")
      top.destroy()

   tk.Button(top, text="Submit", command=submit).pack()

# 9. Count Total Deliveries in a Month
def deliveries_in_month():
   top = tk.Toplevel()
   top.title("Deliveries in Month")

   tk.Label(top, text="Enter Month (1-12):").pack()
   month_entry = tk.Entry(top)
   month_entry.pack()
   tk.Label(top, text="Enter Year:").pack()
   year_entry = tk.Entry(top)
   year_entry.pack()

   def submit():
      try:
         month = int(month_entry.get())
         year = int(year_entry.get())
         row = run_query("""
            SELECT COUNT(Order_ID) FROM orders
            WHERE DeliveryAgent_ID = %s AND MONTH(date) = %s AND YEAR(date) = %s
         """, params=(AGENT_ID, month, year))
         messagebox.showinfo("Total Deliveries", f"Deliveries: {row[0][0]}")
         top.destroy()
      except Exception as e:
         messagebox.showerror("Error", str(e))

   tk.Button(top, text="Submit", command=submit).pack()

# 10. View Feedback
def view_feedback():
   rows = run_query("""
   SELECT dr.comment, dr.rating
   FROM Delivery_Review dr
   JOIN orders o ON dr.Order_ID = o.Order_ID
   WHERE o.DeliveryAgent_ID = %s
   """, params=(AGENT_ID,))
   if rows:
      result = "\n".join([f"Rating: {r[1]}, Comment: {r[0]}" for r in rows])
      messagebox.showinfo("Feedback", result)

# GUI Layout
root = tk.Tk()
root.title("Delivery Agent Panel")

tk.Label(root, text="HELLO AGENT ID " + str(AGENT_ID) + " !").pack()

tk.Button(root, text="1. View Pending Orders", command=view_pending_orders).pack(pady=2)
tk.Button(root, text="2. Take an Order", command=take_order).pack(pady=2)
tk.Button(root, text="3. View My Orders", command=view_my_orders).pack(pady=2)
tk.Button(root, text="4. Monthly Deliveries", command=monthly_deliveries).pack(pady=2)
tk.Button(root, text="5. View Average Rating", command=avg_rating).pack(pady=2)
tk.Button(root, text="6. Update Personal Details", command=show_update_agent_info).pack(pady=2)
tk.Button(root, text="7. View My Details", command=view_details).pack(pady=2)
tk.Button(root, text="8. Update Availability", command=update_availability).pack(pady=2)
tk.Button(root, text="9. Count Deliveries (Month)", command=deliveries_in_month).pack(pady=2)
tk.Button(root, text="10. View Feedback", command=view_feedback).pack(pady=2)

root.mainloop()
