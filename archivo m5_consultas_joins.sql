--- AGREGADO DE DATOS ----
  INSERT INTO dbo.productos
  VALUES (7,'pendrive',2,14,5,1);
  SELECT * 
  FROM dbo.productos;

  INSERT INTO dbo.ventas
  VALUES (12,4,1,3,1200,'2024-02-05');


------ CONSULTA 1  (INNER JOIN) ----------------
SELECT 
v.id_cliente AS Cliente,
v.fecha_venta,
p.nombre_producto AS Producto,
t.descripcion,
v. cantidad AS UnidadesVendidas,
p.precio AS PrecioUnitario,
(p.precio * v.cantidad) AS MontoTotal
FROM DBO.VENTAS AS v 
 INNER JOIN dbo.clientes AS c
 ON v.id_cliente = c.id_cliente
 INNER JOIN dbo.productos AS p
 ON v.id_producto = p.id_producto
 INNER JOIN dbo.categorias AS t
 ON t.id_categoria = p.id_categoria
 ORDER BY MontoTotal DESC;


 ---- CONSULTA 2 CLIENTES SIN VENTAS (LEFT JOIN) ------
 SELECT
 c.id_cliente,
 c.nombre AS NombreCliente,
 c.email,
 c.ciudad,
 c.fecha_registro,
 v.id_venta AS ventaconcretada
 FROM dbo.clientes AS c
 LEFT JOIN dbo.Ventas AS v
 ON c.id_cliente = v.id_cliente
 WHERE v.id_venta IS NULL;      comentario: es correcto que no traiga registros, pues todos los clientes de la base clientes registraron ventas


 ------------ Productos sin Ventas (LEFT JOIN) ------------
 SELECT
 p.id_producto,
 p.nombre_producto AS Producto,
 p.id_categoria AS CategoriaProducto,
 p.precio
 FROM dbo.Productos AS p
 LEFT JOIN dbo.Ventas AS v
 ON p.id_producto = v.id_producto
 WHERE v.id_producto IS NULL;    comentario: el producto pendrive es el unico que no se vendió (ver que lo agregue a la tabla al principio porque no tenia en la tabla productos sin vender)


 ----- CONSULTA 4 CONSOLIDADO POR CANAL (UNION ALL)
 
 SELECT canal, SUM(total) AS Total_Canal
 FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS TOTAL, 'Febrero2024' AS canal
    FROM dbo.Ventas WHERE fecha_venta > '2024-01-31' AND fecha_venta <'2024-03-01' 
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS TOTAL, 'Marzo2024' AS canal
    FROM dbo.Ventas WHERE fecha_venta > '2024-02-28' AND fecha_venta <'2024-4-01' 
 ) AS Consolidado
 GROUP BY canal;

