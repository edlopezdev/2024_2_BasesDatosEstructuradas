--Crear tabla clientes
CREATE TABLE tb_Clientes(
	ID_Cliente INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL
);
--Crear tabla Compras
CREATE TABLE tb_Compras (
	ID_Compra INT PRIMARY KEY IDENTITY(1,1),
	ID_Cliente INT NOT NULL,
	FechaCompra DATETIME NOT NULL,
	FOREIGN KEY (ID_Cliente) REFERENCES tb_Clientes(ID_Cliente)
);
--tabla producto
CREATE TABLE tb_Productos(
	ID_Producto INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Producto VARCHAR(100),
	Precio DECIMAL (10,2) NOT NULL,
	Stock INT NOT NULL
);
--Tabla detalle compra
CREATE TABLE tb_DetalleCompra(
	ID_Detalle INT PRIMARY KEY IDENTITY(1,1),
	ID_Compra INT NOT NULL,
	ID_Producto INT NOT NULL,
	Cantidad INT NOT NULL,
	FOREIGN KEY (ID_Compra) REFERENCES tb_Compras(ID_Compra),
	FOREIGN KEY (ID_Producto) REFERENCES tb_Productos(ID_Producto)
);

--Registrar una nueva compra-detalle para 1 cliente actualizar el stock y devolver el total a pagar
CREATE PROCEDURE SP_RegistrarVenta
--el sp recibe
--producto
--Cliente
--cantidad producto

@ID_Cliente INT,
@ID_Producto INT,
@Cantidad INT

AS 
BEGIN

	DECLARE @StockActual INT;
	DECLARE @IDCompraActual INT;
	DECLARE @Total DECIMAL(10,2);
	DECLARE @PrecioActual DECIMAL(10,2);

	SELECT @StockActual=Stock, @PrecioActual=Precio
	FROM tb_Productos
	WHERE ID_Producto=@ID_Producto;

	--Condicion

	IF @StockActual<@Cantidad
	BEGIN
		PRINT 'No hay stock';
		RETURN;
	END
	
	-- Si no se cumple la condicion (si hay stock)

	--Registrar la Compra
	INSERT INTO tb_Compras(ID_Cliente, FechaCompra)
	VALUES(@ID_Cliente,GETDATE());

	SET @IDCompraActual=SCOPE_IDENTITY();

	SET @Total =@Cantidad*@PrecioActual;

	--actualizar el stock
	UPDATE tb_Productos
	SET Stock =Stock-@Cantidad
	WHERE ID_Producto=@ID_Producto;

	-- Insertar detalle
	INSERT INTO tb_DetalleCompra(ID_Compra,ID_Producto,Cantidad, TotalAPagar)
	VALUES(@IDCompraActual,@ID_Producto,@Cantidad,@Total);

	PRINT 'El total a pagar es:'+CAST (@Total AS VARCHAR(20));
END