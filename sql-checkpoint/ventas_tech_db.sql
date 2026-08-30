-- ============================================
-- ventas_tech_db.sql
-- Checkpoint: Script SQL de Ingeniería de Datos
-- Proyecto Final - Data Analyst
-- Script repetible: se puede ejecutar múltiples veces sin error
-- Compatible con SQL Server (usar GO entre bloques)
-- ============================================

-- ============================================
-- 0. BASE DE DATOS
-- ============================================
IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END
GO

USE Ventas_Tech_DB;
GO

-- ============================================
-- 1. DEFINICIÓN DEL ESQUEMA (DDL)
-- ============================================

-- --- DROP TABLES (orden inverso de dependencias, para que el script sea repetible) ---
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
GO

-- --- Tabla de dimensión: categorias ---
CREATE TABLE categorias (
    id_categoria     INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion      VARCHAR(200)
);
GO

-- --- Tabla de dimensión: clientes ---
CREATE TABLE clientes (
    id_cliente      INT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE,
    ciudad          VARCHAR(50),
    fecha_registro  DATE NOT NULL
);
GO

-- --- Tabla de dimensión: productos ---
-- (id_categoria como FK evita repetir el texto de la categoría -> cumple 3NF)
-- Nota: "activo" se define como TINYINT (sin ancho) porque SQL Server no admite
-- TINYINT(1); cumple la misma función de bandera 0/1 que pide la consigna.
CREATE TABLE productos (
    id_producto      INT PRIMARY KEY,
    nombre_producto  VARCHAR(100) NOT NULL,
    id_categoria     INT,
    precio           DECIMAL(10,2) NOT NULL,
    stock            INT DEFAULT 0,
    activo           TINYINT DEFAULT 1,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
GO

-- --- Tabla de hechos: ventas ---
CREATE TABLE ventas (
    id_venta         INT PRIMARY KEY,
    id_cliente       INT,
    id_producto      INT,
    cantidad         INT NOT NULL,
    precio_unitario  DECIMAL(10,2) NOT NULL,
    fecha_venta      DATE NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

-- ============================================
-- 2. CARGA INICIAL DE DATOS (DML)
-- Orden lógico: dimensiones primero, hechos al final
-- ============================================

-- --- categorias (4 registros) ---
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES (4, 'Almacenamiento', 'Discos y memorias');
GO

-- --- clientes (5 registros) ---
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05');
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10');
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01');
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15');
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      '2024-03-01');
GO

-- --- productos (6 registros) ---
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);
GO

-- --- ventas (10 registros) ---
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES (10, 5, 3, 2,  450.00, '2024-03-15');
GO

-- ============================================
-- 3. VALIDACIÓN
-- ============================================
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
GO
