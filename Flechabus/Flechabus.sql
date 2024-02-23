-- comenzando por filtrar las 4 empresas

SELECT
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
BO.Empresa_Venta__c
FROM SFImport_Account AS AC
INNER JOIN SFImport_Boletos AS BO 
    ON BO.Id_Pasajero_Salesforce__c = AC.Id
WHERE AC.PersonEmail IS NOT NULL 
AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

--Results--(145325 rows)

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
BO.Empresa_Venta__c
FROM SFImport_Account AS AC
INNER JOIN SFImport_Boletos AS BO 
    ON BO.Id_Pasajero_Salesforce__c = AC.Id
WHERE AC.PersonEmail IS NOT NULL 
AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

--Results--(71392 rows)

SELECT DISTINCT
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
AC.IsPersonAccount,
BO.Empresa_Venta__c
from SFImport_Account as AC
left join SFImport_Boletos as BO on BO.Id_Pasajero_Salesforce__c = AC.Id
where
AC.PersonEmail is not null and BO.Empresa_Venta__c is not null and
(BO.Empresa_Venta__c = 'Chevallier' or
BO.Empresa_Venta__c = 'Flechabus' or
BO.Empresa_Venta__c = 'Urquiza' or
BO.Empresa_Venta__c = 'La Veloz')

--Results--(71392 rows)

SELECT
AC.id,
AC.PersonContactId,
AC.Nombre,
AC.FirstName,
AC.LastName,
AC.Tipo,
AC.RecordTypeId,
AC.Telefono,
AC.OwnerID,
AC.Fecha_Creacion,
AC.Origen_Cuenta,
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
FROM Results4empresas_2 AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM Unsubscribed AS U
        WHERE AC.Email__c = U.EmailAddress OR AC.PersonEmail = U.EmailAddress
    )
    AND NOT EXISTS (
        SELECT 1
        FROM Bounced_Emails_Name_Id AS BE
        WHERE AC.Email__c = BE.EmailAddress OR AC.PersonEmail = BE.EmailAddress
    )

--Results--(57514 rows)

SELECT
AC.id,
AC.PersonContactId,
AC.Nombre,
AC.FirstName,
AC.LastName,
AC.Tipo,
AC.RecordTypeId,
AC.Telefono,
AC.OwnerID,
AC.Fecha_Creacion,
AC.Origen_Cuenta,
AC.Nro_Documento__pc,
AC.ID_Pasajero__PC,
AC.Id_del_pasajero__c,
AC.Fecha_de_Nacimiento__c,
AC.PersonBirthDate,
AC.Email__c,
AC.PersonEmail,
AC.Phone
FROM Results4empresas_2 AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM _ListSubscribers AS LS
        WHERE (LS.Status = 'held' OR LS.Status = 'bounced' OR LS.Status = 'unsubscribed')
          AND (AC.PersonEmail = LS.EmailAddress OR AC.Email__c = LS.EmailAddress)
    )

--Results--(65395 rows)

