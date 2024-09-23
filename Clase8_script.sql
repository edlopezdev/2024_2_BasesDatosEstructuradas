-- ============================================================
-- CREACIÓN DE BASE DE DATOS Y TABLAS CON RELACIONES
-- ============================================================

-- 1. Creación de la base de datos
CREATE DATABASE GestionSeguridad;
GO

-- 2. Uso de la base de datos recién creada
USE GestionSeguridad;
GO

-- 3. Creación de la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    FechaRegistro DATE DEFAULT GETDATE(),
    Estado NVARCHAR(10) DEFAULT 'Activo'
);
GO

-- 4. Creación de la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);
GO

-- 5. Creación de la tabla Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaVenta DATE NOT NULL,
    TotalVenta DECIMAL(10,2) NOT NULL
);
GO

-- 6. Creación de la tabla DetallesVenta (relación entre Ventas y Productos)
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

-- Insertar datos ficticios en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email)
VALUES 
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'Gómez', 'ana.gomez@example.com'),
('Carlos', 'López', 'carlos.lopez@example.com');

-- Insertar datos ficticios en la tabla Productos
INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES 
('Laptop', 1000.00, 20),
('Mouse', 25.00, 100),
('Teclado', 45.00, 50),
('Monitor', 300.00, 15);

-- Insertar datos ficticios en la tabla Ventas
INSERT INTO Ventas (ClienteID, FechaVenta, TotalVenta)
VALUES 
(1, '2024-09-01', 1070.00),
(2, '2024-09-02', 600.00),
(3, '2024-09-03', 400.00);

-- Insertar datos ficticios en la tabla DetallesVenta
INSERT INTO DetallesVenta (VentaID, ProductoID, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 1, 1000.00),  -- Laptop
(1, 2, 2, 25.00),    -- Mouse
(2, 4, 2, 300.00),   -- Monitor
(3, 3, 3, 45.00);    -- Teclado

-- ============================================================
-- EJERCICIOS RELACIONADOS CON LA SEGURIDAD EN BASES DE DATOS
-- ============================================================

-- EJERCICIO 1: CREACIÓN DE UN ROL CON PERMISOS RESTRINGIDOS
-- Objetivo: Crear un rol que permita solo la consulta de la tabla Ventas y los detalles de ventas.
-- 1. Crear un rol llamado 'consulta_ventas'.
-- 2. Otorgar permisos de solo lectura (SELECT) en las tablas Ventas y DetallesVenta.
-- 3. Crear un usuario llamado 'UsuarioConsulta' y asignarle el rol 'consulta_ventas'.
-- 4. Probar si el usuario puede consultar las ventas pero no modificar datos.

-- EJERCICIO 2: CREAR UNA AUDITORÍA DE CAMBIOS
-- Objetivo: Registrar todas las actualizaciones que se realicen sobre el total de ventas.
-- 1. Crear una tabla llamada 'AuditoriaVentas' para registrar las actualizaciones.
-- 2. Implementar un trigger que se dispare cada vez que se actualice el total de una venta en la tabla Ventas.
-- 3. El trigger debe registrar el ID de la venta, el total anterior, el total nuevo, la fecha y el usuario que realizó la operación.

-- EJERCICIO 3: RESTRINGIR LA ELIMINACIÓN DE CLIENTES CON VENTAS ACTIVAS
-- Objetivo: Prevenir la eliminación de clientes que tengan ventas asociadas.
-- 1. Implementar un trigger que impida la eliminación de registros en la tabla Clientes si el cliente tiene ventas activas en la tabla Ventas.
-- 2. Probar el trigger intentando eliminar un cliente con ventas registradas.

-- EJERCICIO 4: PERMISOS A NIVEL DE COLUMNA
-- Objetivo: Crear un rol que permita solo la lectura de ciertas columnas en la tabla Clientes.
-- 1. Crear un rol llamado 'lectura_limitada'.
-- 2. Asignar permisos de solo lectura (SELECT) en las columnas Nombre, Apellido y Estado de la tabla Clientes.
-- 3. Crear un usuario llamado 'UsuarioLectura' y asignarle el rol 'lectura_limitada'.
-- 4. Probar si el usuario puede consultar solo las columnas permitidas.

-- EJERCICIO 5: REVISIÓN Y REVOCACIÓN DE PERMISOS
-- Objetivo: Revisar los permisos actuales de un usuario y revocar permisos innecesarios.
-- 1. Consultar los permisos actuales del usuario 'UsuarioConsulta'.
-- 2. Revocar el permiso de consulta (SELECT) en la tabla DetallesVenta para este usuario.
-- 3. Probar si el usuario sigue pudiendo consultar la tabla Ventas, pero ya no DetallesVenta.

-- EJERCICIO 6: CREACIÓN DE UN TRIGGER DE INSERCIÓN
-- Objetivo: Crear un trigger que registre en una tabla de auditoría cada vez que se inserte un nuevo producto.
-- 1. Crear una tabla llamada 'AuditoriaProductos' que registre el ID del producto, su nombre, precio y la fecha de inserción.
-- 2. Implementar un trigger que capture la inserción en la tabla Productos y registre los datos en la tabla de auditoría.
