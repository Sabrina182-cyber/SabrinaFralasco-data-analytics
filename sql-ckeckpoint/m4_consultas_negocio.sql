-- ============================================================
-- M4 - Pre-entrega: Consultas SQL de negocio
-- Base de datos: Ventas_Tech_DB
-- Trabajamos únicamente sobre la tabla `ventas`
-- Columnas usadas: id_cliente, id_producto, cantidad, precio_unitario, fecha_venta
-- ============================================================

USE Ventas_Tech_DB;
GO


-- ------------------------------------------------------------
-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes
-- ------------------------------------------------------------
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    ROUND(SUM(cantidad * precio_unitario) * 1.0 / COUNT(*), 2) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- ------------------------------------------------------------
-- Consulta 2: Ranking de productos
-- Top 5 de id_producto por total facturado
-- ------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- ------------------------------------------------------------
-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido, con cantidad de pedidos y total gastado
-- ------------------------------------------------------------
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- ------------------------------------------------------------
-- Consulta 4: Meses por encima/por debajo del promedio
-- Total facturado por mes, comparado contra el promedio mensual general
-- ------------------------------------------------------------
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mes)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS totales_por_mes
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- ============================================================
-- Hallazgos
-- ============================================================
-- 1. El producto 1 (Laptop Pro 15) concentra $3600 de los $6444 totales
--    facturados, es decir, cerca del 56% de toda la facturación con
--    solo 3 unidades vendidas: es el producto que más pesa en ingresos,
--    no el que más rota.
-- 2. El producto 2 (Mouse Inalámbrico) es el que más unidades vendió
--    (13), pero genera apenas $364, el monto más bajo del top 5: alto
--    volumen no significa alto impacto en facturación.
-- 3. Los 5 clientes de la base hicieron exactamente 2 pedidos cada uno,
--    por lo que el 100% resulta "recurrente" bajo el criterio de más
--    de un pedido. El cliente 1 (María López) es el que más gastó
--    ($2640), impulsado por la compra de la Laptop Pro 15.
--
-- Nota: Consulta 1 y Consulta 4 no se pueden comparar entre meses
-- porque las 10 ventas cargadas en M3 caen todas en marzo 2024. Las
-- consultas están escritas para funcionar correctamente si se cargan
-- ventas de otros meses.
