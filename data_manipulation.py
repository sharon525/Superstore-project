import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

#reading the data
data = pd.read_csv("E:\SuperStoredata\Sample - Superstore.csv")

#check for nulls
print(data.isnull().sum())

#check for duplicates
duplicates = data.duplicated()
print("number of duplicates:",duplicates.sum())


#check the data types
print(data.dtypes)

# modify data types
data['Order ID'] = data["Order ID"].astype('string')

data['Order Date'] = pd.to_datetime(data["Order Date"],errors = "coerce")

data['Ship Date'] = pd.to_datetime(data["Ship Date"],errors = "coerce")

data['Ship Mode'] = data["Ship Mode"].astype('category')

data['Customer ID'] = data["Customer ID"].astype('string')

data['Customer Name'] = data["Customer Name"].astype('string')

data['Segment'] = data["Segment"].astype('category')

data['Country'] = data["Country"].astype('category')

data['City'] = data["City"].astype('category')

data['State'] = data["State"].astype('category')

data['Postal Code'] =data["Postal Code"].astype('string')

data['Region'] = data["Region"].astype('category')

data['Product ID'] = data["Product ID"].astype('string')

data['Category'] = data["Category"].astype('category')

data['Sub-Category'] = data["Sub-Category"].astype('category')

data['Product Name'] = data["Product Name"].astype('string')

print(data.dtypes)


# now lets split the data to Tables

customers = data[['Customer ID', 'Customer Name', 'Segment']].drop_duplicates()

# 2. Products Table
products = data[['Product ID', 'Product Name', 'Category', 'Sub-Category']].drop_duplicates()

# 3. Orders Table
orders = data[['Order ID', 'Order Date', 'Ship Date', 'Ship Mode', 'Customer ID','Country', 'City', 'State', 'Postal Code', 'Region']].drop_duplicates()

# 4. OrderDetails Table
order_details = data[['Row ID', 'Order ID', 'Product ID', 'Sales', 'Quantity', 'Discount', 'Profit']]

# save tables as csv files for ssms import
customers.to_csv('customers.csv', index=False)
products.to_csv('products.csv', index=False)
orders.to_csv('orders.csv', index=False)
order_details.to_csv('order_details.csv', index=False)

#read new data tables

orders = pd.read_csv("E:\SuperStoredata\orders.csv")
customers = pd.read_csv("E:\SuperStoredata\customers.csv")
order_details = pd.read_csv("E:\SuperStoredata\order_details.csv")
products = pd.read_csv("E:\SuperStoredata\products.csv")

#check for nulls
print(orders.isnull().sum())
print(customers.isnull().sum())
print(order_details.isnull().sum())
print(products.isnull().sum())

#check for duplicates
duplicated_orders = orders.duplicated()
duplicated_customers = customers.duplicated()
duplicated_order_details = order_details.duplicated()
duplicated_products = products.duplicated()

print("number of orders duplicates: ",duplicated_orders.sum())
print("number of customers duplicates: ",duplicated_customers.sum())
print("number of order_details duplicates: ",duplicated_order_details.sum())
print("number of products duplicates",duplicated_products.sum())


#trying to load the data to sql we see that there are products with the same id 
pro = pd.read_csv("E:\SuperStoredata\products.csv")

print("-------------------------")
pro_duplicates = pro[pro['Product ID'].duplicated(keep=False)]
print(pro_duplicates)

id_counts = pro['Product ID'].value_counts()
print(id_counts[id_counts > 1])

# we remove the duplicated products (keeping the first)
pro = pro.drop_duplicates(subset='Product ID')

# check again
print("-------------------------")
pro_duplicates = pro[pro['Product ID'].duplicated(keep=False)]
print(pro_duplicates)

id_counts = pro['Product ID'].value_counts()
print(id_counts[id_counts > 1])

#save as csv

pro.to_csv('products.csv', index=False) 
