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