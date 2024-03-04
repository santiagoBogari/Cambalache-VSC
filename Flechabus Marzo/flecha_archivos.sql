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