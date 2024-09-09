--Solucion problema 4
ALTER TABLE Pedidos
ADD Total DECIMAL(10, 2) NULL;

CREATE PROCEDURE CalcularTotalPedido
    @PedidoID INT
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2);

    SELECT @Total = SUM(dp.Cantidad * p.Precio)
    FROM DetallesPedido dp
    JOIN Productos p ON dp.ProductoID = p.ProductoID
    WHERE dp.PedidoID = @PedidoID;

    UPDATE Pedidos
    SET Total = @Total
    WHERE PedidoID = @PedidoID;
END;
GO


--solucion problema 5
CREATE TRIGGER RegistrarCambioEstadoPedido
ON Pedidos
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Estado)
    BEGIN
        DECLARE @PedidoID INT, @EstadoAnterior NVARCHAR(20), @EstadoNuevo NVARCHAR(20);

        SELECT @PedidoID = PedidoID, @EstadoAnterior = d.Estado, @EstadoNuevo = i.Estado
        FROM inserted i
        JOIN deleted d ON i.PedidoID = d.PedidoID;

        INSERT INTO HistorialEstadoPedidos (PedidoID, EstadoAnterior, EstadoNuevo, FechaCambio)
        VALUES (@PedidoID, @EstadoAnterior, @EstadoNuevo, GETDATE());
    END;
END;
GO

--Solucion problema 6
CREATE PROCEDURE ProductosMasVendidos
AS
BEGIN
    SELECT p.NombreProducto, SUM(dp.Cantidad) AS TotalVendido
    FROM DetallesPedido dp
    JOIN Productos p ON dp.ProductoID = p.ProductoID
    GROUP BY p.NombreProducto
    ORDER BY TotalVendido DESC;
END;
GO

--solucion Problema 7
CREATE TRIGGER ActualizarStockDespuesDePedido
ON Pedidos
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Estado = 'Completado')
    BEGIN
        UPDATE p
        SET p.Stock = p.Stock - dp.Cantidad
        FROM Productos p
        JOIN DetallesPedido dp ON p.ProductoID = dp.ProductoID
        JOIN inserted i ON dp.PedidoID = i.PedidoID
        WHERE i.Estado = 'Completado';
    END;
END;
GO

--Solucion Problema 8

CREATE TRIGGER NotificarStockBajo
ON Productos
AFTER UPDATE
AS
BEGIN
    DECLARE @Umbral INT = 5;

    IF EXISTS (SELECT 1 FROM inserted WHERE Stock < @Umbral)
    BEGIN
        PRINT 'Advertencia: El stock de un producto está por debajo del umbral.';
    END;
END;
GO
