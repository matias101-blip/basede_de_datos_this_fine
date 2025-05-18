CREATE TABLE `PROVEEDOR` (
  `ProveedorID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255),
  `DatosFiscales` varchar(255),
  `TerminosComerciales` varchar(255),
  `SLA` varchar(255)
);

CREATE TABLE `CONTANCTO_PROVEEDOR` (
  `ContactoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ProveedorID` int,
  `NombreContacto` varchar(255),
  `Telefono` int,
  `Emil` varchar(255)
);

CREATE TABLE `Vendedores` (
  `id_vendedor` int PRIMARY KEY,
  `ContactoID` int,
  `vendedor_name` text,
  `zona` text,
  `email_vendedor` varchar(255)
);

CREATE TABLE `PRODUCTO` (
  `ProductoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `NombreProducto` varchar(255),
  `Precio` int,
  `Dimenciones` int,
  `Peso` int,
  `CondicionAlmacenamiento` varchar(255),
  `CodigoBarras` int,
  `id_lote` int,
  `PromocioID` int
);

CREATE TABLE `Clasificacion_comercial` (
  `id_producto` int,
  `id_clasificacion` int PRIMARY KEY,
  `descripcion` varchar(255)
);

CREATE TABLE `CATEGORIA` (
  `CategoriaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `NombreCategoria` varchar(255),
  `CategoriaPadreID` int,
  `id_rentabilidad` int
);

CREATE TABLE `PRODUCTO_CATEGORIA` (
  `ProductoID` int,
  `CategoriaID` int
);

CREATE TABLE `CONTRATO` (
  `ContratoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ProveedorID` int,
  `DescuentoVolumen` int,
  `Bonificaciones` int,
  `Rappel` int,
  `PromocionesEspeciales` int
);

CREATE TABLE `ORDEN_COMPRA` (
  `OrdenID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ProveedorID` int,
  `FechaOrden` date,
  `CondicionesEntrega` varchar(255)
);

CREATE TABLE `DETALLE_ORDEN_COMPRA` (
  `Dtalle_Orden_Compra` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `OrdenID` int UNIQUE NOT NULL AUTO_INCREMENT,
  `ProductoID` int,
  `Cantidad` int,
  `PrecioUnitario` int
);

CREATE TABLE `RUTA` (
  `RutaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Zona` varchar(255),
  `RestriccionesHorario` time,
  `RestriccionesAcceso` varchar(255)
);

CREATE TABLE `PEDIDO` (
  `PedidoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `FechaPedido` date,
  `EstadoPreparacion` varchar(255),
  `Ruta_ID` int,
  `VehiculoID` int,
  `EntregaID` int
);

CREATE TABLE `PREPARACION_PEDIDO` (
  `PreparacionID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PedidoID` int,
  `PickingRealizado` boolean,
  `PackingRealizado` boolean,
  `Verificado` boolean,
  `FechaPreparacion` date
);

CREATE TABLE `VEHICULO` (
  `VehiculoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Capacidad` varchar(255),
  `TipoVehiculo` varchar(255),
  `Placa` int
);

CREATE TABLE `CARGA_VEHICULO` (
  `CargaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `VehiculoID` int,
  `PedidoID` int,
  `RutaID` int,
  `FechaCarga` date
);

CREATE TABLE `HOJA_RUTA` (
  `HojaRutaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `VehiculoID` int,
  `Fecha` date,
  `ObservacionesGenerales` varchar(255)
);

CREATE TABLE `Territorios` (
  `id_sucursal` int PRIMARY KEY,
  `HojaRutaID` int,
  `nombre_territorio` text,
  `region` text
);

CREATE TABLE `DETALLE_HOJA_RUTA` (
  `Detalle_HojaRutaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `SecuenciaEntrega` varchar(255),
  `RequisitosEspeciales` varchar(255),
  `HojaRutaID` int
);

CREATE TABLE `ENTREGA` (
  `EntregaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `FechaHoraEntrega` datetime,
  `EstadoEntrega` varchar(255),
  `Observaciones` varchar(255),
  `HojaRutaID` int
);

CREATE TABLE `Direcciones` (
  `id_direccion` int PRIMARY KEY,
  `EntregaID` int,
  `descripcion` varchar(255),
  `codigopostal` varchar(255),
  `direccion` varchar(255),
  `ciudad` char,
  `estado` char
);

CREATE TABLE `INCIDENCIA_ENTREGA` (
  `IncidenciaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `EntregaID` int,
  `TipoIncidencia` varchar(255),
  `Descripcion` varchar(255),
  `Resuelto` boolean
);

CREATE TABLE `CLIENTE` (
  `ClienteID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `NombreCliente` varchar(255),
  `DireccionCliente` varchar(255),
  `TelefonoCliente` int,
  `EmailCliente` varchar(255),
  `CanalVenta` varchar(255),
  `id_residencia` int
);

CREATE TABLE `Residencia` (
  `id_residencia` int PRIMARY KEY,
  `Pais` varchar(255),
  `codigo_postal` varchar(255)
);

CREATE TABLE `Segmento` (
  `id_compra` int PRIMARY KEY,
  `id_cliente` int,
  `canal` varchar(255),
  `tipo_negocio` varchar(255)
);

CREATE TABLE `PEDIDO_CLIENTE` (
  `PedidoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ClienteID` int,
  `FechaPedido` date,
  `CanalOrigen` int,
  `EstadoAprobacion` varchar(255),
  `CondicionesComerciales` varchar(255),
  `EstadoReserva` varchar(255)
);

CREATE TABLE `DETALLE_PEDIDO` (
  `DetallePedidoID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PedidoID` int,
  `ProductoID` int,
  `Cantidad` int,
  `PrecioUnitario` int,
  `DescuentoAplicado` varchar(255)
);

CREATE TABLE `APROBACION_PEDIDO` (
  `AprobacionID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PedidoID` int,
  `VarificacionStock` boolean,
  `VerificacionPecio` boolean,
  `VerificacionCredito` boolean,
  `UsuarioAprobador` varchar(255),
  `FechaAprobacion` date
);

CREATE TABLE `Condiciones` (
  `ClienteID` int,
  `id_listado` int,
  `descuento` decimal,
  `plazo_pago` datetime,
  `limite_credito` decimal
);

CREATE TABLE `Lista_precios` (
  `id_listado` int PRIMARY KEY,
  `PromocionID` int,
  `descripcion` text,
  `fecha_emision` date
);

CREATE TABLE `PROMOCION` (
  `PromocionID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255),
  `Tipo` varchar(255),
  `Descripcion` varchar(255),
  `FechaInicio` date,
  `FechaFin` date
);

CREATE TABLE `PRODUCTO_PROMOCION` (
  `PromocionID` int UNIQUE NOT NULL AUTO_INCREMENT,
  `ProductoID` int,
  `PorcentajeDescuento` varchar(255),
  `CantidadMinima` int
);

CREATE TABLE `FACTURA_pedido` (
  `FacturaID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PedidoID` int,
  `FechaFactura` date,
  `Total` int,
  `TipoDocumento` varchar(255),
  `DocumentoFiscal` varchar(255)
);

CREATE TABLE `DEVOLUCION_CLIENTE` (
  `DevolucionID` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PedidoID` int,
  `ProductoID` int,
  `Cantidad` int,
  `Motivo` varchar(255),
  `FechaDevolucion` date
);

CREATE TABLE `Centro_Distribucion` (
  `ID_CentroDistribucion` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255),
  `Direccion` varchar(255)
);

CREATE TABLE `Asignacion_territorio` (
  `ID_Zona` int,
  `id_sucursal` int,
  `id_vendedor` int
);

CREATE TABLE `Zona` (
  `ID_Zona` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_CentroDistribucion` integer,
  `Nombre` integer
);

CREATE TABLE `Pasillo` (
  `ID_Pasillo` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_Zona` integer,
  `Nivel` int
);

CREATE TABLE `Ubicacion` (
  `ID_Ubicacion` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_Estanteria` integer,
  `CodigoUbicacion` integer,
  `Estado` integer
);

CREATE TABLE `Lote` (
  `ID_Lote` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `FechaFabricacion` integer,
  `FechaCaducidad` integer,
  `NumeroLote` integer
);

CREATE TABLE `Inventario` (
  `ID_Inventario` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_Lote` integer,
  `ID_Ubicacion` integer,
  `CantidadDisponible` integer,
  `CantidadReservada` integer,
  `CantidadEnTransito` integer
);

CREATE TABLE `Recepcion` (
  `ID_Recepcion` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `FechaRecepcion` integer,
  `ID_Proveedor` integer
);

CREATE TABLE `DetalleRecepcion` (
  `ID_Detalle` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_Recepcion` integer,
  `ID_Lote` integer,
  `Cantidad` integer
);

CREATE TABLE `DevolucionProveedor` (
  `ID_DevolucionP` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Fecha` integer,
  `Motivo` varchar(255),
  `ProvedorID` int
);

CREATE TABLE `DetalleDevolucion` (
  `ID_DetalleDev` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Cantidad` integer
);

CREATE TABLE `Devolucion` (
  `id_Devolucion` int PRIMARY KEY,
  `id_DevolucionP` int,
  `ID_DetallerDev` int
);

CREATE TABLE `estanteria` (
  `ID_Estanteria` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ID_Pasillo` int,
  `Capacidad` integer
);

CREATE TABLE `POLITICA_INVENTARIO` (
  `id_politica_inv` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `MetodoReposicion` integer,
  `TipoRotacion` integer,
  `FrecuenciaRevisionDias` integer,
  `TiempoReposicionDias` integer,
  `ID_Inventario` int
);

CREATE TABLE `Condicion_Pago` (
  `TipoPago` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PlazoDias` integer NOT NULL,
  `ClienteID` int
);

CREATE TABLE `RegistroPago` (
  `fechaPago` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `MontoPagado` numeric,
  `TipoPago` varchar(255),
  `id_pago` int
);

CREATE TABLE `Pago` (
  `id_pago` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `fecha` integer,
  `Monto` numeric,
  `TipoPago` varchar(255),
  `NumReferencia` integer
);

CREATE TABLE `Detalle_Pago` (
  `id_DetallePago` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_pago` integer,
  `Monto` integer
);

CREATE TABLE `Control_Pago` (
  `id_control_pago` int PRIMARY KEY,
  `FechaEmision` integer UNIQUE NOT NULL AUTO_INCREMENT,
  `Estado` varchar(255),
  `HistorialPago` varchar(255),
  `FechaVencimiento` varchar(255),
  `id_factura_pago` int
);

CREATE TABLE `Factura_pago` (
  `id_Factura_pago` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_pago` int,
  `fechaemision` integer,
  `Monto` integer,
  `estado` bool,
  `id_analisi_venta` int
);

CREATE TABLE `Gestion_Cobranza` (
  `id_gestion` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `fecha` integer,
  `Observacion` varchar(255),
  `Resultado` varchar(255),
  `id_control_pago` int,
  `id_vendedor` int
);

CREATE TABLE `Comision_Vendedor` (
  `id_porcentaje` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `unidad` integer,
  `Monto` integer,
  `id_vendedor` int
);

CREATE TABLE `Analisis_venta` (
  `id_analisis_venta` int PRIMARY KEY,
  `id_descripcion` varchar(255)
);

CREATE TABLE `Rentabilidad` (
  `id_rentabilidad` int PRIMARY KEY,
  `id_producto` int,
  `rentable` bool
);

ALTER TABLE `ORDEN_COMPRA` ADD FOREIGN KEY (`ProveedorID`) REFERENCES `PROVEEDOR` (`ProveedorID`);

ALTER TABLE `DETALLE_ORDEN_COMPRA` ADD FOREIGN KEY (`OrdenID`) REFERENCES `ORDEN_COMPRA` (`OrdenID`);

ALTER TABLE `Vendedores` ADD FOREIGN KEY (`ContactoID`) REFERENCES `CONTANCTO_PROVEEDOR` (`ProveedorID`);

ALTER TABLE `Clasificacion_comercial` ADD FOREIGN KEY (`id_producto`) REFERENCES `PRODUCTO` (`ProductoID`);

ALTER TABLE `PRODUCTO_CATEGORIA` ADD FOREIGN KEY (`ProductoID`) REFERENCES `PRODUCTO` (`ProductoID`);

ALTER TABLE `PRODUCTO_CATEGORIA` ADD FOREIGN KEY (`CategoriaID`) REFERENCES `CATEGORIA` (`CategoriaID`);

ALTER TABLE `CONTRATO` ADD FOREIGN KEY (`ProveedorID`) REFERENCES `PROVEEDOR` (`ProveedorID`);

ALTER TABLE `PRODUCTO` ADD FOREIGN KEY (`ProductoID`) REFERENCES `DETALLE_ORDEN_COMPRA` (`ProductoID`);

ALTER TABLE `Territorios` ADD FOREIGN KEY (`HojaRutaID`) REFERENCES `HOJA_RUTA` (`HojaRutaID`);

ALTER TABLE `Direcciones` ADD FOREIGN KEY (`EntregaID`) REFERENCES `ENTREGA` (`EntregaID`);

ALTER TABLE `Segmento` ADD FOREIGN KEY (`id_cliente`) REFERENCES `CLIENTE` (`ClienteID`);

ALTER TABLE `Condiciones` ADD FOREIGN KEY (`ClienteID`) REFERENCES `CLIENTE` (`ClienteID`);

ALTER TABLE `Condiciones` ADD FOREIGN KEY (`id_listado`) REFERENCES `Lista_precios` (`id_listado`);

ALTER TABLE `Lista_precios` ADD FOREIGN KEY (`PromocionID`) REFERENCES `PROMOCION` (`PromocionID`);

ALTER TABLE `CONTANCTO_PROVEEDOR` ADD FOREIGN KEY (`ProveedorID`) REFERENCES `PROVEEDOR` (`ProveedorID`);

ALTER TABLE `Asignacion_territorio` ADD FOREIGN KEY (`ID_Zona`) REFERENCES `Zona` (`ID_Zona`);

ALTER TABLE `Asignacion_territorio` ADD FOREIGN KEY (`id_sucursal`) REFERENCES `Territorios` (`id_sucursal`);

ALTER TABLE `Asignacion_territorio` ADD FOREIGN KEY (`id_vendedor`) REFERENCES `Vendedores` (`id_vendedor`);

ALTER TABLE `DevolucionProveedor` ADD FOREIGN KEY (`ProvedorID`) REFERENCES `PROVEEDOR` (`ProveedorID`);

ALTER TABLE `Zona` ADD FOREIGN KEY (`ID_CentroDistribucion`) REFERENCES `Centro_Distribucion` (`ID_CentroDistribucion`);

ALTER TABLE `Pasillo` ADD FOREIGN KEY (`ID_Zona`) REFERENCES `Zona` (`ID_Zona`);

ALTER TABLE `estanteria` ADD FOREIGN KEY (`ID_Pasillo`) REFERENCES `Pasillo` (`ID_Pasillo`);

ALTER TABLE `Ubicacion` ADD FOREIGN KEY (`ID_Estanteria`) REFERENCES `estanteria` (`ID_Estanteria`);

ALTER TABLE `Inventario` ADD FOREIGN KEY (`ID_Ubicacion`) REFERENCES `Ubicacion` (`ID_Ubicacion`);

ALTER TABLE `Inventario` ADD FOREIGN KEY (`ID_Lote`) REFERENCES `Lote` (`ID_Lote`);

ALTER TABLE `PRODUCTO` ADD FOREIGN KEY (`id_lote`) REFERENCES `Lote` (`ID_Lote`);

ALTER TABLE `Recepcion` ADD FOREIGN KEY (`ID_Proveedor`) REFERENCES `PROVEEDOR` (`ProveedorID`);

ALTER TABLE `DetalleRecepcion` ADD FOREIGN KEY (`ID_Recepcion`) REFERENCES `Recepcion` (`ID_Recepcion`);

ALTER TABLE `Devolucion` ADD FOREIGN KEY (`ID_DetallerDev`) REFERENCES `DetalleDevolucion` (`ID_DetalleDev`);

ALTER TABLE `Devolucion` ADD FOREIGN KEY (`id_DevolucionP`) REFERENCES `DevolucionProveedor` (`ID_DevolucionP`);

ALTER TABLE `POLITICA_INVENTARIO` ADD FOREIGN KEY (`ID_Inventario`) REFERENCES `Inventario` (`ID_Inventario`);

ALTER TABLE `PEDIDO_CLIENTE` ADD FOREIGN KEY (`ClienteID`) REFERENCES `CLIENTE` (`ClienteID`);

ALTER TABLE `DETALLE_PEDIDO` ADD FOREIGN KEY (`PedidoID`) REFERENCES `PEDIDO_CLIENTE` (`PedidoID`);

ALTER TABLE `APROBACION_PEDIDO` ADD FOREIGN KEY (`PedidoID`) REFERENCES `PEDIDO_CLIENTE` (`PedidoID`);

ALTER TABLE `PRODUCTO_PROMOCION` ADD FOREIGN KEY (`PromocionID`) REFERENCES `PROMOCION` (`PromocionID`);

ALTER TABLE `PRODUCTO_PROMOCION` ADD FOREIGN KEY (`ProductoID`) REFERENCES `PRODUCTO` (`ProductoID`);

ALTER TABLE `FACTURA_pedido` ADD FOREIGN KEY (`PedidoID`) REFERENCES `PEDIDO_CLIENTE` (`PedidoID`);

ALTER TABLE `DEVOLUCION_CLIENTE` ADD FOREIGN KEY (`PedidoID`) REFERENCES `PEDIDO_CLIENTE` (`PedidoID`);

ALTER TABLE `PREPARACION_PEDIDO` ADD FOREIGN KEY (`PedidoID`) REFERENCES `PEDIDO` (`PedidoID`);

ALTER TABLE `PEDIDO` ADD FOREIGN KEY (`VehiculoID`) REFERENCES `VEHICULO` (`VehiculoID`);

ALTER TABLE `CARGA_VEHICULO` ADD FOREIGN KEY (`RutaID`) REFERENCES `RUTA` (`RutaID`);

ALTER TABLE `ENTREGA` ADD FOREIGN KEY (`HojaRutaID`) REFERENCES `HOJA_RUTA` (`HojaRutaID`);

ALTER TABLE `PEDIDO` ADD FOREIGN KEY (`EntregaID`) REFERENCES `ENTREGA` (`EntregaID`);

ALTER TABLE `INCIDENCIA_ENTREGA` ADD FOREIGN KEY (`EntregaID`) REFERENCES `ENTREGA` (`EntregaID`);

ALTER TABLE `Condicion_Pago` ADD FOREIGN KEY (`ClienteID`) REFERENCES `CLIENTE` (`ClienteID`);

ALTER TABLE `Pago` ADD FOREIGN KEY (`TipoPago`) REFERENCES `Condicion_Pago` (`TipoPago`);

ALTER TABLE `Factura_pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `Pago` (`id_pago`);

ALTER TABLE `Control_Pago` ADD FOREIGN KEY (`id_factura_pago`) REFERENCES `Factura_pago` (`id_Factura_pago`);

ALTER TABLE `Gestion_Cobranza` ADD FOREIGN KEY (`id_control_pago`) REFERENCES `Control_Pago` (`id_control_pago`);

ALTER TABLE `Gestion_Cobranza` ADD FOREIGN KEY (`id_vendedor`) REFERENCES `Vendedores` (`id_vendedor`);

ALTER TABLE `Detalle_Pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `Pago` (`id_pago`);

ALTER TABLE `RegistroPago` ADD FOREIGN KEY (`id_pago`) REFERENCES `Pago` (`id_pago`);

ALTER TABLE `Comision_Vendedor` ADD FOREIGN KEY (`id_vendedor`) REFERENCES `Vendedores` (`id_vendedor`);

ALTER TABLE `Factura_pago` ADD FOREIGN KEY (`id_analisi_venta`) REFERENCES `Analisis_venta` (`id_analisis_venta`);

ALTER TABLE `CATEGORIA` ADD FOREIGN KEY (`id_rentabilidad`) REFERENCES `Rentabilidad` (`id_rentabilidad`);

ALTER TABLE `CLIENTE` ADD FOREIGN KEY (`id_residencia`) REFERENCES `Residencia` (`id_residencia`);

ALTER TABLE `DETALLE_HOJA_RUTA` ADD FOREIGN KEY (`HojaRutaID`) REFERENCES `HOJA_RUTA` (`HojaRutaID`);
