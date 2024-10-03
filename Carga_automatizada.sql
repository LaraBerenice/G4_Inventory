-- Insertar datos en la tabla Vendors
BULK INSERT Vendors
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\vendedores.csv'
WITH (
    FIELDTERMINATOR = ',',  -- O el delimitador que estés utilizando
    ROWTERMINATOR = '\n',   -- O '\r\n' si es necesario
    FIRSTROW = 2            -- Ignorar la primera fila (encabezados)
);
GO

-- Insertar datos en la tabla precios_compra
BULK INSERT precios_compra
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\2017PurchasePricesDec.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

-- Insertar datos en la tabla inventario_invierno
BULK INSERT inventario_invierno
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\BegInvFINAL12312016.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

-- Insertar datos en la tabla inventario_fin_invierno
BULK INSERT inventario_fin_invierno
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\EndInvFINAL12312016.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

-- Insertar datos en la tabla compras_finales
BULK INSERT compras_finales
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\PurchasesFINAL12312016.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

-- Insertar datos en la tabla ventas_finales
BULK INSERT ventas_finales
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\SalesFINAL12312016.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

-- Insertar datos en la tabla factura_de_compras
BULK INSERT factura_de_compras
FROM 'C:\Users\beren\Desktop\HENRRY\G4_Inventory\archive\InvoicePurchases12312016.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO
