-- Crear la base de datos
CREATE DATABASE ColegioDB;
GO

-- Seleccionar la base de datos
USE ColegioDB;
GO

-- Crear la tabla Estudiantes
CREATE TABLE Estudiantes (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Edad INT NOT NULL,
    FechaIngreso DATE NOT NULL
);
GO
-- Insertar datos en la tabla Estudiantes
INSERT INTO Estudiantes (Nombre, Edad, FechaIngreso)
VALUES
('Juan Pérez', 24, '2022-09-01'),
('María López', 21, '2021-08-15'),
('Carlos Sánchez', 28, '2020-07-10'),
('Ana Gómez', 26, '2023-01-05'),
('Luis Fernández', 31, '2019-06-20');
GO
