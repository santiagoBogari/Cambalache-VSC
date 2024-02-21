-- comenzando por filtrar Accounts - Bounce - Unsuscribers

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
    AC.IsPersonAccount
FROM
    SFImport_Account AS AC
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

    --Results-- (1215901 rows)  DE  Acc_sinBounce_sinUns

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
    AC.IsPersonAccount
FROM
    SFImport_Account AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM _ListSubscribers AS LS
        WHERE (LS.Status = 'held' OR LS.Status = 'bounced' OR LS.Status = 'unsubscribed')
          AND (AC.PersonEmail = LS.EmailAddress OR AC.Email__c = LS.EmailAddress)
    )

--Results-- (1368598 rows)

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
AC.IsPersonAccount,
BO.Empresa_Venta__c
FROM Acc_sinBounce_sinUns AS AC
INNER JOIN SFImport_Boletos AS BO 
    ON BO.Id_Pasajero_Salesforce__c = AC.Id
WHERE AC.PersonEmail IS NOT NULL 
AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

--Results-- (118222 rows)  (tiene duplicados)

SELECT DISTINCT
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
AC.IsPersonAccount,
BO.Empresa_Venta__c
FROM Acc_sinBounce_sinUns AS AC
INNER JOIN SFImport_Boletos AS BO 
    ON BO.Id_Pasajero_Salesforce__c = AC.Id
WHERE AC.PersonEmail IS NOT NULL 
AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

--Results-- (57522 rows)