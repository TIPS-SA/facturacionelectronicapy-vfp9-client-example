# facturacionelectronicapy-vfp9-client-example
Ejemplos de invocación de API REST de FacturaSend desde Visual FoxPro 9, para creación de Documentos Electrónicos del Sifen-eKuatia

No es necesario API de terceros, DLLs ni librerías externas.

# JSON Convert/Format utilizada
La siguiente Librería es utilizada para la conversion JSON
https://github.com/VFPX/nfJson

Una copia de la librería ya está dentro de éste repositorio en la ubicacion:

./nfJson

No se necesita descargar a parte, Fecha de Descarga: 2022-01-28.

# Clases para envio de Datos de FacturaSend
Las clases para convertir automáticamente los datos enviados desde VFP a FacturaSend se encuentran en la ubicación:

./fsClass

La definición de Clases es la misma que se puede encontrar en la documentación:
https://docs.facturasend.com.py

Con la diferencia de que en VFP se utiliza _ (underscore) y en el manual está documentado como CamelCase, ej.: El tipoDocumento desde VFP puede enviarse como tipo_documento.

# Ejemplo de Uso

En la Ubicación raiz encontrará varios ejemplos ya listos para ser consumidos.

## Creación de un DE
Envia un Documento Electrónico por el método Sincrono.


Visual FoxPro (.prg) Program:
``` 

** Importar Libreria de Clases
SET PROCEDURE TO .\fsClass\de, .\fsClass\cliente, .\fsClass\usuario, .\fsClass\factura, .\fsClass\item, .\fsClass\condicion, .\fsClass\entrega, .\nfJson\nfJsonCreate, .\nfJson\nfJsonRead

** Crear el objeto principal de en "data" y completar los atributos conforme el documento electrónico
data = CREATEOBJECT("de")
data.tipo_documento = 1

data.establecimiento = 2
data.punto = 1
data.numero = 1

data.fecha = '2023-01-23T10:00:00'

data.tipo_impuesto = 1

** Cliente
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

** Factura
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

** Crear un archivo json.txt para ir guardando un historico de cada proceso
SET ALTERNATE TO json.txt ADDITIVE
SET ALTERNATE ON
? cData 
SET ALTERNATE OFF

* Envio a FacturaSend
oHTTP = CREATEOBJECT('Msxml2.ServerXMLHTTP.6.0')
oHTTP.OPEN("POST","https://api.facturasend.com.py/empresa0/de/create", .f.)
oHTTP.setRequestHeader("User-Agent", "FacturaSend from VFP 9")
oHTTP.setRequestHeader("Content-Type", "application/json;charset=utf-8")

* Seteo de la API Key      
lcBasicAuth = "Bearer " + "api_key_9FFC28EB-5376-4392-B757-86E372FBB398a"
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
```

## Creación de varios DEs (Envio por lote)
Envia un Documento Electrónico por el método Asincrono.

Es el mismo proceso que el anterior, con la diferencia que el envio a FacturaSend se realiza en formato de array y puede ser enviado hasta 50 Documentos al mismo tiempo.

Visual FoxPro (.prg) Program:
```
SET PROCEDURE TO .\fsClass\de, .\fsClass\cliente, .\fsClass\usuario, .\fsClass\factura, .\fsClass\item, .\fsClass\condicion, .\fsClass\entrega, .\nfJson\nfJsonCreate, .\nfJson\nfJsonRead

data = CREATEOBJECT("de")
data.tipo_documento = 1

data.establecimiento = 2
data.punto = 1
data.numero = 1007094

data.fecha = '2023-01-23T10:00:00'

data.tipo_impuesto = 1

** Cliente
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
? "[" + cData + "]"
SET ALTERNATE OFF

* Envio a FacturaSend
oHTTP = CREATEOBJECT('Msxml2.ServerXMLHTTP.6.0')
oHTTP.OPEN("POST","https://api.facturasend.com.py/empresa0/lote/create", .f.)
oHTTP.setRequestHeader("User-Agent", "FacturaSend from VFP 9")
oHTTP.setRequestHeader("Content-Type", "application/json;charset=utf-8")
           
lcBasicAuth = "Bearer " + "api_key_9FFC28EB-5376-4392-B757-86E372FBB398a"
oHTTP.setRequestHeader("Authorization", lcBasicAuth)

** Aqui radica la diferencia entre el Sincrono y el Asincrono.
oHTTP.SEND("[" + cData + "]")

** Para enviar varios, utilizar este formato
**oHTTP.SEND("[" + cData + ", " + cData1 +  ", " + cData2 + ", " + cDataN + "]")

? "Status Response: " + STR(oHTTP.Status)
cRespuesta = oHTTP.ResponseText
? cRespuesta

* Convertir respuesta de la API en formato JSON-STRING a OBJETO VFP
vfpJsonObject = nfJsonRead(cRespuesta, .f.)
? vfpJsonObject.success

IF ( ! vfpJsonObject.success)
	? vfpJsonObject.error
ENDIF  
```

## Serie Técnica sobre Facturación Electrónica - YouTube

Para más información sobre el proceso que llevó a la generación de éste módulo visite la lista de reproducción "Serie técnica sobre Facturación Electrónica" en el canal de youtube del autor  https://www.youtube.com/channel/UC05xmdC5i3Ob7XnYbQDiBTQ


* * * *

Todos los derechos reservados - 2023
