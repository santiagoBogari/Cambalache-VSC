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

-- (1016430 rows)

/*  */