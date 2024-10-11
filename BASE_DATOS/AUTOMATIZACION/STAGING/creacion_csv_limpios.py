import pandas as pd
import os

# Definir la ruta donde se guardarán los CSV vacíos
output_dir = r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\AUTOMATIZACION\STAGING'

# Crear la carpeta si no existe
os.makedirs(output_dir, exist_ok=True)

# Definir las estructuras de columnas para los CSV vacíos
columnas_dim_inventory = [
    'InventoryId', 'Store', 'City', 'Brand', 'Description',
    'Size', 'OnHand_beg', 'Price_beg', 'StartDate',
    'OnHand_end', 'Price_end', 'EndDate'
]

columnas_fact_purchases = [
    'Purchase_ID', 'InventoryId', 'VendorNumber', 'VendorName',
    'PONumber', 'PODate', 'ReceivingDate', 'InvoiceDate',
    'PayDate', 'PurchasePrice', 'Quantity', 'Dollars',
    'Classification'
]

columnas_fact_sales = [
    'Sales_ID', 'InventoryId', 'SalesQuantity', 'SalesDollars',
    'SalesPrice', 'SalesDate', 'Volume', 'Classification',
    'ExciseTax', 'VendorNo', 'VendorName'
]

# Crear CSV vacíos
pd.DataFrame(columns=columnas_dim_inventory).to_csv(os.path.join(output_dir, 'DimInventory_vacio.csv'), index=False)
pd.DataFrame(columns=columnas_fact_purchases).to_csv(os.path.join(output_dir, 'FactPurchases_vacio.csv'), index=False)
pd.DataFrame(columns=columnas_fact_sales).to_csv(os.path.join(output_dir, 'FactSales_vacio.csv'), index=False)

print("CSV vacíos creados exitosamente.")
