-- 1. Creación de la base de datos
CREATE DATABASE SistemaVentas;
GO

-- 2. Uso de la base de datos recién creada
USE SistemaVentas;
GO

-- 3. Creación de la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Direccion NVARCHAR(250) NULL
);
GO

-- 4. Inserción de datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Juan', 'Pérez', 'juan.perez@example.com', 'Av. Siempre Viva 123');

INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Ana', 'Gómez', 'ana.gomez@example.com', 'Calle Falsa 456');
GO

-- 5. Creación de la tabla Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaVenta DATE NOT NULL,
    TotalVenta DECIMAL(10,2) NOT NULL
);
GO

-- 6. Inserción de datos en la tabla Ventas
INSERT INTO Ventas (ClienteID, FechaVenta, TotalVenta)
VALUES (1, '2024-09-10', 199.99);

INSERT INTO Ventas (ClienteID, FechaVenta, TotalVenta)
VALUES (2, '2024-09-11', 299.99);
GO
