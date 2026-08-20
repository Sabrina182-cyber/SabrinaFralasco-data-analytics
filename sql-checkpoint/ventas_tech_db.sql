-- ============================================
-- ventas_tech_db.sql
-- Checkpoint: Script SQL de Ingeniería de Datos
-- Proyecto Final - Data Analyst
-- Script repetible: se puede ejecutar múltiples veces sin error
-- ============================================

-- ============================================
-- 1. DEFINICIÓN DEL ESQUEMA (DDL)
-- ============================================

-- --- DROP TABLES (orden inverso de dependencias, para que el script sea repetible) ---
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- --- Tabla de dimensión: categorias ---
CREATE TABLE categorias (
    id      INT PRIMARY KEY,
    nombre  VARCHAR(50) NOT NULL
);

-- --- Tabla de dimensión: clientes ---
CREATE TABLE clientes (
    id      INT PRIMARY KEY,
    nombre  VARCHAR(100) NOT NULL,
    email   VARCHAR(100) UNIQUE,
    ciudad  VARCHAR(50)
);

-- --- Tabla de dimensión: productos ---
-- (categoria_id como FK evita repetir el texto de la categoría -> cumple 3NF)
CREATE TABLE productos (
    id            INT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    precio        DECIMAL(10,2) NOT NULL,
    categoria_id  INT,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- --- Tabla de hechos: ventas ---
CREATE TABLE ventas (
    id_venta     INT PRIMARY KEY,
    fecha        DATE NOT NULL,
    cliente_id   INT,
    producto_id  INT,
    cantidad     INT NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- ============================================
-- 2. CARGA INICIAL DE DATOS (DML)
-- Orden lógico: dimensiones primero, hechos al final
-- ============================================

-- --- categorias (3 registros) ---
INSERT INTO categorias VALUES (1, 'Celulares');
INSERT INTO categorias VALUES (2, 'Accesorios de Celulares');
INSERT INTO categorias VALUES (3, 'Entretenimiento');

-- --- clientes (3 registros) ---
INSERT INTO clientes VALUES (1, 'Ana María González', 'anamaria.gonzalez@gmail.com', 'Buenos Aires');
INSERT INTO clientes VALUES (2, 'Sabrina Fernández',  'sabrina.fernandez@gmail.com', 'Córdoba');
INSERT INTO clientes VALUES (3, 'Diego Gutiérrez',    'diego.gutierrez@gmail.com',   'Rosario');

-- --- productos (12 registros, distribuidos en las 3 categorías) ---
-- Celulares
INSERT INTO productos VALUES (1,  'Samsung Galaxy S24',           1800000.00, 1);
INSERT INTO productos VALUES (2,  'Motorola Edge 50',             1200000.00, 1);
INSERT INTO productos VALUES (3,  'Xiaomi Redmi Note 13',         1000000.00, 1);
INSERT INTO productos VALUES (4,  'Apple iPhone 15',              3000000.00, 1);
-- Accesorios de Celulares
INSERT INTO productos VALUES (5,  'Cargador Rápido USB-C',          25000.00, 2);
INSERT INTO productos VALUES (6,  'Auriculares Bluetooth In-Ear',    35000.00, 2);
INSERT INTO productos VALUES (7,  'Funda Protectora',                25000.00, 2);
INSERT INTO productos VALUES (8,  'Cable Adaptador USB-C a HDMI',    30000.00, 2);
-- Entretenimiento
INSERT INTO productos VALUES (9,  'Smartwatch',                      30000.00, 3);
INSERT INTO productos VALUES (10, 'PlayStation 5 (PS5)',             90000.00, 3);
INSERT INTO productos VALUES (11, 'Xbox Series X',                   85000.00, 3);
INSERT INTO productos VALUES (12, 'Nintendo Switch',                 50000.00, 3);

-- --- ventas (15 transacciones) ---
INSERT INTO ventas VALUES (1,  '2026-03-05', 1, 1,  1);
INSERT INTO ventas VALUES (2,  '2026-03-06', 2, 5,  5);
INSERT INTO ventas VALUES (3,  '2026-03-07', 3, 2,  1);
INSERT INTO ventas VALUES (4,  '2026-03-08', 1, 6,  2);
INSERT INTO ventas VALUES (5,  '2026-03-10', 2, 8,  3);
INSERT INTO ventas VALUES (6,  '2026-03-11', 3, 9,  1);
INSERT INTO ventas VALUES (7,  '2026-03-12', 1, 10, 1);
INSERT INTO ventas VALUES (8,  '2026-03-13', 2, 5,  8);
INSERT INTO ventas VALUES (9,  '2026-03-14', 3, 7,  1);
INSERT INTO ventas VALUES (10, '2026-03-15', 1, 4,  2);
INSERT INTO ventas VALUES (11, '2026-03-16', 2, 11, 1);
INSERT INTO ventas VALUES (12, '2026-03-17', 3, 12, 2);
INSERT INTO ventas VALUES (13, '2026-03-18', 1, 3,  1);
INSERT INTO ventas VALUES (14, '2026-03-19', 2, 6,  3);
INSERT INTO ventas VALUES (15, '2026-03-20', 3, 1,  1);

-- ============================================
-- 3. VALIDACIÓN
-- ============================================
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
