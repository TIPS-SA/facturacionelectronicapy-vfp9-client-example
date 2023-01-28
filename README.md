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



## Creación de un DE
Envia un Documento Electrónico por el método Asincrono.


## Serie Técnica sobre Facturación Electrónica - YouTube

Para más información sobre el proceso que llevó a la generación de éste módulo visite la lista de reproducción "Serie técnica sobre Facturación Electrónica" en el canal de youtube del autor  https://www.youtube.com/channel/UC05xmdC5i3Ob7XnYbQDiBTQ


* * * *

Todos los derechos reservados - 2023
