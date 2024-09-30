-- ============================================================
-- EJERCICIOS TIPO PRUEBA: ROLES, AUDITORÍA Y TRANSACCIONES
-- ============================================================

-- EJERCICIO 1: Creación de Roles y Permisos
-- 1. Crear un rol llamado 'rol_consulta' que solo tenga permisos de lectura (SELECT) sobre las tablas `Clientes` y `Ventas`.
-- 2. Crear un usuario 'UsuarioConsulta' y asignarle este rol.
-- 3. Probar que el usuario solo puede realizar consultas y no tiene permisos de inserción, actualización o eliminación.

-- EJERCICIO 2: Auditoría con Triggers
-- 1. Crear una tabla llamada 'AuditoriaVentas' que registre los cambios en la tabla `Ventas`.
-- 2. La tabla debe registrar el ID de la venta, el total anterior, el total nuevo, la fecha del cambio, y el usuario que realizó el cambio.
-- 3. Crear un trigger que registre cualquier cambio en el `TotalVenta` de la tabla `Ventas` y lo almacene en la tabla de auditoría.

-- EJERCICIO 3: Consultas Seguras con Transacciones y TRY...CATCH
-- 1. Implementar una transacción que actualice el stock de un producto en la tabla `Productos` y registre el cambio en una tabla de auditoría llamada `AuditoriaStock`.
-- 2. La tabla de auditoría debe registrar el ProductoID, el stock anterior, el stock nuevo, y la fecha de la transacción.
-- 3. Implementar el bloque `TRY...CATCH` para manejar cualquier error durante la transacción y, en caso de error, realizar un ROLLBACK.
-- 4. Probar la transacción con un producto específico y asegurarse de que si ocurre un error, los cambios se deshacen.

-- EJERCICIO 4: Manejo de Permisos dentro de una Transacción
-- 1. Crear un usuario llamado 'UsuarioLimitado' con permisos de solo lectura en la tabla `Productos`.
-- 2. Durante una transacción, revocar el permiso de actualización (UPDATE) para este usuario.
-- 3. Probar si el usuario puede realizar consultas sobre la tabla `Productos`, pero no puede realizar actualizaciones después de la revocación del permiso.

-- EJERCICIO 5: Auditoría de Eliminaciones
-- 1. Crear una tabla llamada `AuditoriaEliminacionesClientes` que registre todas las eliminaciones realizadas en la tabla `Clientes`.
-- 2. La tabla debe registrar el ClienteID, el nombre del cliente eliminado, la fecha de la eliminación, y el usuario que realizó la operación.
-- 3. Crear un trigger que registre cualquier eliminación en la tabla `Clientes` y lo almacene en la tabla de auditoría.
