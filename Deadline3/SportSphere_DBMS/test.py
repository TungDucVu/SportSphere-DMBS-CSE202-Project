import tkinter as tk
from tkinter import messagebox

# Sample product dictionary (simulate a product database)
product = {
    "id": "P001",
    "name": "Laptop",
    "price": 999.99,
    "quantity": 10
}

def update_product():
    update_btn.pack_forget()

    tk.Label(root, text="Product ID:").pack()
    name_entry.insert(0, product["id"])
    name_entry.pack()

    tk.Label(root, text="Product Name:").pack()
    name_entry.insert(0, product["name"])
    name_entry.pack()

    tk.Label(root, text="Price:").pack()
    price_entry.insert(0, str(product["price"]))
    price_entry.pack()

    tk.Label(root, text="Quantity:").pack()
    quantity_entry.insert(0, str(product["quantity"]))
    quantity_entry.pack()

    submit_btn.pack(pady=10)

def submit_update():
    # Update the product dictionary
    try:
        product["name"] = name_entry.get()
        product["price"] = float(price_entry.get())
        product["quantity"] = int(quantity_entry.get())

        messagebox.showinfo("Success", "Product details updated successfully!")

        # Optional: hide fields after submit
        name_entry.delete(0, tk.END)
        price_entry.delete(0, tk.END)
        quantity_entry.delete(0, tk.END)
        for widget in root.pack_slaves():
            if isinstance(widget, tk.Entry) or isinstance(widget, tk.Label):
                widget.pack_forget()
        submit_btn.pack_forget()
        update_btn.pack(pady=20)

    except ValueError:
        messagebox.showerror("Error", "Please enter valid numeric values for price and quantity.")

# GUI setup
root = tk.Tk()
root.title("Product Updater")
root.geometry("300x300")

update_btn = tk.Button(root, text="Update Product", command=update_product)
update_btn.pack(pady=20)

name_entry = tk.Entry(root)
price_entry = tk.Entry(root)
quantity_entry = tk.Entry(root)

submit_btn = tk.Button(root, text="Submit", command=submit_update)

root.mainloop()
