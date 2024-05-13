/*  */
SFImport_Accounts   744.138 records  (PersonEmail , Email__c)

SFIMport_Contacts   781.845 records  (Email)

Empresas             29.524  records   (Email)

DE Empresas_Contacts_Emails  	32,420 records  

/*  */

SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

/* (32.449 rows) */

SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
WHERE CO.Email IS NOT NULL

/* (32.420 rows) */

/*  */
SELECT
CO.Id as Contact_ID,
CO.Email as Contact_Email,
CO.Name as Contact_Name,
EMP.Nombre as Account_Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE 
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL AND CO.Email IS NOT NULL

/* (28217 rows) */
/* (25690 rows) con CO.Email IS NOT NULL*/
/* (25719 rows) sin CO.Email IS NOT NULL*/
SELECT
CO.Id as Contact_ID,
CO.Email as Contact_Email,
CO.Name as Contact_Name,
EMP.Nombre as Account_Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE 
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL
/* 
 */
SELECT
CO.Id as Contact_ID,
CO.Email as Contact_Email,
CO.Name as Contact_Name,
EMP.Nombre as Account_Name,
EMP.Sucursal as Sucursal,
EMP.Rubro1 as Empresa_Rubro,
Acc.Industry as Account_Industry
FROM SFIMport_Contacts as CO
LEFT JOIN SFIMport_Accounts as Acc on Acc.Id = CO.AccountId
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE 
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL
/* (25719 rows) */

/*  */
SELECT Account_Industry 
FROM [Empresas_Contacts_Emails] 
WHERE Account_Industry IS NOT NULL and Account_Industry != 'Otro' and Account_Industry != ''
GROUP BY Account_Industry
/*  */