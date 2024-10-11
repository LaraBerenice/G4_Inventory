import pandas as pd
import numpy as np
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import SQLAlchemyError

# Leer los CSV en DataFrames
df1 = pd.read_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\Limpieza_Datos\DimInventory_fv.csv')
df2 = pd.read_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\Limpieza_Datos\FactPurchases_fv.csv')
df3 = pd.read_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\Limpieza_Datos\FactSales_fv.csv')
# Cargar las variables de entorno desde el archivo .env
load_dotenv()

# Obtener las variables de entorno
hostname = os.getenv("DB_HOST")
db = os.getenv("DB_NAME")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")

# Cambiar la cadena de conexión para SQL Server
db_url = f"mssql+pyodbc://{user}:{password}@{hostname}/{db}?driver=ODBC+Driver+17+for+SQL+Server"

# Crear el motor de base de datos
engine = create_engine(db_url, echo=True)
Session = sessionmaker(bind=engine)
session = Session()

#------------------------------------------------
# Función para crear tabla si no existe
def create_table_if_not_exists(create_table_sql):
    table_name = create_table_sql.split()[2]  # Obtener el nombre de la tabla
    check_table_sql = f'''
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{table_name}' AND TABLE_SCHEMA = 'dbo')
    BEGIN
        {create_table_sql}
    END
    '''
    try:
        session.execute(text(check_table_sql))
        session.commit()
    except SQLAlchemyError as e:
        print(f"Error al crear la tabla '{table_name}': {e}")
        session.rollback()

# Definir las consultas SQL para crear las tablas
create_dim_inventory = '''
CREATE TABLE dbo.Dim_Inventory (
    InventoryId VARCHAR(255) PRIMARY KEY,
    Store INT,
    City VARCHAR(255),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(255),
    OnHand_beg INT,
    Price_beg FLOAT,
    StartDate DATE,
    OnHand_end INT,
    Price_end FLOAT,
    EndDate DATE
);
'''

create_fact_purchases_final = '''
CREATE TABLE dbo.Fact_Purchases_Final (
    Purchase_ID INT IDENTITY(1,1) PRIMARY KEY,
    InventoryId VARCHAR(255),
    VendorNumber INT,
    VendorName VARCHAR(255),
    PONumber INT,
    PODate DATE,
    ReceivingDate DATE,
    InvoiceDate DATE,
    PayDate DATE,
    PurchasePrice FLOAT,
    Quantity INT,
    Dollars FLOAT,
    Classification INT,
    FOREIGN KEY (InventoryId) REFERENCES dbo.Dim_Inventory(InventoryId)
);
'''

create_fact_sales_final = '''
CREATE TABLE dbo.Fact_Sales_Final (
    Sales_ID INT IDENTITY(1,1) PRIMARY KEY,
    InventoryId VARCHAR(255),
    SalesQuantity INT,
    SalesDollars FLOAT,
    SalesPrice FLOAT,
    SalesDate DATE,
    Volume INT,
    Classification INT,
    ExciseTax FLOAT,
    VendorNo INT,
    VendorName VARCHAR(255),
    FOREIGN KEY (InventoryId) REFERENCES dbo.Dim_Inventory(InventoryId)
);
'''

# Crear las tablas
create_table_if_not_exists(create_dim_inventory)
create_table_if_not_exists(create_fact_purchases_final)
create_table_if_not_exists(create_fact_sales_final)

#------------------------------------------------
# Función para verificar claves primarias existentes
def verificar_clave_primaria_existente(df, nombre_tabla, clave_primaria):
    consulta_sql = f"SELECT {clave_primaria} FROM {nombre_tabla}"
    try:
        claves_existentes = pd.read_sql(consulta_sql, con=engine)
        df = df[~df[clave_primaria].isin(claves_existentes[clave_primaria])]
        return df
    except SQLAlchemyError as e:
        print(f"Error al verificar clave primaria en '{nombre_tabla}': {e}")
        return df

#------------------------------------------------
# Función para procesar DataFrames
def procesar_dataframes(dfs, nombres_tablas, claves_primarias):
    for df, nombre_tabla, clave_primaria in zip(dfs, nombres_tablas, claves_primarias):
        # Eliminar duplicados en el DataFrame si tiene clave primaria
        if clave_primaria in df.columns:
            df.drop_duplicates(subset=[clave_primaria], inplace=True)

            # Verificar que no existan claves primarias duplicadas en la base de datos
            df = verificar_clave_primaria_existente(df, nombre_tabla, clave_primaria)

        # Convertir tipos automáticamente
        df = df.convert_dtypes()

        # Convertir columnas de fecha
        for col in df.columns:
            if 'date' in col.lower():
                df[col] = pd.to_datetime(df[col], errors='coerce')

        # Eliminar filas con fechas inválidas
        df = df.dropna()

        # Cargar datos en la base de datos, omitiendo la columna de identidad si no está en el DataFrame
        columnas_a_insertar = df.columns.tolist()
        
        # Si la tabla tiene una columna de identidad, no la incluimos en la inserción
        if nombre_tabla == 'Fact_Purchases_Final' or nombre_tabla == 'Fact_Sales_Final':
            # Omite la columna de identidad
            columnas_a_insertar = [col for col in columnas_a_insertar if col != clave_primaria]

        # Filtrar el DataFrame para incluir solo las columnas a insertar
        df_filtered = df[columnas_a_insertar]

        try:
            # Aquí se llama a to_sql sin el argumento 'columns'
            df_filtered.to_sql(nombre_tabla, con=engine, if_exists='append', index=False)
            print(f"Datos cargados exitosamente en '{nombre_tabla}'.")
        except SQLAlchemyError as e:
            print(f"Error al insertar datos en '{nombre_tabla}': {e}")
            session.rollback()

#------------------------------------------------
# Procesar los DataFrames
dataframes = [df1, df2, df3]
nombres_tablas = ['Dim_Inventory', 'Fact_Purchases_Final', 'Fact_Sales_Final']
claves_primarias = ['InventoryId', 'Purchase_ID', 'Sales_ID']

procesar_dataframes(dataframes, nombres_tablas, claves_primarias)

# Confirmar cambios y cerrar la sesión
session.commit()
session.close()

print("Tablas creadas exitosamente y datos procesados.")
