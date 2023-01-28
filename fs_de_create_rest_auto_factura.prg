**
** Ejemplo de llamada a API de FacturaSend desde VisualFoxPro 9.0
** 
** Creacion de un documento electr�nico por el m�todo sincrono
**
** https://docs.facturasend.com.py/#creacion-de-un-de
**
** Autor: Marcos Jara
** Fecha: 2023-01-23
** 

SET PROCEDURE TO .\fsClass\de, .\fsClass\auto_factura, .\fsClass\auto_factura_ubicacion, .\fsClass\cliente, .\fsClass\complementarios, .\fsClass\complementarios_carga, .\fsClass\condicion, .\fsClass\condicion_credito, .\fsClass\condicion_credito_cuotas_info, .\fsClass\condicion_entrega, .\fsClass\condicion_entrega_cheque_info, .\fsClass\condicion_entrega_tarjeta_info, .\fsClass\documento_asociado, .\fsClass\extras, .\fsClass\factura, .\fsClass\factura_dncp, .\fsClass\item, .\fsClass\item_dncp, .\fsClass\nota_credito_debito, .\fsClass\remision, .\fsClass\sector_adicional, .\fsClass\sector_automotor, .\fsClass\sector_energia_electrica, .\fsClass\sector_seguros, .\fsClass\sector_supermercados, .\fsClass\transporte, .\fsClass\transporte_entrega, .\fsClass\transporte_salida, .\fsClass\transporte_transportista, .\fsClass\transporte_transportista_agente, .\fsClass\transporte_transportista_chofer, .\fsClass\transporte_vehiculo, .\fsClass\usuario, .\nfJson\nfJsonCreate, .\nfJson\nfJsonRead


data = CREATEOBJECT("de")
data.tipo_documento = 4

data.establecimiento = 1
data.punto = 1
data.numero = 740003

data.fecha = '2023-01-27T10:00:00'

data.tipo_impuesto = 1

**Cliente
data.cliente = CREATEOBJECT("cliente")
data.cliente.contribuyente = .t.
data.cliente.tipo_contribuyente = 2
data.cliente.tipo_operacion = 2
data.cliente.ruc = '80069563-1'
data.cliente.razon_social = 'TIPS S.A. - TECNOLOGIA Y SERVICIOS'
data.cliente.pais = 'PRY'
data.cliente.codigo = 'CLI001'
data.cliente.numero_casa = 0

** Usuario
data.usuario = CREATEOBJECT("usuario")
data.usuario.documento_tipo = 1
data.usuario.documento_numero = '2005001'
data.usuario.nombre = 'MARCOS JARA'
data.usuario.cargo = 'Vendedor'

** Auto Factura
data.auto_factura = CREATEOBJECT("auto_factura")
data.auto_factura.tipo_vendedor = 1
data.auto_factura.documento_tipo = 1
data.auto_factura.documento_numero = "3245675"
data.auto_factura.nombre = "MARCOS JARA"
data.auto_factura.direccion = "SAN JOSE DE LOS ARROYOS"
data.auto_factura.numero_casa = "25"
data.auto_factura.departamento = 11
data.auto_factura.distrito = 145
data.auto_factura.ciudad = 3420
data.auto_factura.ubicacion = CREATEOBJECT("auto_factura_ubicacion")
data.auto_factura.ubicacion.lugar = "Lugar de la transaccion"
data.auto_factura.ubicacion.departamento = 11
data.auto_factura.ubicacion.distrito = 145
data.auto_factura.ubicacion.ciudad = 3420

** Items
DIMENSION data.items(2)

data.items(1) = CREATEOBJECT("item")
data.items(1).codigo = 1050
data.items(1).descripcion = 'Pilsen Litro'
data.items(1).observacion = 'no beberla caliente'
data.items(1).unidad_medida = 77
data.items(1).cantidad = 2
data.items(1).precio_unitario = 7500
data.items(1).iva_tipo = 1
data.items(1).iva_base = 100
data.items(1).iva = 10

data.items(2) = CREATEOBJECT("item")
data.items(2).codigo = 1060
data.items(2).descripcion = 'Dorada Premium'
data.items(2).observacion = 'Tomarla bien helada'
data.items(2).unidad_medida = 77
data.items(2).cantidad = 3
data.items(2).precio_unitario = 9000
data.items(2).iva_tipo = 1
data.items(2).iva_base = 100
data.items(2).iva = 10

** Condicion
data.condicion = CREATEOBJECT("condicion")
data.condicion.tipo = 1
DIMENSION data.condicion.entregas(1)
data.condicion.entregas(1) = CREATEOBJECT("condicion_entrega")
data.condicion.entregas(1).tipo = 1
data.condicion.entregas(1).monto = 1450000
data.condicion.entregas(1).moneda = 'PYG'

** Complementarios
data.complementarios = CREATEOBJECT("complementarios")
data.complementarios.orden_compra = 1001
data.complementarios.orden_venta = 1002
data.complementarios.numero_asiento = 1212

** Documento Asociado
data.documento_asociado = CREATEOBJECT("documento_asociado")
data.documento_asociado.formato = 3
data.documento_asociado.constancia_tipo = 2
data.documento_asociado.constancia_numero = "42804571677"
data.documento_asociado.constancia_control = "8f9708d2"

cData = nfJsonCreate(data, .t., .f.)

SET ALTERNATE TO json.txt ADDITIVE
SET ALTERNATE ON
? cData 
SET ALTERNATE OFF

* Envio a FacturaSend

oHTTP = CREATEOBJECT('Msxml2.ServerXMLHTTP.6.0')
*oHTTP.OPEN("POST","https://api.facturasend.com.py/empresa0/de/create", .f.)
oHTTP.OPEN("POST","https://api.facturasend.com.py/testvfp/de/create", .f.)
oHTTP.setRequestHeader("User-Agent", "FacturaSend from VFP 9")
oHTTP.setRequestHeader("Content-Type", "application/json;charset=utf-8")
           
lcBasicAuth = "Bearer " + "api_key_FFD8E828-17C8-4DA8-A697-246322749005a"
oHTTP.setRequestHeader("Authorization", lcBasicAuth)
oHTTP.SEND(cData)

? "Status Response: " + STR(oHTTP.Status)
cRespuesta = oHTTP.ResponseText
? cRespuesta

* Convertir respuesta de la API en formato JSON-STRING a OBJETO VFP
vfpJsonObject = nfJsonRead(cRespuesta, .f.)
? vfpJsonObject.success

IF ( ! vfpJsonObject.success)
	? vfpJsonObject.error
ENDIF  


