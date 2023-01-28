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
data.tipo_documento = 7

data.establecimiento = 1
data.punto = 1
data.numero = 740001
data.descripcion = "Envio"
data.fecha = '2023-01-27T10:00:00'

data.tipo_impuesto = 1

**Cliente
data.cliente = CREATEOBJECT("cliente")
data.cliente.contribuyente = .t.
data.cliente.tipo_contribuyente = 2
data.cliente.direccion = "Calle Loma Pyta"
data.cliente.numero_casa = 24
data.cliente.departamento = 11
data.cliente.distrito = 145
data.cliente.ciudad = 3383
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
data.usuario.cargo = 'Cajero'

**REMISION
data.remision = CREATEOBJECT("remision")
data.remision.motivo= 1
data.remision.tipo_responsable = 1
data.remision.kms = 50

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

** Transporte
data.transporte = CREATEOBJECT("transporte")
data.transporte.inicio_estimado_translado = "2023-01-27"
data.transporte.fin_estimado_translado = "2023-01-27"
data.transporte.tipo = 1
data.transporte.modalidad = 1
data.transporte.tipo_responsable = 1
data.transporte.condicion_negociacion = "FOB"
data.transporte.salida = CREATEOBJECT("transporte_salida")
data.transporte.salida.direccion = "Calle las palomas"
data.transporte.salida.numero_casa = "1"
data.transporte.salida.departamento = 11
data.transporte.salida.distrito = 145
data.transporte.salida.ciudad = 3383
data.transporte.entrega = CREATEOBJECT("transporte_entrega")
data.transporte.entrega.direccion = "Calle loma pyta"
data.transporte.entrega.numero_casa = "24"
data.transporte.entrega.departamento = 11
data.transporte.entrega.distrito = 145
data.transporte.entrega.ciudad = 3383

data.transporte.vehiculo = CREATEOBJECT("transporte_vehiculo")
data.transporte.vehiculo.tipo = "Camioneta"
data.transporte.vehiculo.marca = "YAK"
data.transporte.vehiculo.documento_tipo = 2
data.transporte.vehiculo.numero_matricula = "FDS 123"
data.transporte.transportista = CREATEOBJECT("transporte_transportista")
data.transporte.transportista.contribuyente = .t.
data.transporte.transportista.direccion  = "OCeania parque continental"
data.transporte.transportista.nombre = "EMPRESA S.A."
data.transporte.transportista.ruc = "80069563-1"
data.transporte.transportista.chofer = CREATEOBJECT("transporte_transportista_chofer")
data.transporte.transportista.chofer.documento_numero = "1234567"
data.transporte.transportista.chofer.nombre = "PEDRO GONZALEZ"
data.transporte.transportista.chofer.direccion = "AV. MARAMBAIA  NORTE"
** Documento Asociado
data.documento_asociado = CREATEOBJECT("documento_asociado")
data.documento_asociado.formato = 1
data.documento_asociado.cdc = "01800695631001001072700322023012714845760330"

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


