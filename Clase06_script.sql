-- Creación de la base de datos
CREATE DATABASE GestionPedidos;
GO

-- Uso de la base de datos recién creada
USE GestionPedidos;
GO

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE, -- Email debe ser único
    Direccion NVARCHAR(250) NULL
);
GO

-- Inserción de datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Juan', 'Pérez', 'juan.perez@example.com', 'Av. Siempre Viva 123');

INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Ana', 'Gómez', 'ana.gomez@example.com', 'Calle Falsa 456');
GO

-- Creación de la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL  -- Stock disponible
);
GO

-- Inserción de datos en la tabla Productos
INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Laptop', 599.99, 10);

INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Mouse', 19.99, 100);

INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Teclado', 49.99, 50);
GO

-- Creación de la tabla Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaPedido DATE NOT NULL,
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Pendiente'
);
GO

-- Inserción de datos en la tabla Pedidos
INSERT INTO Pedidos (ClienteID, FechaPedido, Estado)
VALUES (1, '2024-08-20', 'Pendiente');

INSERT INTO Pedidos (ClienteID, FechaPedido, Estado)
VALUES (2, '2024-08-21', 'Completado');
GO

-- Creación de la tabla DetallesPedido para relacionar productos y pedidos
CREATE TABLE DetallesPedido (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL
);
GO

-- Inserción de datos en la tabla DetallesPedido
INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad)
VALUES (1, 1, 2); -- Pedido de 2 Laptops

INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad)
VALUES (1, 2, 5); -- Pedido de 5 Mouse

INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad)
VALUES (2, 3, 3); -- Pedido de 3 Teclados
GO

-- Creación de la tabla AuditoriaStock para registrar los cambios en el stock de productos
CREATE TABLE AuditoriaStock (
    AuditoriaID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT,
    StockAnterior INT,
    StockNuevo INT,
    FechaCambio DATETIME DEFAULT GETDATE()
);
GO
