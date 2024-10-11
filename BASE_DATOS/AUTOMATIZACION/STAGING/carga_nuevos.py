import pandas as pd
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import SQLAlchemyError

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

# Función para cargar CSV en DataFrames con manejo de errores
def cargar_csv(ruta_csv):
    try:
        df = pd.read_csv(ruta_csv)
        return df
    except Exception as e:
        print(f"Error al cargar {ruta_csv}: {e}")
        return None

# Leer los CSV en DataFrames
df1 = cargar_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\BASE_DATOS\AUTOMATIZACION\STAGING\Dim_Inventory.csv')
df2 = cargar_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\BASE_DATOS\AUTOMATIZACION\STAGING\Fact_Purchases_Final.csv')
df3 = cargar_csv(r'C:\Users\beren\Desktop\HENRRY\G4_Inventory\BASE_DATOS\AUTOMATIZACION\STAGING\Fact_Sales_Final.csv')

# Función para cargar datos en la base de datos
def cargar_datos(df, nombre_tabla, identity_column=None):
    # Validar que el DataFrame no esté vacío
    if df is None or df.empty:
        print(f"No hay datos para cargar en '{nombre_tabla}'.")
        return

    # Imprimir la data antes de cargar
    print(f"Data para cargar en '{nombre_tabla}':")
    print(df.head())  # Muestra las primeras filas del DataFrame

    # Convertir tipos automáticamente
    df = df.convert_dtypes()
    # Convertir columnas de fecha
    for col in df.columns:
        if 'date' in col.lower():
            df[col] = pd.to_datetime(df[col], errors='coerce')
    # Eliminar filas con fechas inválidas
    df = df.dropna()

    # Imprimir información sobre el DataFrame después de limpiar
    print(f"Tamaño de {nombre_tabla} después de limpieza: {df.shape[0]} filas, {df.shape[1]} columnas")

    # Si hay una columna IDENTITY, eliminarla antes de la carga
    if identity_column and identity_column in df.columns:
        df = df.drop(columns=[identity_column])
    
    # Cargar datos en la base de datos
    try:
        df.to_sql(nombre_tabla, con=engine, if_exists='append', index=False, method='multi')
        print(f"Datos cargados exitosamente en '{nombre_tabla}'.")
    except SQLAlchemyError as e:
        print(f"Error al insertar datos en '{nombre_tabla}': {e}")

# Crear una nueva sesión
with Session() as session:
    # Cargar los DataFrames en la base de datos
    cargar_datos(df1, 'Dim_Inventory')  
    cargar_datos(df2, 'Fact_Purchases_Final', identity_column='Purchase_ID')
    cargar_datos(df3, 'Fact_Sales_Final', identity_column='Sales_ID')

    # Agregar restricciones de clave foránea después de cargar datos
    try:
        session.execute(text('ALTER TABLE dbo.Fact_Purchases_Final ADD FOREIGN KEY (InventoryId) REFERENCES dbo.Dim_Inventory(InventoryId);'))
        session.execute(text('ALTER TABLE dbo.Fact_Sales_Final ADD FOREIGN KEY (InventoryId) REFERENCES dbo.Dim_Inventory(InventoryId);'))
        session.commit()
        print("Restricciones de clave foránea agregadas exitosamente.")
    except SQLAlchemyError as e:
        print(f"Error al agregar restricciones de clave foránea: {e}")
        session.rollback()

print("Datos procesados exitosamente.")
