-- ============================================================
-- EVALUACIÓN DE BASES DE DATOS: ROLES, AUDITORÍA Y TRANSACCIONES
--Nombre: 
Enviar a: edgar.lopez@inacapmail.cl
-- ============================================================
-- Duración: 1h 30m
-- Instrucciones: Realizar las consultas SQL indicadas en cada pregunta y mostrar sus resultados.
-- El script debe ser capaz de ejecutarse sin errores.
-- No olvides comentar cualquier explicación adicional que consideres necesaria.

-- ============================================================
-- Pregunta 1: Creación de Roles y Permisos (20 puntos)
-- ============================================================
-- a) Crea un rol llamado 'rol_ventas' que tenga permisos de inserción en la tabla `Ventas`. (10 pts)
-- b) Crea un usuario 'UsuarioVentas' y asígnale el rol 'rol_ventas'. (10 pts)
-- Probar el acceso insertando una nueva venta usando este usuario.

-- ============================================================
-- Pregunta 2: Auditoría con Triggers (30 puntos)
-- ============================================================
-- a) Crea una tabla llamada 'AuditoriaClientes' que registre cualquier cambio en el estado de los clientes(de 'Activo' a 'Inactivo' o viceversa) -Añade las columnas que consideres pertinentes-. (10 pts)
-- b) Implementa un trigger que registre estos cambios en la tabla `Clientes`. (20 pts)
-- Cada vez que el estado de un cliente sea modificado, los cambios deben registrarse en la tabla 'AuditoriaClientes'.

-- ============================================================
-- Pregunta 3: Transacciones con TRY...CATCH (30 puntos)
-- ============================================================
-- a) Implementa una transacción para registrar una nueva venta en la tabla `Ventas` y los detalles en la tabla `DetallesVenta`. (20 pts)
-- b) Usa un bloque `TRY...CATCH` para manejar cualquier error durante la transacción, y si ocurre algún error, realiza un `ROLLBACK`. (10 pts)

-- ============================================================
-- Pregunta 4: Manejo de Permisos con Roles (20 puntos)
-- ============================================================
-- a) Crea un rol llamado 'rol_lectura_productos' que tenga permisos de solo lectura en la tabla `Productos`. (10 pts)
-- b) Asigna a un usuario llamado 'UsuarioConsulta' el rol 'rol_lectura_productos'. Luego, revoca al rol los permisos de actualización y eliminación en la tabla `Productos`. (10 pts)
-- Probar el acceso mostrando que el usuario puede consultar la tabla `Productos`, pero no puede actualizar o eliminar datos.

-- ============================================================
-- CREACIÓN DE BASE DE DATOS, TABLAS Y RELACIONES
-- ============================================================

-- 1. Crear la base de datos
CREATE DATABASE SistemaVentasAuditoria;
GO

-- 2. Usar la base de datos recién creada
USE SistemaVentasAuditoria;
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
