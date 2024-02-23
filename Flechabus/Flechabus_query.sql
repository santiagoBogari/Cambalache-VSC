-- https://dataviews.io/

SELECT
        _Bounce.AccountID,
        _Bounce.OYBAccountID,
        _Bounce.JobID,
        _Bounce.ListID,
        _Bounce.BatchID,
        _Bounce.SubscriberID,
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.Domain,
        _Bounce.BounceCategoryID,
        _Bounce.BounceCategory,
        _Bounce.BounceSubcategoryID,
        _Bounce.BounceSubcategory,
        _Bounce.BounceTypeID,
        _Bounce.BounceType,
        _Bounce.SMTPBounceReason,
        _Bounce.SMTPMessage,
        _Bounce.SMTPCode,
        _Bounce.TriggererSendDefinitionObjectID,
        _Bounce.TriggeredSendCustomerKey,
        _Subscribers.DateUndeliverable,
        _Subscribers.DateJoined,
        _Subscribers.DateUnsubscribed AS SubscribersDateUnsubscribed,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus,
        _Subscribers.Locale
FROM _Bounce
LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID

/* query emails con bounce */


SELECT
        _Bounce.AccountID,
        _Bounce.OYBAccountID,
        _Bounce.JobID,
        _Bounce.ListID,
        _Bounce.BatchID,
        _Bounce.SubscriberID,
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.BounceCategory,
        _Bounce.BounceSubcategory,
        _Bounce.BounceType,
        _Subscribers.DateJoined,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus
FROM _Bounce
LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
WHERE _Subscribers.Status = 'bounced' 

/* query emails con más de 3 bounce */

SELECT
  s.SubscriberKey AS SubscriberKey,
  sub.EmailAddress AS EmailAddress,
  s.BounceCategory AS BounceCategory,
  CASE WHEN SUM(CASE WHEN s.BounceCategory = 'SoftBounce' THEN 1 ELSE 0 END) >= 3 THEN 'HardBounce' ELSE MAX(s.BounceType) END AS BounceType
FROM [_bounce] s
INNER JOIN [_Subscribers] sub
  ON s.SubscriberKey = sub.SubscriberKey
GROUP BY
  s.SubscriberKey,
  sub.EmailAddress,
  s.BounceCategory

  /* query emails con bounce : BOUNCECATEGORY y TOTALSUBSCRIBERS */
  FROM
  (SELECT
    s.SubscriberKey AS SubscriberKey,
    sub.EmailAddress AS EmailAddress,
    s.BounceCategory AS BounceCategory
  FROM [_bounce] s
  INNER JOIN [_Subscribers] sub ON s.SubscriberKey = sub.SubscriberKey
  GROUP BY
    s.SubscriberKey,
    sub.EmailAddress,
    s.BounceCategory) s
GROUP BY s.BounceCategory

/* query emails con bounce : 
trae el primer registro para cada dirección de correo electrónico única según el orden de fecha de rebote.  */
-- Data Extensions / test / Bounced_Emails
-- 110271 Records / 02/13/2024
SELECT 
    SubscriberKey,
    BounceEventDate,
    BounceCategory,
    BounceSubcategory,
    BounceType,
    EmailAddress,
    BounceCount,
    SubscribersStatus
FROM (
    SELECT 
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.BounceCategory,
        _Bounce.BounceSubcategory,
        _Bounce.BounceType,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.Status AS SubscribersStatus,
        ROW_NUMBER() OVER (PARTITION BY _Subscribers.EmailAddress ORDER BY _Bounce.EventDate) AS RowNumber
    FROM _Bounce
    LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
    WHERE _Subscribers.Status = 'bounced' AND _Subscribers.EmailAddress IS NOT NULL
) AS Subquery
WHERE RowNumber = 1

/* query emails con bounce : 
trae el primer registro para cada dirección de correo electrónico única según el orden de fecha de rebote. 
Agrega el campo 'Name' de la Data Extension 'SFImport_Account' según el match con el campo 'PersonEmail'  */
-- Data Extensions / test / Bounced_Emails_Name
-- 273137 Records / 02/13/2024
SELECT
    Subquery.SubscriberKey,
    Subquery.BounceEventDate,
    Subquery.BounceCategory,
    Subquery.BounceSubcategory,
    Subquery.BounceType,
    Subquery.EmailAddress,
    Subquery.BounceCount,
    Subquery.SubscribersStatus,
    SFImport_Account.Name AS AccountName
FROM (
    SELECT
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.BounceCategory,
        _Bounce.BounceType,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.Status AS SubscribersStatus,
        ROW_NUMBER() OVER (PARTITION BY _Subscribers.EmailAddress ORDER BY _Bounce.EventDate) AS RowNumber
    FROM _Bounce
    LEFT JOIN _Subscribers
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
    WHERE _Subscribers.Status = 'bounced' AND _Subscribers.EmailAddress IS NOT NULL
) AS Subquery
LEFT JOIN SFImport_Account
    ON Subquery.EmailAddress = SFImport_Account.PersonEmail
WHERE Subquery.RowNumber = 1

/* a la DE Bounced_Emails agrego Name y Id de la DE SFImport_Account, matcheando con el campo email  */
-- Data Extensions / test / Bounced_Emails_Name_Id
-- 243710 Records / 02/14/2024
SELECT
    Subquery.SubscriberKey,
    Subquery.BounceEventDate,
    Subquery.BounceCategory,
    Subquery.BounceType,
    Subquery.EmailAddress,
    Subquery.BounceCount,
    Subquery.SubscribersStatus,
    SFImport_Account.Name AS AccountName,
    SFImport_Account.Id
FROM (
    SELECT
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.BounceCategory,
        _Bounce.BounceType,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.Status AS SubscribersStatus,
        ROW_NUMBER() OVER (PARTITION BY _Subscribers.EmailAddress ORDER BY _Bounce.EventDate) AS RowNumber
    FROM _Bounce
    LEFT JOIN _Subscribers
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
    WHERE _Subscribers.Status = 'bounced' AND _Subscribers.EmailAddress IS NOT NULL
) AS Subquery
INNER JOIN SFImport_Account
    ON Subquery.EmailAddress = SFImport_Account.PersonEmail
WHERE Subquery.RowNumber = 1


-----------------------------------------------------------------------------------------------------

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

--(1474174 rows) 

/*  */

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

-- (1016430 rows) DE Results4empresas

/* Next Query : SFImport_Account (with emails != null)
Unsubscribed 
Bounced_Emails_Name_Id  
*/
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

   /*  (1199068 rows) */

   /*  */
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

   /*   (1276901 rows) */




-- Todos los de SFImport-account que tengan las 4 empresas en SFImport-boletos
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

-- Todos los de SFImport-account que tengan las 4 empresas en SFImport-boletos

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
LEFT JOIN SFImport_Boletos AS BO 
    ON BO.Id_Pasajero_Salesforce__c = AC.Id
WHERE AC.PersonEmail IS NOT NULL 
AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

--  (145307 rows)

/* Query Luca  */
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
--  (145335 rows)

/* -- Todos los de 'Results_tofilter' que tengan las 4 empresas en SFImport-boletos */
select
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
from Results_tofilter as AC
left join SFImport_Boletos as BO on BO.Id_Pasajero_Salesforce__c = AC.Id
where 
BO.Empresa_Venta__c = 'Chevallier' or 
BO.Empresa_Venta__c = 'Flechabus' or
BO.Empresa_Venta__c = 'Urquiza' or
BO.Empresa_Venta__c = 'La Veloz'

--  (114758 rows)

/*  */

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
FROM Results_4_empresas AS AC
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

/* GER Query */

SELECT DISTINCT a.id,
       a.PersonContactId,
       a.Name AS Nombre,
       a.FirstName,
       a.LastName,
       a.Type AS Tipo,
       a.RecordTypeId,
       a.Phone AS Telefono,
       a.OwnerID,
       a.CreatedDate AS Fecha_Creacion,
       a.AccountSource AS Origen_Cuenta,
       a.Tipo_de_Documento__PC AS tipo_documento,
       a.Nro_Documento__pc,
       a.ID_Pasajero__PC,
       a.Id_del_pasajero__c,
       a.Fecha_de_Nacimiento__c,
       a.PersonBirthDate,
       a.Email__c,
       a.PersonEmail,
       a.Phone
FROM SFImport_Account AS a
LEFT JOIN (
  SELECT DISTINCT *
  FROM SFImport_Boletos
  WHERE Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')
) AS b
  ON b.Id_Pasajero_Salesforce__c = a.Id
WHERE a.PersonEmail IS NOT NULL
AND a.IsPersonAccount = '1'

-- (1475106 rows)


/*  */
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
FROM Results_4empresas AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM _ListSubscribers AS LS
        WHERE (LS.Status = 'held' OR LS.Status = 'bounced' OR LS.Status = 'unsubscribed')
          AND (AC.PersonEmail = LS.EmailAddress OR AC.Email__c = LS.EmailAddress)
    )

    -- (1368273 rows)

    /*  */
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
FROM Results_4empresas AS AC
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

    -- (1215582 rows)

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
BO.Empresa_Venta__c = 'Chevallier' or
BO.Empresa_Venta__c = 'Flechabus' or
BO.Empresa_Venta__c = 'Urquiza' or
BO.Empresa_Venta__c = 'La Veloz'

-- (461435 rows)  Results_distinct_4emp

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
AC.Phone,
AC.Empresa_Venta__c
FROM Results_distinct_4emp AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM _ListSubscribers AS LS
        WHERE (LS.Status = 'held' OR LS.Status = 'bounced' OR LS.Status = 'unsubscribed')
          AND (AC.PersonEmail = LS.EmailAddress OR AC.Email__c = LS.EmailAddress)
    )

    -- (455439 rows)  Results_acc_4emp_unBo

    ---------------------------------------------------------------------------------------------21-2
    
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
WHERE  AC.PersonEmail IS NOT NULL AND
 BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

 -- (71514 rows) (la query anterior con   AC.PersonEmail IS NOT NULL)

SELECT DISTINCT
    BO.Nro_Documento__c,
    MAX(BO.id) AS id,
    MAX(BO.CreatedDate) AS CreatedDate,
    MAX(BO.Id_Boleto__c) AS Id_Boleto__c,
    MAX(BO.Id__c) AS Id__c,
    MAX(BO.Agencia_Venta__c) AS Agencia_Venta__c,
    MAX(BO.C_digo_Calidad__c) AS C_digo_Calidad__c,
    MAX(BO.C_digo_parada_origen__c) AS C_digo_parada_origen__c,
    MAX(BO.C_digo_parada_destino__c) AS C_digo_parada_destino__c,
    MAX(BO.C_digo_servicio__c) AS C_digo_servicio__c,
    MAX(BO.Codigo_boleto__c) AS Codigo_boleto__c,
    MAX(BO.Cuenta__c) AS Cuenta__c,
    MAX(BO.Id_Pasajero_Salesforce__c) AS Id_Pasajero_Salesforce__c,
    MAX(BO.Id_Pasajero__c) AS Id_Pasajero__c,
    MAX(BO.Tipo_Documento__c) AS Tipo_Documento__c,
    MAX(BO.Empresa_Servicio__c) AS Empresa_Servicio__c,
    MAX(BO.Empresa_Venta__c) AS Empresa_Venta__c,
    MAX(BO.Fecha_Venta__c) AS Fecha_Venta__c,
    MAX(BO.Fecha_Servicio__c) AS Fecha_Servicio__c,
    MAX(BO.Kms_Operaci_n__c) AS Kms_Operaci_n__c,
    MAX(BO.Pa_s_Origen__c) AS Pa_s_Origen__c,
    MAX(BO.Pa_s_Destino__c) AS Pa_s_Destino__c,
    MAX(BO.Provincia_Origen__c) AS Provincia_Origen__c,
    MAX(BO.Provincia_Destino__c) AS Provincia_Destino__c,
    MAX(BO.Localidad_Origen__c) AS Localidad_Origen__c,
    MAX(BO.Localidad_Destino__c) AS Localidad_Destino__c
FROM
    SFImport_Boletos AS BO
WHERE
    BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')
GROUP BY
    BO.Nro_Documento__c

-- DE Dni_che_fbu_lvn_urq   (488219 rows)

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
INNER JOIN Dni_che_fbu_lvn_urq AS BO 
    ON Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c) = Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC)
WHERE  AC.PersonEmail IS NOT NULL AND
 BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

 -- (65745 rows)

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
WHERE  (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL) AND
 BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

 -- (428731 rows)

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
AC.Empresa_Venta__c,
AC.dnicuenta,
AC.dniboleto
FROM Acc_boletos4emp_xdni_conmail AS AC
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

-- (357725 rows)

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
AC.Empresa_Venta__c,
AC.dnicuenta,
AC.dniboleto
FROM Acc_boletos4emp_xdni_conmail AS AC
WHERE
    (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL)
    AND NOT EXISTS (
        SELECT 1
        FROM _ListSubscribers AS LS
        WHERE (LS.Status = 'held' OR LS.Status = 'bounced' OR LS.Status = 'unsubscribed')
          AND (AC.PersonEmail = LS.EmailAddress OR AC.Email__c = LS.EmailAddress)
    )

-- (415837 rows)

----------------------------------------------------------------------------22/2
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
WHERE (AC.PersonEmail IS NOT NULL OR AC.Email__c IS NOT NULL) AND
 BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

 -- (71524 rows)

 /*  */

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

-- (71397 rows) (con inner join trae la misma cantidad)

/*  */
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

-- (71397 rows)

/* comprobación de la query personas/boletos sin DISTINCT */
SELECT
    MAX(AC.id) AS id,
    AC.PersonContactId,
    AC.Name AS Nombre,
    AC.FirstName,
    AC.LastName,
    AC.Type AS Tipo,
    AC.RecordTypeId,
    MAX(AC.Phone) AS Telefono,
    AC.OwnerID,
    MAX(AC.CreatedDate) AS Fecha_Creacion,
    AC.AccountSource AS Origen_Cuenta,
    AC.Tipo_de_Documento__PC,
    AC.Nro_Documento__pc,
    AC.ID_Pasajero__PC,
    AC.Id_del_pasajero__c,
    AC.Fecha_de_Nacimiento__c,
    AC.PersonBirthDate,
    AC.Email__c,
    AC.PersonEmail,
    AC.IsPersonAccount,
    BO.Empresa_Venta__c,
    Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC) AS dnicuenta,
    Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c) AS dniboleto
FROM
    SFImport_Account AS AC
INNER JOIN
    Dni_che_fbu_lvn_urq AS BO 
    ON Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c) = Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC)
WHERE
    AC.PersonEmail IS NOT NULL
    AND BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')
GROUP BY
    AC.PersonContactId,
    AC.Name,
    AC.FirstName,
    AC.LastName,
    AC.Type,
    AC.RecordTypeId,
    AC.OwnerID,
    AC.AccountSource,
    AC.Tipo_de_Documento__PC,
    AC.Nro_Documento__pc,
    AC.ID_Pasajero__PC,
    AC.Id_del_pasajero__c,
    AC.Fecha_de_Nacimiento__c,
    AC.PersonBirthDate,
    AC.Email__c,
    AC.PersonEmail,
    AC.IsPersonAccount,
    BO.Empresa_Venta__c,
    Concat(AC.Tipo_de_documento__PC,AC.Nro_Documento__PC),
    Concat(BO.Tipo_Documento__c,BO.Nro_Documento__c)

---- (65746 rows)  trae mismo resultado que con DISTINCT

SELECT  
    BO.Nro_Documento__c,
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
    BO.Tipo_Documento__c,
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
    BO.Localidad_Destino__c,
    SA.id AS AccID,
    SA.FirstName,
    SA.LastName,
    SA.Phone,
    SA.Email__c,
    SA.PersonEmail
FROM
    SFImport_Boletos AS BO
LEFT JOIN
    (
        SELECT
            id,
            FirstName,
            LastName,
            Phone,
            Email__c,
            PersonEmail,
            Nro_Documento__PC
        FROM
            SFImport_Account
    ) AS SA
    ON BO.Nro_Documento__c = SA.Nro_Documento__PC
WHERE
    BO.Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')

    -- (1140200 rows)