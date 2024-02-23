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


-----------------------------------------------------------------------------21/2/2024

SELECT DISTINCT
AC.id,
AC.PersonContactId,
AC.Name AS Nombre,
AC.FirstName,
AC.LastName,
AC.Type AS Tipo,
AC.RecordTypeId,
AC.Phone AS Telefono,
AC.OwnerID,
AC.CreatedDate AS Fecha_Creacion,
AC.AccountSource AS Origen_Cuenta,
AC.Tipo_de_Documento__PC,
AC.Nro_Documento__pc,
AC.ID_Pasajero__PC,
AC.Id_del_pasajero__c,
AC.Fecha_de_Nacimiento__c,
AC.PersonBirthDate,
AC.Email__c,
AC.PersonEmail,
AC.Phone,
AC.IsPersonAccount,
BO.Empresa_Venta__c,
Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC) AS dnicuenta,
Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c) AS dniboleto
FROM SFImport_Account AS AC
INNER JOIN SFImport_Boletos AS BO 
    ON Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c) = Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC)
WHERE  
 BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

 -- DE Acc_boletos4emp_xdni (534317 rows)

 