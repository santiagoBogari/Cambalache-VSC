SELECT
BO.id,
BO.CreatedDate,
BO.Id_Boleto__c,
BO.Id__c,
BO.Agencia_Venta__c,
BO.C_digo_Calidad__c,
BO.C_digo_parada_origen__c,
BO.C_digo_parada_destino__c,
BO.C_digo_servicio__c,
BO.Codigo_boleto__c,
BO.Cuenta__c,
BO.Id_Pasajero_Salesforce__c,
BO.Id_Pasajero__c,
BO.Empresa_Servicio__c,
BO.Empresa_Venta__c,
BO.Fecha_Venta__c,
BO.Fecha_Servicio__c,
BO.Kms_Operaci_n__c,
BO.Pa_s_Origen__c,
BO.Pa_s_Destino__c,
BO.Provincia_Origen__c,
BO.Provincia_Destino__c,
BO.Localidad_Origen__c,
BO.Localidad_Destino__c

FROM SFImport_Boletos AS BO
WHERE BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

-- (1139578 rows)

