-- Crear la base de datos
CREATE DATABASE InventarioDB;
GO

-- Usar la base de datos reci�n creada
USE InventarioDB;
GO

-- Crear tabla Vendors
-- agregar NOT NULL a VendorName para asegurar de que siempre haya un nombre de proveedor.
CREATE TABLE Vendors (
    VendorNumber INT PRIMARY KEY,
    VendorName VARCHAR(255) NOT NULL
);
GO

-- Crear tabla precios_compra
--A�adir el tipo de dato INT a RowPurchasesID.
CREATE TABLE precios_compra (
    RowPurchasesID INT PRIMARY KEY IDENTITY(1,1),
    Brand Varchar(225),
    Description VARCHAR(255),
    Price DECIMAL(10, 2),
    Size VARCHAR(50),
    Volume INT,
    Classification INT,
    PurchasePrice DECIMAL(10, 2),
    VendorNumber INT,
    VendorName VARCHAR(255),
    FOREIGN KEY (VendorNumber) REFERENCES Vendors(VendorNumber)
);
GO

-- Crear tabla inventario_invierno
CREATE TABLE inventario_invierno (
    InventoryId VARCHAR(50) PRIMARY KEY,
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10, 2),
    startDate DATE
);
GO

-- Crear tabla inventario_fin_invierno
--gregar FOREIGN KEY para InventoryId
CREATE TABLE inventario_fin_invierno (
    RowInventoryID INT PRIMARY KEY IDENTITY(1,1),
    InventoryId VARCHAR(50),
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10, 2),
    endDate DATE,
    FOREIGN KEY (InventoryId) REFERENCES inventario_invierno(InventoryId)
);
GO

-- Crear tabla compras_finales
CREATE TABLE compras_finales (
    RowID INT PRIMARY KEY IDENTITY (1,1),
    InventoryId VARCHAR(50),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    VendorNumber INT,
    VendorName VARCHAR(255),
    PONumber INT,
    PODate DATE,
    ReceivingDate DATE,
    InvoiceDate DATE,
    PayDate DATE,
    PurchasePrice DECIMAL(10, 2),
    Quantity INT,
    Dollars DECIMAL(10, 2),
    Classification INT,
    FOREIGN KEY (InventoryId) REFERENCES inventario_invierno(InventoryId),
    FOREIGN KEY (VendorNumber) REFERENCES Vendors(VendorNumber)
);
GO

-- Crear tabla ventas_finales
CREATE TABLE ventas_finales (
    IdSales INT PRIMARY KEY IDENTITY(1,1),
    InventoryId VARCHAR(50),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    SalesQuantity INT,
    SalesDollars DECIMAL(10, 2),
    SalesPrice DECIMAL(10, 2),
    SalesDate DATE,
    Volume INT,
    Classification INT,
    ExciseTax DECIMAL(10, 2),
    VendorNo INT,
    VendorName VARCHAR(255),
    FOREIGN KEY (VendorNo) REFERENCES Vendors(VendorNumber)
);
GO

-- Crear tabla factura_de_compras
CREATE TABLE factura_de_compras (
    VendorNumber INT,
    VendorName VARCHAR(255),
    InvoiceDate DATE,
    PONumber INT PRIMARY KEY,
    PODate DATE,
    PayDate DATE,
    Quantity INT,
    Dollars DECIMAL(15, 2),
    Freight DECIMAL(10, 2),
    Approval VARCHAR(255) NULL,
    FOREIGN KEY (VendorNumber) REFERENCES Vendors(VendorNumber)
);
GO
