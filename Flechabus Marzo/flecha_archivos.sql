/* 
En la DE  SFImport_Account tenemos 13.718.954  registros

Si filtramos la DE SFImport_Account  para que muestre los Accounts con Email obtenemos 1.477.322 registros
De los cuales hay muchos mal escritos o repetidos.

Luego de quitar a la DE  SFImport_Account  
los registros con mails duplicados, Bounces, Unsubscribes, 

y empresas que no sean Flechabus, Chevallier, Urquiza y La Veloz
Obtenemos los registros que se muestran en la siguiente DE
DE_Personas_Filtradas con (120.475 rows)

Ubicación: Shared Items / Shared Data Extensions / DE_Personas_Filtradas
 */
/*  Lo ideal seria descargar los 3 con los filtros aplicados.
    Los campos que nos servirían son:
"Fecha de creación de registro" 
"Nombre"
"Apellido" 
"DNI" 
"email" 
*/

/*  */
SELECT
AC.id,
AC.FirstName AS Nombre,
AC.LastName AS Apellido,
AC.CreatedDate AS Fecha_Creacion,
AC.Tipo_de_Documento__PC,
AC.Nro_Documento__pc,
AC.Email__c,
AC.PersonEmail
FROM SFImport_Account AS AC
WHERE AC.PersonEmail is not null or
AC.Email__c is not null

-- (1.479.243 rows) SFImport_Account_con_mail

/*  */
SELECT
AC.id,
AC.FirstName AS Nombre,
AC.LastName AS Apellido,
AC.CreatedDate AS Fecha_Creacion,
AC.Tipo_de_Documento__PC,
AC.Nro_Documento__pc,
AC.Email__c,
AC.PersonEmail
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

    -- (1.051.395 rows)  SFImport_Account_sin_bounceUns

/* 
    Buen día, adjunto los siguientes 3 archivos:

    * 3-4-2024-SFImport_Account_con_mail
    Data Extension: SFImport_Account_con_mail (1.479.243 rows)
    Ubicación: Shared Items / Shared Data Extensions / SFImport_Account_con_mail
    Descripción: Filtramos la DE SFImport_Account para obtener los que contienen un Email

    * 3-6_SFImport_Account_sin_bounceUns
    Data Extension: SFImport_Account_sin_bounceUns (1.051.395 rows)
    Ubicación: Shared Items / Shared Data Extensions / SFImport_Account_sin_bounceUns
    Descripción: Filtramos la DE SFImport_Account para obtener los que contienen un Email y les quitamos Bounce y Unsubcribed

    * 3-6-2024-DE_Personas_Filtradas
    Data Extension: DE_Personas_Filtradas (120.475 rows)
    Ubicación: Shared Items / Shared Data Extensions / DE_Personas_Filtradas
    Descripción: Filtramos la DE SFImport_Account quitamos emails duplicados, Bounces, Unsubscribes y empresas que no sean Flechabus, Chevallier, Urquiza y La Veloz
    



    
    */
/* 3 queries para obtener el restante de la tabla SFImport_Account */
    SELECT TOP 1000000
   id,
   PersonContactId,
   Name as Nombre,
   FirstName,
   LastName,
   Type as Tipo,
   RecordTypeId,
   Phone as Telefono,
   OwnerID,
   CreatedDate as Fecha_Creacion,
   AccountSource as Origen_Cuenta,
   Tipo_de_Documento__PC,
   Nro_Documento__pc,
   ID_Pasajero__PC,
   Id_del_pasajero__c,
   Fecha_de_Nacimiento__c,
   PersonBirthDate,
   Email__c,
   PersonEmail
FROM SFImport_Account_remaining_subs
ORDER BY id

/*  */
SELECT 
 id,
   PersonContactId,
   Name as Nombre,
   FirstName,
   LastName,
   Type as Tipo,
   RecordTypeId,
   Phone as Telefono,
   OwnerID,
   CreatedDate as Fecha_Creacion,
   AccountSource as Origen_Cuenta,
   Tipo_de_Documento__PC,
   Nro_Documento__pc,
   ID_Pasajero__PC,
   Id_del_pasajero__c,
   Fecha_de_Nacimiento__c,
   PersonBirthDate,
   Email__c,
   PersonEmail
FROM (
   SELECT 
   id,
      PersonContactId,
      Name,
      FirstName,
      LastName,
      Type,
      RecordTypeId,
      Phone,
      OwnerID,
      CreatedDate,
      AccountSource,
      Tipo_de_Documento__PC,
      Nro_Documento__pc,
      ID_Pasajero__PC,
      Id_del_pasajero__c,
      Fecha_de_Nacimiento__c,
      PersonBirthDate,
      Email__c,
      PersonEmail,
      ROW_NUMBER() OVER (ORDER BY id) AS RowNumber
   FROM SFImport_Account_remaining_subs
) AS SubQuery
WHERE RowNumber > 1000000 AND RowNumber <= 2000000
/*  */
SELECT AccountId,
   PersonContactId,
   Name as Nombre,
   FirstName,
   LastName,
   Type as Tipo,
   RecordTypeId,
   Phone as Telefono,
   OwnerID,
   CreatedDate as Fecha_Creacion,
   AccountSource as Origen_Cuenta,
   Tipo_de_Documento__PC,
   Nro_Documento__pc,
   ID_Pasajero__PC,
   Id_del_pasajero__c,
   Fecha_de_Nacimiento__c,
   PersonBirthDate,
   Email__c,
   PersonEmail
FROM (
   SELECT AccountId,
      PersonContactId,
      Name,
      FirstName,
      LastName,
      Type,
      RecordTypeId,
      Phone,
      OwnerID,
      CreatedDate,
      AccountSource,
      Tipo_de_Documento__PC,
      Nro_Documento__pc,
      ID_Pasajero__PC,
      Id_del_pasajero__c,
      Fecha_de_Nacimiento__c,
      PersonBirthDate,
      Email__c,
      PersonEmail,
      ROW_NUMBER() OVER (ORDER BY AccountId) AS RowNumber
   FROM SFImport_Account
) AS SubQuery
WHERE RowNumber > 2000000
/*  */