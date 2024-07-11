SELECT DISTINCT
CON.Name as Name_Contacto,
CON.Email as Email_Contacto,
CTR.Pais__c as Pais_Contrato,
CTR.Status as Status_Contrato,
CTR.EndDate as EndDate_Contrato

FROM SFImport_Contacts as CON

LEFT JOIN SFImport_Accounts as AC on CON.AccountId = AC.Id
LEFT JOIN SFImport_Contrato as CTR on AC.Id = CTR.AccountId

WHERE CTR.Status !='Activated' AND CTR.Pais__c = 'México' AND CTR.EndDate > '2020-06-30'

/*  (1275 rows)  tienen duplicados*/


SELECT DISTINCT
  CON.Name as Name_Contacto,
  CON.Email as Email_Contacto
  
FROM SFImport_Contacts as CON
LEFT JOIN SFImport_Accounts as AC on CON.AccountId = AC.Id
LEFT JOIN SFImport_Contrato as CTR on AC.Id = CTR.AccountId
WHERE CTR.Status = 'Expired'
  AND NOT EXISTS (
    SELECT 1
    FROM SFImport_Contrato
    WHERE AccountId = AC.Id
    AND Status = 'Activated'
  )
  AND CTR.Pais__c = 'México'
  AND CTR.EndDate > '2020-06-30'

  /* (59 rows) */

  SELECT DISTINCT
  CON.Name as Name_Contacto,
  CON.Email as Email_Contacto,
  CTR.Pais__c as Pais_Contrato,
CTR.Status as Status_Contrato,
CTR.EndDate as EndDate_Contrato
  
FROM SFImport_Contacts as CON
LEFT JOIN SFImport_Accounts as AC on CON.AccountId = AC.Id
LEFT JOIN SFImport_Contrato as CTR on AC.Id = CTR.AccountId
WHERE CTR.Status = 'Expired'
  AND NOT EXISTS (
    SELECT 1
    FROM SFImport_Contrato
    WHERE AccountId = AC.Id
    AND Status = 'Activated'
  )
  AND CTR.Pais__c = 'México'
  AND CTR.EndDate > '2020-06-30'

  /*  (90 rows) con duplicados */

  SELECT DISTINCT
  CON.Name as Name_Contacto,
  CON.Email as Email_Contacto
FROM SFImport_Contacts as CON
INNER JOIN (
  SELECT AccountId
  FROM SFImport_Contrato
  WHERE Status = 'Expired'
  GROUP BY AccountId
  HAVING COUNT(DISTINCT Status) = 1  
) AS CTR_Expired ON CON.AccountId = CTR_Expired.AccountId
LEFT JOIN (
  SELECT AccountId, MAX(EndDate) as MaxEndDate
  FROM SFImport_Contrato
  WHERE Status = 'Activated'
  GROUP BY AccountId
) AS CTR_Activated ON CON.AccountId = CTR_Activated.AccountId
WHERE CTR_Activated.AccountId IS NULL  
  AND CTR_Expired.AccountId IN (
    SELECT AccountId
    FROM SFImport_Contrato
    WHERE Pais__c = 'México'

    /* (59 rows) */

    SELECT DISTINCT
  CON.Name as Name_Contacto,
  CON.Email as Email_Contacto,
  AC.Name as Name_Account
FROM SFImport_Contacts as CON
LEFT JOIN SFImport_Accounts as AC on CON.AccountId = AC.Id
INNER JOIN (
  SELECT AccountId
  FROM SFImport_Contrato
  WHERE Status = 'Expired'
  GROUP BY AccountId
  HAVING COUNT(DISTINCT Status) = 1  
) AS CTR_Expired ON CON.AccountId = CTR_Expired.AccountId
LEFT JOIN (
  SELECT AccountId, MAX(EndDate) as MaxEndDate
  FROM SFImport_Contrato
  WHERE Status = 'Activated'
  GROUP BY AccountId
) AS CTR_Activated ON CON.AccountId = CTR_Activated.AccountId
WHERE CTR_Activated.AccountId IS NULL  
  AND CTR_Expired.AccountId IN (
    SELECT AccountId
    FROM SFImport_Contrato
    WHERE Pais__c = 'México'
    AND EndDate > '2020-06-30'
  )
  /*  (59 rows) */

  SELECT
    CON.Name AS Name_Contacto,
    AC.Name AS Name_Cuenta,
    CON.Email AS Email_Contacto,
    CTR.Pais__c AS Pais_Contrato,
    MAX(CASE WHEN CTR.Status = 'Expired' THEN CTR.Status END) AS Status_Contrato,
    MAX(CTR.EndDate) AS EndDate_Contrato
FROM SFImport_Contacts CON
LEFT JOIN SFImport_Accounts AC ON CON.AccountId = AC.Id
LEFT JOIN SFImport_Contrato CTR ON AC.Id = CTR.AccountId
WHERE CTR.Pais__c = 'México' AND CTR.EndDate > '2020-06-30'
GROUP BY
    CON.Name,
    AC.Name,
    CON.Email,
    CTR.Pais__c
HAVING
    MIN(CASE WHEN CTR.Status = 'Activated' THEN 1 ELSE 0 END) = 0 AND
    MIN(CASE WHEN CTR.Status = 'Expired' THEN 1 ELSE 0 END) = 1

    /* (59 rows) */