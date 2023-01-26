SET PROCEDURE TO Cliente, Usuario, Item

DEFINE CLASS de AS Custom
	tipo_documento = .NULL.
	establecimiento = .NULL.
	punto = .NULL.
	numero = .NULL.
	serie = .NULL.
	descripcion = .NULL.
	observacion = .NULL.
	fecha = .NULL.
	tipo_emision = .NULL.
	tipo_transaccion = .NULL.
	tipo_impuesto = .NULL.
	moneda = .NULL.
	condicion_anticipo = .NULL.
	condicion_tipo_cambio = .NULL.
	cambio = .NULL.
	cdc = .NULL.
	descuento_global = .NULL.
	anticipo_global = .NULL.
	format = .NULL.
	
	* Objetos
	cliente = CREATEOBJECT("cliente")
	usuario = CREATEOBJECT("usuario")
	factura = .NULL.
	auto_factura = .NULL.
	nota_credito_debito = .NULL.
	remision = .NULL.
	condicion = .NULL.
	sector_energia_electrica = .NULL.
	sector_seguros = .NULL.
	sector_supermercados = .NULL.
	sector_adicional = .NULL.
	transporte = .NULL.
	complementarios = .NULL.
	extras = .NULL.
	
	DIMENSION items(1)
	
	
	
ENDDEFINE
