**
** Ejemplo de llamada a API de FacturaSend desde VisualFoxPro 9.0
** 
** Creacion de un documento electrónico por el método sincrono
**
** https://docs.facturasend.com.py/#creacion-de-un-de
**
** Autor: Marcos Jara
** Fecha: 2023-01-23
** 

SET PROCEDURE TO .\fsClass\de, .\fsClass\cliente, .\fsClass\usuario, .\fsClass\factura, .\fsClass\item, .\fsClass\condicion, .\fsClass\entrega, .\nfJson\nfJsonCreate, .\nfJson\nfJsonRead

data = CREATEOBJECT("de")
data.tipo_documento = 1

data.establecimiento = 2
data.punto = 1
data.numero = 1007093

data.fecha = '2023-01-23T10:00:00'

data.tipo_impuesto = 1

**Cliente
data.cliente = CREATEOBJECT("cliente")
data.cliente.contribuyente = .t.
data.cliente.tipo_contribuyente = 1
data.cliente.tipo_operacion = 1
data.cliente.ruc = '80069563-1'
data.cliente.razon_social = 'TIPS S.A. - TECNOLOGIA Y SERVICIOS'
data.cliente.pais = 'PRI'
data.cliente.codigo = 'CLI001'

** Usuario
data.usuario = CREATEOBJECT("usuario")
data.usuario.documento_tipo = 1
data.usuario.documento_numero = '2005001'
data.usuario.nombre = 'MARCOS JARA'
data.usuario.cargo = 'Cajero'

**Factura
data.factura = CREATEOBJECT("factura")
data.factura.presencia = 1

** Items
DIMENSION data.items(2)

data.items(1) = CREATEOBJECT("item")
data.items(1).codigo = 1050
data.items(1).descripcion = 'Pilsen Litro '
data.items(1).observacion = 'no beberla caliente'
data.items(1).cantidad = 2
data.items(1).precio_unitario = 7500
data.items(1).iva_tipo = 1
data.items(1).iva_base = 100
data.items(1).iva = 10

data.items(2) = CREATEOBJECT("item")
data.items(2).codigo = 1060
data.items(2).descripcion = 'Dorada Premium'
data.items(2).observacion = 'Tomarla bien helada'
data.items(2).cantidad = 3
data.items(2).precio_unitario = 8754
data.items(2).iva_tipo = 1
data.items(2).iva_base = 100
data.items(2).iva = 10

** Condicion
data.condicion = CREATEOBJECT("condicion")
data.condicion.tipo = 1
DIMENSION data.condicion.entregas(1)
data.condicion.entregas(1) = CREATEOBJECT("entrega")
data.condicion.entregas(1).tipo = 1
data.condicion.entregas(1).monto = 1450000
data.condicion.entregas(1).moneda = 'PYG'

cData = nfJsonCreate(data, .t., .f.)

SET ALTERNATE TO json.txt ADDITIVE
SET ALTERNATE ON
? cData 
SET ALTERNATE OFF

* Envio a FacturaSend

oHTTP = CREATEOBJECT('Msxml2.ServerXMLHTTP.6.0')
*oHTTP.OPEN("POST","https://api.facturasend.com.py/empresa0/de/create", .f.)
oHTTP.OPEN("POST","http://localhost:3002/api/empresa0/de/create", .f.)
oHTTP.setRequestHeader("User-Agent", "FacturaSend from VFP 9")
oHTTP.setRequestHeader("Content-Type", "application/json;charset=utf-8")
           
lcBasicAuth = "Bearer " + "api_key_9FFC28EB-5376-4392-B757-86E372FBB398"
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


