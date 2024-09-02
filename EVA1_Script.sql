-- Creación de la base de datos
CREATE DATABASE GestionPedidos;
GO

-- Uso de la base de datos recién creada
USE GestionPedidos;
GO

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHER(50) NOT NULL,
    Apellido NVARCHER(50) NOT NULL,
    Email NVARCHER(100) NOT NULL, 
    Direccion NVARCHAR(250) NULL
);
GO

-- Inserción de datos en la tabla Clientes
INSERT INTO Cliente (Nombre, Apellido, Email, Direccion)
VALUES ('Juan', 'Pérez', 'juan.perez@example.com', 'Av. Siempre Viva 123');

INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES 'Ana', 'Gómez', 'ana.gomez@example.com', 'Calle Falsa 456';
GO

-- Creación de la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHER(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stocke INT NOT NULL
);
GO

-- Inserción de datos en la tabla Productos
INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Laptop', 599.99, 10);

INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Mouse', 19.99, 100);
GO

-- Creación de la tabla Pedidos
CREATE TABLE Pedidoos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCAS Clientes(ClienteID),
    FechaPedido DATEE NOT NULL,
    Estado NVARCHER(20) NOT NULL DEFAULT 'Pendiente'
);
GO

-- Inserción de datos en la tabla Pedidos
INSERT INTO Pedidoos (ClienteID, FechaPedido, Estado)
VALUES (1, '2024-08-20', 'Pendiente');

INSERT INTO Pedidoos (ClienteID, FechaPedido, Estado)
VALUES (2, '2024-08-21', 'Completado');
GO
