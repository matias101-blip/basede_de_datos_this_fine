/* Revizar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "Pedidos_Clientes" (
	"id_pedido" INTEGER NOT NULL UNIQUE,
	"id_cliente" INTEGER,
	"fecha_pedido" TEXT,
	"feche_recibo" TEXT,
	"estado_pedido" TEXT,
	PRIMARY KEY("id_pedido"),
	FOREIGN KEY ("id_cliente") REFERENCES "Clientes"("id_cliente")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS "Pedidos_Clientes_index_0"
ON "Pedidos_Clientes" ();
CREATE TABLE IF NOT EXISTS "Registro_provedor" (
	"id_registro" INTEGER,
	"codigo_Provedor" TEXT UNIQUE,
	"tiempo_entrega" TEXT,
	"calificaciones_h" TEXT,
	PRIMARY KEY("id_registro"),
	FOREIGN KEY ("codigo_Provedor") REFERENCES "Provedor"("codigo_Provedor")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Provedor" (
	"codigo_Provedor" TEXT NOT NULL UNIQUE,
	"nombre" TEXT NOT NULL,
	"telefono" TEXT NOT NULL,
	"email" TEXT NOT NULL,
	PRIMARY KEY("codigo_Provedor")
);

CREATE TABLE IF NOT EXISTS "Catalogo_de_materiale" (
	"id_catalogo" INTEGER NOT NULL,
	"codigo_material" TEXT UNIQUE,
	PRIMARY KEY("id_catalogo"),
	FOREIGN KEY ("codigo_material") REFERENCES "Material"("codigo_material")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS "Catalogo_de_materiale_index_0"
ON "Catalogo_de_materiale" ("id_catalogo");
CREATE TABLE IF NOT EXISTS "Ordene_de_compra" (
	"id_orden_compra" INTEGER NOT NULL UNIQUE,
	"id_lista" INTEGER,
	"id_catalogo" INTEGER NOT NULL,
	"precios" REAL NOT NULL,
	"termino_entrega" TEXT NOT NULL,
	"fecha_compra" TEXT NOT NULL,
	"codigo_provedor" TEXT NOT NULL,
	PRIMARY KEY("id_orden_compra"),
	FOREIGN KEY ("id_catalogo") REFERENCES "Catalogo_de_materiale"("id_catalogo")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("codigo_provedor") REFERENCES "Provedor"("codigo_Provedor")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_lista") REFERENCES "Lista_materiales"("id_lista")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Recepcion_de_material" (
	"id_recepcion" INTEGER NOT NULL UNIQUE,
	"calidad" TEXT,
	"id_inventario" INTEGER,
	"id_especificacion" INTEGER,
	PRIMARY KEY("id_recepcion"),
	FOREIGN KEY ("id_inventario") REFERENCES "MV_INVENTARIO"("Id_inventario")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_especificacion") REFERENCES "Especificacion_Calidad"("id_espesificacion")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Material" (
	"codigo_material" TEXT NOT NULL UNIQUE,
	"nombre" TEXT,
	"valor_unidad" REAL,
	"descripcion" TEXT,
	"id_recepcion" INTEGER,
	PRIMARY KEY("codigo_material"),
	FOREIGN KEY ("id_recepcion") REFERENCES "Recepcion_de_material"("id_recepcion")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "ALMACEN" (
	"id_ubicacion" INTEGER,
	"id_almacen" INTEGER NOT NULL UNIQUE,
	"id_inventario" INTEGER,
	"id_valoracion" INTEGER,
	PRIMARY KEY("id_almacen"),
	FOREIGN KEY ("id_inventario") REFERENCES "MV_INVENTARIO"("Id_inventario")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_ubicacion") REFERENCES "UBICACION"("id_ubicacion")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* revisar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "STOCK_MATERIAL" (
	"id_stock" INTEGER,
	"C_reserva" TEXT,
	"C_disponible" TEXT,
	"En_circulacion" INTEGER,
	"Id_almacen" INTEGER,
	"codigo_material" TEXT,
	PRIMARY KEY("id_stock"),
	FOREIGN KEY ("Id_almacen") REFERENCES "ALMACEN"("id_almacen")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("codigo_material") REFERENCES "Material"("codigo_material")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "PRODUCTO_TERMINADO" (
	"Id_producto" INTEGER NOT NULL UNIQUE,
	"Name_producto" TEXT,
	"Description" TEXT,
	"C_terminada" INTEGER,
	"Fecha_elaboracion" TEXT,
	"id_inspeccion" INTEGER,
	PRIMARY KEY("Id_producto"),
	FOREIGN KEY ("Id_producto") REFERENCES "Rutas_Fabricacion"("id_producto")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "INVP_TERMINADO" (
	"Id_inv_terminado" INTEGER NOT NULL UNIQUE,
	"id_producto" INTEGER,
	"Id_almacen" INTEGER,
	"Cantidad" INTEGER,
	"id_inventario" INTEGER,
	PRIMARY KEY("Id_inv_terminado"),
	FOREIGN KEY ("id_inventario") REFERENCES "MV_INVENTARIO"("Id_inventario")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_producto") REFERENCES "PRODUCTO_TERMINADO"("Id_producto")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "MV_INVENTARIO" (
	"Id_inventario" INTEGER NOT NULL UNIQUE,
	"Fecha" TEXT,
	"Cantidad" INTEGER,
	PRIMARY KEY("Id_inventario")
);

/* Revisar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "Valoracion_inventario" (
	"Id_valoracion" INTEGER NOT NULL UNIQUE,
	"id_espesificacion" INTEGER,
	"Fecha_aplicada" TEXT,
	PRIMARY KEY("Id_valoracion"),
	FOREIGN KEY ("id_espesificacion") REFERENCES "Especificacion_Calidad"("id_espesificacion")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "ORDEN_FARBICACION" (
	"Id_orden" INTEGER NOT NULL UNIQUE,
	"Fecha_Terminacion" TEXT,
	"Prioridad_pedido" TEXT,
	"Fecha__Inicio" TEXT,
	PRIMARY KEY("Id_orden")
);

/* Revisar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "MATERIAL_USADO" (
	"id_orden" INTEGER,
	"Cantidad_Usada" INTEGER,
	"codigo_material" INTEGER,
	"id_trazabilidad" INTEGER,
	PRIMARY KEY("id_orden"),
	FOREIGN KEY ("id_trazabilidad") REFERENCES "Trazabilidad"("id_trazabilidad")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("codigo_material") REFERENCES "Material"("codigo_material")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_orden") REFERENCES "ORDEN_FARBICACION"("Id_orden")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "PROGRESO_FABRICACION" (
	"id_proceso" INTEGER,
	"estado_etapa" TEXT,
	"nombre_etapa" INTEGER,
	"id_control" INTEGER,
	"id_orden" INTEGER,
	PRIMARY KEY("id_proceso"),
	FOREIGN KEY ("id_orden") REFERENCES "ORDEN_FARBICACION"("Id_orden")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* revizar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "REGISTRO_TIEMPO" (
	"Id_registro_tiempo" INTEGER,
	"id_R_Tiempo" INTEGER,
	PRIMARY KEY("Id_registro_tiempo"),
	FOREIGN KEY ("id_R_Tiempo") REFERENCES "R_Tiempo"("id_R_Tiempo")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "REGISTRO_INCIDENCIA" (
	"Id_Incidencia" INTEGER,
	"id_tipo_incidencia" INTEGER,
	PRIMARY KEY("Id_Incidencia"),
	FOREIGN KEY ("id_tipo_incidencia") REFERENCES "Tipo_incidencia"("id_tipo_incedencia")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Orden_Produccion" (
	"id_Orden" INTEGER NOT NULL UNIQUE,
	"Fecha_inicial" TEXT NOT NULL,
	"estado" TEXT NOT NULL,
	-- FK
	"id_plan" INTEGER NOT NULL,
	"cantidad" INTEGER NOT NULL,
	PRIMARY KEY("id_Orden"),
	FOREIGN KEY ("id_Orden") REFERENCES "Progamacion_Recurso"("id_orden")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Plan_Maestro_Produccion" (
	"id_Plan" INTEGER NOT NULL UNIQUE,
	"id_ruta" INTEGER,
	"Fecha_Final" TEXT NOT NULL,
	"Cantidad_Pedida" INTEGER NOT NULL,
	"Fecha_Incio" TEXT NOT NULL,
	PRIMARY KEY("id_Plan"),
	FOREIGN KEY ("id_Plan") REFERENCES "Orden_Produccion"("id_plan")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS "Orden_Fabricación_index_0"
ON "Plan_Maestro_Produccion" ("id_Plan");

CREATE INDEX IF NOT EXISTS "Orden_Fabricación_index_1"
ON "Plan_Maestro_Produccion" ("id_ruta");

CREATE INDEX IF NOT EXISTS "Plan_Maestro_Producción_index_2"
ON "Plan_Maestro_Produccion" ("Fecha_Final");
CREATE TABLE IF NOT EXISTS "Lista_materiales" (
	"id_lista" INTEGER NOT NULL UNIQUE,
	-- FK
	"id_producto" INTEGER,
	-- FK Producto
	"id_componente" INTEGER,
	"cantidades" INTEGER NOT NULL,
	PRIMARY KEY("id_lista"),
	FOREIGN KEY ("id_componente") REFERENCES "Material"("codigo_material")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_producto") REFERENCES "PRODUCTO_TERMINADO"("Id_producto")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS "Lista_materiales_index_0"
ON "Lista_materiales" ("cantidades", "id_producto");
CREATE TABLE IF NOT EXISTS "Rutas_Fabricacion" (
	"id_ruta" INTEGER NOT NULL UNIQUE,
	"id_producto" INTEGER NOT NULL,
	"orden_fabricar" INTEGER NOT NULL,
	"estacion_trabajo" INTEGER,
	PRIMARY KEY("id_ruta"),
	FOREIGN KEY ("id_ruta") REFERENCES "Plan_Maestro_Produccion"("id_ruta")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("orden_fabricar") REFERENCES "ORDEN_FARBICACION"("Id_orden")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Progamacion_Recurso" (
	"id_asignar" INTEGER NOT NULL UNIQUE,
	"id_orden" INTEGER NOT NULL,
	-- FK personal
	"id_personal" INTEGER NOT NULL,
	"codigo_maquina" INTEGER NOT NULL,
	"codigo_herramienta" INTEGER NOT NULL,
	PRIMARY KEY("id_asignar"),
	FOREIGN KEY ("codigo_maquina") REFERENCES "Maquina"("codigo_maquina")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_personal") REFERENCES "Peronal"("id_personal")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("codigo_herramienta") REFERENCES "herramienta"("codigo_herrmaienta")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Peronal" (
	"id_personal" INTEGER NOT NULL UNIQUE,
	"nombre" TEXT,
	"cargo" TEXT,
	PRIMARY KEY("id_personal")
);

CREATE TABLE IF NOT EXISTS "Maquina" (
	"codigo_maquina" INTEGER NOT NULL UNIQUE,
	"modelo" TEXT NOT NULL,
	PRIMARY KEY("codigo_maquina")
);

CREATE TABLE IF NOT EXISTS "herramienta" (
	"codigo_herrmaienta" INTEGER NOT NULL UNIQUE,
	"describrir" TEXT,
	"tipo" TEXT,
	PRIMARY KEY("codigo_herrmaienta")
);

CREATE TABLE IF NOT EXISTS "Especificacion_Calidad" (
	"id_espesificacion" INTEGER NOT NULL UNIQUE,
	"parametros" TEXT,
	"descripccion_de_calidad" TEXT,
	PRIMARY KEY("id_espesificacion")
);

CREATE TABLE IF NOT EXISTS "Control_Proceso" (
	"id_control" INTEGER NOT NULL UNIQUE,
	"id_registro_tiempo" INTEGER,
	"id_incidencia" INTEGER,
	"Descripcion_etapa" TEXT,
	PRIMARY KEY("id_control"),
	FOREIGN KEY ("id_registro_tiempo") REFERENCES "REGISTRO_TIEMPO"("Id_registro_tiempo")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_incidencia") REFERENCES "REGISTRO_INCIDENCIA"("Id_Incidencia")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_control") REFERENCES "PROGRESO_FABRICACION"("id_control")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Inspeccion_final" (
	"id_inspeccion" INTEGER NOT NULL UNIQUE,
	"id_especificacion" INTEGER,
	"id_defectuoso" INTEGER,
	PRIMARY KEY("id_inspeccion"),
	FOREIGN KEY ("id_inspeccion") REFERENCES "PRODUCTO_TERMINADO"("id_inspeccion")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_especificacion") REFERENCES "Especificacion_Calidad"("id_espesificacion")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_defectuoso") REFERENCES "Producto_defectuosos"("id_defecto")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Producto_defectuosos" (
	"id_defecto" INTEGER NOT NULL UNIQUE,
	"descripcion_defecto" TEXT,
	"tratamiento" TEXT,
	PRIMARY KEY("id_defecto")
);

CREATE TABLE IF NOT EXISTS "Trazabilidad" (
	"id_trazabilidad" INTEGER NOT NULL UNIQUE,
	"id_defecto" INTEGER,
	PRIMARY KEY("id_trazabilidad"),
	FOREIGN KEY ("id_defecto") REFERENCES "Producto_defectuosos"("id_defecto")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Distribucion_producto" (
	"id_distribucion" INTEGER NOT NULL UNIQUE,
	"id_docment" INTEGER,
	"id_almacen" INTEGER,
	PRIMARY KEY("id_distribucion"),
	FOREIGN KEY ("id_almacen") REFERENCES "ALMACEN"("id_almacen")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_docment") REFERENCES "Docment_envio"("id_docment")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* revizar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "Docment_envio" (
	"id_docment" INTEGER NOT NULL UNIQUE,
	"id_envio" INTEGER,
	"id_cuerpo_doctument" INTEGER,
	PRIMARY KEY("id_docment"),
	FOREIGN KEY ("id_envio") REFERENCES "Planificacion_Envios"("id_envio")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_cuerpo_doctument") REFERENCES "Cuerpo_Document"("id_cuerpo_document")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Planificacion_Envios" (
	"id_envio" INTEGER NOT NULL UNIQUE,
	"id_pedido" INTEGER,
	"ruta" TEXT,
	"prioridad" TEXT,
	"fecha_envio" TEXT,
	PRIMARY KEY("id_envio"),
	FOREIGN KEY ("id_envio") REFERENCES "Pedidos_Clientes"("id_pedido")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* revizar si esta en 3ra forma normal */
CREATE TABLE IF NOT EXISTS "Seguimiento_Entregas" (
	"id_seguimiento" INTEGER NOT NULL UNIQUE,
	"id_envio" INTEGER,
	"id_descripcion_seguimiento" INTEGER,
	PRIMARY KEY("id_seguimiento"),
	FOREIGN KEY ("id_envio") REFERENCES "Planificacion_Envios"("id_envio")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("id_descripcion_seguimiento") REFERENCES "descripcion_seguimiento"("id_descripcion_segimiento")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Gestion_Envios" (
	"id_devolucion" INTEGER NOT NULL UNIQUE,
	"id_pedido" INTEGER,
	"motivo" TEXT,
	"cantidad" REAL,
	"fecha_ges_envio" TEXT,
	"estado_envio" TEXT,
	PRIMARY KEY("id_devolucion"),
	FOREIGN KEY ("id_pedido") REFERENCES "Pedidos_Clientes"("id_pedido")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Preparacion_Pedidos" (
	"id_preparación" INTEGER NOT NULL UNIQUE,
	"id_pedido" INTEGER,
	"fecha_preparacion" TEXT,
	"operador" TEXT,
	PRIMARY KEY("id_preparación"),
	FOREIGN KEY ("id_pedido") REFERENCES "Pedidos_Clientes"("id_pedido")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Clientes" (
	"id_cliente" INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("id_cliente")
);

CREATE TABLE IF NOT EXISTS "UBICACION" (
	"id_ubicacion" INTEGER NOT NULL UNIQUE,
	"locate" TEXT,
	PRIMARY KEY("id_ubicacion")
);

CREATE TABLE IF NOT EXISTS "R_Tiempo" (
	"id_R_Tiempo" INTEGER NOT NULL UNIQUE,
	"Tipo_Tiempo" INTEGER,
	"Hora" INTEGER,
	"Minuto" INTEGER,
	PRIMARY KEY("id_R_Tiempo")
);

CREATE TABLE IF NOT EXISTS "Tipo_incidencia" (
	"id_tipo_incedencia" INTEGER NOT NULL UNIQUE,
	"Tiempo" TEXT,
	"Descripcion" TEXT,
	PRIMARY KEY("id_tipo_incedencia")
);

CREATE TABLE IF NOT EXISTS "descripcion_seguimiento" (
	"id_descripcion_segimiento" INTEGER NOT NULL UNIQUE,
	"estado" INTEGER,
	"ubicacion" TEXT,
	"fecha" TEXT,
	PRIMARY KEY("id_descripcion_segimiento")
);

CREATE TABLE IF NOT EXISTS "Cuerpo_Document" (
	"id_cuerpo_document" INTEGER NOT NULL UNIQUE,
	"numero_document" INTEGER,
	"tipo_document" TEXT,
	"fecha_doct_envio" TEXT,
	PRIMARY KEY("id_cuerpo_document")
);
