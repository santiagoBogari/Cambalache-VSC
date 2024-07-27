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


    /*  */
    SELECT Id, Name, email__c, Tiene_contrato_activo__c, ShippingCountry

FROM SFImport_Accounts_2

WHERE Tiene_contrato_activo__c = 'False' AND (ShippingCountry = 'México' OR ShippingCountry = 'Mexico')

/* (453 rows) */



001F000000txrKMIAY
/* popula Cuentas_Contratos antes de los nuevos campos 25-7 */
SELECT  
co.Id as ContratoId, 
AC.Name as AccountName,
AC.Tiene_contrato_activo__c as Tiene_contrato_activo,
co.AccountId as AccountId,
AC.email__c as AccountEmail,
co.Email_Contacto_Tecnico__c as Email_Contacto_Tecnico,
co.Email_Contacto_Comercial__c as Email_Contacto_Comercial,
co.StartDate, co.EndDate, 
co.BillingCountry,
co.ShippingCountry,
co.OwnerId, co.Status,
co.StatusCode,
co.CreatedDate, co.CreatedById, co.LastModifiedDate,
co.LastModifiedById,
co.Fecha_Fin_Contrato__c,
co.Sub_Brand__c,
co.Territorio__c, co.Pais__c, co.Dias_para_vencer__c, AC.Fecha_proximo_vencimiento_contrato__c

FROM SFImport_Contrato as co
LEFT JOIN SFImport_Accounts_2 as AC on co.AccountId = AC.Id
WHERE AC.email__c IS NOT NULL or co.Email_Contacto_Tecnico__c IS NOT NULL 
or co.Email_Contacto_Comercial__c IS NOT NULL
/*  */



/* con los nuevos campos de contrato en cuenta */
SELECT  
co.Id as ContratoId, 
AC.Name as AccountName,
AC.Tienecontratoactivo__c as Tiene_contrato_activo,
co.AccountId as AccountId,
AC.email__c as AccountEmail,
co.Email_Contacto_Tecnico__c as Email_Contacto_Tecnico,
co.Email_Contacto_Comercial__c as Email_Contacto_Comercial,
co.StartDate, co.EndDate, 
co.BillingCountry,
co.ShippingCountry,
co.OwnerId, co.Status,
co.StatusCode,
co.CreatedDate, co.CreatedById, co.LastModifiedDate,
co.LastModifiedById,
co.Fecha_Fin_Contrato__c,
co.Sub_Brand__c,
co.Territorio__c, co.Pais__c, co.Dias_para_vencer__c, 
AC.Fecha_proximo_vencimiento_contrato__c as fecha_prox_vto_contrato,
AC.Fecha_de_vencimiento_de_ltimo_contrato__c as fecha_vto_ultimo_contrato, 	
AC.Estado_seg_n_Contrato__c as Estado_segun_Contrato

FROM SFImport_Contrato as co
LEFT JOIN SFImport_Accounts_3 as AC on co.AccountId = AC.Id

/* (2040 rows) */

SELECT
co.Id as ContratoId, 
AC.Name as AccountName,
AC.Tienecontratoactivo__c as Tiene_contrato_activo,
co.AccountId as AccountId,
AC.email__c as AccountEmail,
co.Email_Contacto_Tecnico__c as Email_Contacto_Tecnico,
co.Email_Contacto_Comercial__c as Email_Contacto_Comercial,
co.StartDate, co.EndDate, 
co.BillingCountry,
co.ShippingCountry,
co.OwnerId, co.Status,
co.StatusCode,
co.CreatedDate, co.CreatedById, co.LastModifiedDate,
co.LastModifiedById,
co.Fecha_Fin_Contrato__c,
co.Sub_Brand__c,
co.Territorio__c, co.Pais__c, co.Dias_para_vencer__c, 
AC.Fecha_proximo_vencimiento_contrato__c as fecha_prox_vto_contrato,
AC.Fecha_de_vencimiento_de_ltimo_contrato__c as fecha_vto_ultimo_contrato, 	
AC.Estado_seg_n_Contrato__c as Estado_segun_Contrato

FROM SFImport_Contrato as co
LEFT JOIN SFImport_Accounts_3 as AC on co.AccountId = AC.Id

WHERE AC.email__c IS NOT NULL or co.Email_Contacto_Tecnico__c IS NOT NULL 
or co.Email_Contacto_Comercial__c IS NOT NULL
/*  (1857 rows) */

/* sin duplicados por Account */
SELECT
  ContratoId,
  AccountName,
  Tiene_contrato_activo,
  AccountId,
  AccountEmail,
  Email_Contacto_Tecnico,
  Email_Contacto_Comercial,
  StartDate,
  EndDate,
  BillingCountry,
  ShippingCountry,
  OwnerId,
  Status,
  StatusCode,
  CreatedDate,
  CreatedById,
  LastModifiedDate,
  LastModifiedById,
  Fecha_Fin_Contrato__c,
  Sub_Brand__c,
  Territorio__c,
  Pais__c,
  Dias_para_vencer__c,
  fecha_prox_vto_contrato,
  fecha_vto_ultimo_contrato,
  Estado_segun_Contrato
FROM (
  SELECT
    ROW_NUMBER() OVER (PARTITION BY co.AccountId ORDER BY co.LastModifiedDate DESC) AS rn,
    co.Id AS ContratoId,
    AC.Name AS AccountName,
    AC.Tienecontratoactivo__c AS Tiene_contrato_activo,
    co.AccountId AS AccountId,
    AC.email__c AS AccountEmail,
    co.Email_Contacto_Tecnico__c AS Email_Contacto_Tecnico,
    co.Email_Contacto_Comercial__c AS Email_Contacto_Comercial,
    co.StartDate,
    co.EndDate,
    co.BillingCountry,
    co.ShippingCountry,
    co.OwnerId,
    co.Status,
    co.StatusCode,
    co.CreatedDate,
    co.CreatedById,
    co.LastModifiedDate,
    co.LastModifiedById,
    co.Fecha_Fin_Contrato__c,
    co.Sub_Brand__c,
    co.Territorio__c,
    co.Pais__c,
    co.Dias_para_vencer__c,
    AC.Fecha_proximo_vencimiento_contrato__c AS fecha_prox_vto_contrato,
    AC.Fecha_de_vencimiento_de_ltimo_contrato__c AS fecha_vto_ultimo_contrato,
    AC.Estado_seg_n_Contrato__c AS Estado_segun_Contrato
  FROM SFImport_Contrato AS co
  LEFT JOIN SFImport_Accounts_3 AS AC ON co.AccountId = AC.Id
  WHERE AC.email__c IS NOT NULL OR co.Email_Contacto_Tecnico__c IS NOT NULL
    OR co.Email_Contacto_Comercial__c IS NOT NULL
) AS subquery
WHERE rn = 1
/*  (421 rows) */

/* cada AccountId que tenga Fecha_Fin_Contrato__c de fecha más nueva */
SELECT
  ContratoId,
  AccountName,
  Tiene_contrato_activo,
  AccountId,
  AccountEmail,
  Email_Contacto_Tecnico,
  Email_Contacto_Comercial,
  StartDate,
  EndDate,
  BillingCountry,
  ShippingCountry,
  OwnerId,
  Status,
  StatusCode,
  CreatedDate,
  CreatedById,
  LastModifiedDate,
  LastModifiedById,
  Fecha_Fin_Contrato__c,
  Sub_Brand__c,
  Territorio__c,
  Pais__c,
  Dias_para_vencer__c,
  fecha_prox_vto_contrato,
  fecha_vto_ultimo_contrato,
  Estado_segun_Contrato
FROM (
  SELECT
    ROW_NUMBER() OVER (PARTITION BY AccountId ORDER BY Fecha_Fin_Contrato__c DESC) AS rn,
    co.Id AS ContratoId,
    AC.Name AS AccountName,
    AC.Tienecontratoactivo__c AS Tiene_contrato_activo,
    co.AccountId AS AccountId,
    AC.email__c AS AccountEmail,
    co.Email_Contacto_Tecnico__c AS Email_Contacto_Tecnico,
    co.Email_Contacto_Comercial__c AS Email_Contacto_Comercial,
    co.StartDate,
    co.EndDate,
    co.BillingCountry,
    co.ShippingCountry,
    co.OwnerId,
    co.Status,
    co.StatusCode,
    co.CreatedDate,
    co.CreatedById,
    co.LastModifiedDate,
    co.LastModifiedById,
    co.Fecha_Fin_Contrato__c,
    co.Sub_Brand__c,
    co.Territorio__c,
    co.Pais__c,
    co.Dias_para_vencer__c,
    AC.Fecha_proximo_vencimiento_contrato__c AS fecha_prox_vto_contrato,
    AC.Fecha_de_vencimiento_de_ltimo_contrato__c AS fecha_vto_ultimo_contrato,
    AC.Estado_seg_n_Contrato__c AS Estado_segun_Contrato
  FROM SFImport_Contrato AS co
  LEFT JOIN SFImport_Accounts_3 AS AC ON co.AccountId = AC.Id
  WHERE AC.email__c IS NOT NULL OR co.Email_Contacto_Tecnico__c IS NOT NULL
    OR co.Email_Contacto_Comercial__c IS NOT NULL
) AS subquery
WHERE rn = 1
/* (422 rows) */