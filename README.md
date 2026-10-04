# RetailPro — Análisis de Datos

Proyecto del curso de **Data Analytics**: análisis de ventas de una empresa ficticia con SQL Server y Power BI.

**Autora:** Sabrina Fralasco
**Empresa:** RetailPro (empresa ficticia de distribución de tecnología)

## Descripción

**RetailPro** es una empresa ficticia dedicada a la distribución de tecnología. La pregunta de negocio que guía el proyecto es una **caída del 15% en las ventas trimestrales**: se quiere identificar en qué **productos, clientes y categorías** se concentra.

El proyecto combina consultas SQL sobre una base de ventas de ejemplo y un pipeline ETL desarrollado en Power BI.

## Objetivo

Analizar la caída del 15% en las ventas trimestrales de RetailPro, identificando los productos, clientes y categorías que más pesan en el comportamiento de las ventas.

## Alcance y limitaciones

- La base `Ventas_Tech_DB` es una **muestra mínima**: 10 ventas, 5 clientes y 6 productos, todas entre el 5 y el 15 de marzo de 2024.
- Con un único período **no es posible medir la caída del 15%**: no hay un trimestre anterior con el cual comparar. Las consultas están escritas para funcionar cuando se carguen ventas de más meses.
- El pipeline ETL de Power BI trabaja con un dataset de Excel (clientes, productos, ventas, categorías y territorios) y es independiente de la base SQL.

## Herramientas utilizadas

* **SQL Server:** creación de la base de datos y ejecución de consultas.
* **SQL Server Management Studio (SSMS):** ejecución de los scripts SQL.
* **Power BI Desktop (Power Query):** desarrollo del pipeline ETL.
* **Excel:** fuente de datos del pipeline ETL.
* **GitHub:** almacenamiento y organización de los archivos del proyecto.

## Requisitos

* SQL Server 2016 o superior (los scripts usan `DROP TABLE IF EXISTS`).
* SQL Server Management Studio (SSMS).
* Power BI Desktop, solo para abrir el archivo `.pbix`.

## Base de datos

Base: `Ventas_Tech_DB`, con cuatro tablas:

* `categorias`
* `clientes`
* `productos`
* `ventas` (tabla de hechos)

## Estructura del repositorio

```text
SabrinaFralasco-data-analytics/
├── sql-checkpoint/
│   ├── ventas_tech_db.sql
│   └── m4_consultas_negocio.sql
├── sql-ckeckpoint/                      (carpeta de una entrega anterior)
├── Pepiline_ETL_SabrinaFralasco.pbix
└── README.md
```

### Scripts SQL

#### `sql-checkpoint/ventas_tech_db.sql`

* Crea la base de datos `Ventas_Tech_DB` si no existe.
* Crea las cuatro tablas y carga los datos de ejemplo.
* Es **repetible**: borra y recrea las tablas, por lo que se puede ejecutar más de una vez.

#### `sql-checkpoint/m4_consultas_negocio.sql`

Cuatro consultas de negocio sobre la tabla `ventas`:

1. Resumen mensual (total facturado, pedidos y ticket promedio)
2. Top 5 de productos por facturación
3. Clientes recurrentes
4. Meses por encima o por debajo del promedio

### Power BI

#### `Pepiline_ETL_SabrinaFralasco.pbix`

Archivo de Power BI Desktop con el pipeline ETL desarrollado en Power Query.

## Cómo ejecutar los scripts SQL

1. Abrir **SSMS** y conectarse a la instancia de SQL Server.
2. Abrir `sql-checkpoint/ventas_tech_db.sql` y ejecutarlo **completo** (F5). Crea la base y carga los datos. Al final devuelve cuatro tablas de validación.
3. Abrir una **nueva ventana de consulta** y ejecutar primero:

   ```sql
   USE Ventas_Tech_DB;
   GO
   ```

   Si se omite este paso, SSMS puede ejecutar las consultas en otra base y devolver errores como `Invalid column name`.
4. Abrir `sql-checkpoint/m4_consultas_negocio.sql` y ejecutar cada consulta por separado (seleccionarla y presionar F5).

**Resultado esperado de control:** la Consulta 1 devuelve un único mes (marzo) con **10 pedidos** y un total facturado de **$6.444**.

## Próximos pasos

* Cargar ventas de más meses para poder comparar períodos y medir la caída trimestral.
* Encapsular el JOIN de las cuatro tablas en una vista (`vw_ventas_detalle`) para usarla como fuente en Power BI.
* Construir el dashboard y las medidas DAX sobre el modelo, tomando como base las consultas de negocio.
* Corregir los nombres de carpetas y archivos del repositorio (`sql-ckeckpoint`, `Pepiline_ETL...`) para que sigan la convención pedida.
