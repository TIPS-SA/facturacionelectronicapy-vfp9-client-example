data="hola"
  oHTTP = CREATEOBJECT('Msxml2.ServerXMLHTTP.6.0')
            oHTTP.OPEN("GET","https://api.facturasend.com.py/test", .F.)
            oHTTP.setRequestHeader("User-Agent", "EjecutandoWS desde VFP - PortalFOX")
            oHTTP.setRequestHeader("Content-Type", "application/json;charset=utf-8")
           
lcBasicAuth = "Bearer " + "api_key_88E86FDE-6772-4998-BEBC-21319D2BD3FF"
oHTTP.setRequestHeader("Authorization",lcBasicAuth)
            oHTTP.SEND()
            ? oHTTP.Status
? oHTTP.responseText
cRespuesta = oHTTP.ResponseText
thisform.resp.Value=cRespuesta