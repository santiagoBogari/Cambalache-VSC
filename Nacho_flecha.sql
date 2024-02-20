select
AC.id,
AC.PersonContactId,
AC.Name as Nombre,
AC.FirstName,
AC.LastName,
AC.Type as Tipo,
AC.RecordTypeId,
AC.Phone as Telefono,
AC.OwnerID,
AC.CreatedDate as Fecha_Creacion,
AC.AccountSource as Origen_Cuenta,
AC.Tipo_de_Documento__PC,
AC.Nro_Documento__pc,
AC.ID_Pasajero__PC,
AC.Id_del_pasajero__c,
AC.Fecha_de_Nacimiento__c,
AC.PersonBirthDate,
AC.Email__c,
AC.PersonEmail,
AC.Phone,
AC.IsPersonAccount
from SFImport_Account as AC
where AC.PersonEmail is not null or
Email__c is not null


/*  */
/* boletos: */
select
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
from SFImport_Boletos as BO
--  (8570896 rows)


/* accounts con prod cartesiano */
select
AC.id,
AC.PersonContactId,
AC.Name as Nombre,
AC.FirstName,
AC.LastName,
AC.Type as Tipo,
AC.RecordTypeId,
AC.Phone as Telefono,
AC.OwnerID,
AC.CreatedDate as Fecha_Creacion,
AC.AccountSource as Origen_Cuenta,
AC.Tipo_de_Documento__PC,
AC.Nro_Documento__pc,
AC.ID_Pasajero__PC,
AC.Id_del_pasajero__c,
AC.Fecha_de_Nacimiento__c,
AC.PersonBirthDate,
AC.Email__c,
AC.PersonEmail,
AC.Phone,
AC.IsPersonAccount
from SFImport_Account as AC
left join SFImport_Boletos as BO on BO.Id_Pasajero_Salesforce__c = AC.Id
where
AC.PersonEmail is not null and
AC.IsPersonAccount = '1' and
BO.Empresa_Venta__c = 'Chevallier' or
BO.Empresa_Venta__c = 'Flechabus' or
BO.Empresa_Venta__c = 'Urquiza' or
BO.Empresa_Venta__c = 'La Veloz'