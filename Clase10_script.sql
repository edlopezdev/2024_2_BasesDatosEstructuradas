-- ============================================================
-- CREACIÓN DE BASE DE DATOS, TABLAS Y RELACIONES
-- ============================================================

-- 1. Crear la base de datos
CREATE DATABASE SistemaAuditoria;
GO

-- 2. Usar la base de datos recién creada
USE SistemaAuditoria;
GO

-- 3. Crear la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Estado NVARCHAR(10) DEFAULT 'Activo'
);
GO

-- 4. Crear la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);
GO

-- 5. Crear la tabla Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaVenta DATE NOT NULL,
    TotalVenta DECIMAL(10,2) NOT NULL
);
GO

-- 6. Crear la tabla DetallesVenta (relación entre Ventas y Productos)
CREATE TABLE DetallesVenta (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT FOREIGN KEY REFERENCES Ventas(VentaID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL
);
GO

-- ============================================================
-- INSERCIÓN DE DATOS FICTICIOS
-- ============================================================

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Estado)
VALUES 
('Juan', 'Pérez', 'juan.perez@example.com', 'Activo'),
('Ana', 'Gómez', 'ana.gomez@example.com', 'Activo'),
('Carlos', 'López', 'carlos.lopez@example.com', 'Inactivo');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES 
('Laptop', 1000.00, 20),
('Mouse', 25.00, 100),
('Teclado', 45.00, 50),
('Monitor', 300.00, 15);

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (ClienteID, FechaVenta, TotalVenta)
VALUES 
(1, '2024-09-01', 1070.00),
(2, '2024-09-02', 600.00),
(3, '2024-09-03', 400.00);

-- Insertar datos en la tabla DetallesVenta
INSERT INTO DetallesVenta (VentaID, ProductoID, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 1, 1000.00),  -- Laptop
(1, 2, 2, 25.00),    -- Mouse
(2, 4, 2, 300.00),   -- Monitor
(3, 3, 3, 45.00);    -- Teclado
