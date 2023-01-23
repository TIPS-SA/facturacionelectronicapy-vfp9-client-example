SET PROCEDURE TO Cliente, Usuario, Item

DEFINE CLASS de AS Custom
	tipo_documento = .null.
	establecimiento = 0
	punto = 0
	numero = 0
	serie = .null.
	descripcion = .null.
	observacion = .null.
	fecha = .null.
	tipo_emision = .NULL.
	tipo_transaccion = 0
	tipo_impuesto = 0
	moneda = 'PYG'
	condicion_anticipo = .NULL.
	condicion_tipo_cambio = .NULL.
	cambio = .NULL.
	cdc = .NULL.
	
	* Objetos
	cliente = .NULL.
	usuario = .NULL.
	factura = .NULL.
	auto_factura = .NULL.
	nota_credito_debito = .NULL.
	remision = .NULL.
	
	DIMENSION items(1)
	condicion = .NULL.
	
	
	descuento_global = .NULL.
	anticipo_global = .null.
	extras = .null.
	format = .null.
	
ENDDEFINE
