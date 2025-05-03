

import tkinter as tk
import mysql.connector
from tkinter import messagebox

def submit():
   try:
      # Connect to MySQL database
      conn = mysql.connector.connect(
            host="localhost",       
            user="root",   
            password="Vuductung2005*",  
            database="sports_store_db"   
      )

      cursor = conn.cursor()

      cursor.execute("SELECT * FROM Product")
      
      rows = cursor.fetchall()
      result = "\n".join([" | ".join(str(cell) for cell in row) for row in rows])
      messagebox.showinfo("Database Records", result)
      conn.close()

   except mysql.connector.Error as err:
      messagebox.showerror("Database Error", f"Error: {err}")

# GUI layout
root = tk.Tk()
root.title("Customer form")

tk.Button(root, text="Search item", command=submit).pack()
tk.Button(root, text="Search brand", command=submit).pack()
tk.Button(root, text="Search category", command=submit).pack()

root.mainloop()
