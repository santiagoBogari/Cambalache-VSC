SELECT 
Id, AccountId, OwnerExpirationNotice, StartDate, EndDate, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingGeocodeAccuracy, ShippingAddress, ContractTerm, OwnerId, Status, CompanySignedId, CompanySignedDate, CustomerSignedId, CustomerSignedTitle, CustomerSignedDate, SpecialTerms, ActivatedById, ActivatedDate, StatusCode, IsDeleted, ContractNumber, LastApprovedDate, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Fecha_Fin_Contrato__c, Estado_del_Contrato__c, Cantidad_de_Horas_Tecnicas__c, Email_Contacto_Tecnico__c, Email_Contacto_Comercial__c, Trato_a_Contactos__c, Autodesk_Nro_Contrato__c, Refrescar__c, contrato_extendido__c, Sub_Brand__c, test_envio__c, Vence_en_dias__c, Restan_dias__c, Email_Contacto_Tecnico_Autodesk__c, Is_a_Radan_Contract__c, Is_an_Edgecam_Contract__c, Refrescar_Expiracion_en_Cuenta__c, Aviso_de_vencimiento_Radan_a_7_dias__c, Aviso_de_vencimiento_Radan_a_30_dias__c, Aviso_de_vencimiento_Edgecam_a_30_dias__c, Aviso_de_vencimiento_Edgecam_a_7_dias__c, Fecha_1_er_llamado__c, Fecha_2_do_llamado__c, Fecha_3_er_llamado__c, Territorio__c, Pais__c, Dias_para_vencer__c, Fecha_4_to_llamado__c, Aviso_de_vencimiento_Edgecam_a_60_dias__c, Aviso_de_vencimiento_Radan_a_60_dias__c, Is_a_SolidWorks_Contract__c, Is_an_Alphacam_Contract__c, Aviso_de_vencimiento_SW_a_30_dias__c, Aviso_de_vencimiento_SW_a_7_dias__c, Aviso_de_vencimiento_Alphacam_a_60_dias__c, Aviso_de_vencimiento_Alphacam_a_30_dias__c, Aviso_de_vencimiento_Alphacam_a_7_dias__c, Aviso_de_vencimiento_Edgecam_a_90_dias__c, Aviso_de_vencimiento_Alphacam_a_90_dias__c, Aviso_de_vencimiento_Radan_a_90_dias__c, Info_1er_llamado__c, Info_2do_llamado__c, Info_3er_llamado__c, Info_4to_llamado__c, Estado_1er_llamado__c, Estado_2do_llamado__c, Estado_3er_llamado__c, Estado_4to_llamado__c, Area__c, Finalizacion_en_30_dias__c, Finalizacion_en_60_dias__c, Finalizacion_en_7_dias__c, Finalizacion_en_90_dias__c, Finalizacion_pasados_7_dias__c, Oportunidad__c, Otro_territorio__c, Brand__c, Producto__c, SubBrand__c, FromName__c
FROM
SFImport_Contrato as Contrato
LEFT JOIN SFImport_Accounts as AC on Contrato.AccountId = AC.Id


/* campos contrato */
Id, AccountId, OwnerExpirationNotice, StartDate, EndDate, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingGeocodeAccuracy, ShippingAddress, ContractTerm, OwnerId, Status, CompanySignedId, CompanySignedDate, CustomerSignedId, CustomerSignedTitle, CustomerSignedDate, SpecialTerms, ActivatedById, ActivatedDate, StatusCode, IsDeleted, ContractNumber, LastApprovedDate, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Fecha_Fin_Contrato__c, Estado_del_Contrato__c, Cantidad_de_Horas_Tecnicas__c, Email_Contacto_Tecnico__c, Email_Contacto_Comercial__c, Trato_a_Contactos__c, Autodesk_Nro_Contrato__c, Refrescar__c, contrato_extendido__c, Sub_Brand__c, test_envio__c, Vence_en_dias__c, Restan_dias__c, Email_Contacto_Tecnico_Autodesk__c, Is_a_Radan_Contract__c, Is_an_Edgecam_Contract__c, Refrescar_Expiracion_en_Cuenta__c, Aviso_de_vencimiento_Radan_a_7_dias__c, Aviso_de_vencimiento_Radan_a_30_dias__c, Aviso_de_vencimiento_Edgecam_a_30_dias__c, Aviso_de_vencimiento_Edgecam_a_7_dias__c, Fecha_1_er_llamado__c, Fecha_2_do_llamado__c, Fecha_3_er_llamado__c, Territorio__c, Pais__c, Dias_para_vencer__c, Fecha_4_to_llamado__c, Aviso_de_vencimiento_Edgecam_a_60_dias__c, Aviso_de_vencimiento_Radan_a_60_dias__c, Is_a_SolidWorks_Contract__c, Is_an_Alphacam_Contract__c, Aviso_de_vencimiento_SW_a_30_dias__c, Aviso_de_vencimiento_SW_a_7_dias__c, Aviso_de_vencimiento_Alphacam_a_60_dias__c, Aviso_de_vencimiento_Alphacam_a_30_dias__c, Aviso_de_vencimiento_Alphacam_a_7_dias__c, Aviso_de_vencimiento_Edgecam_a_90_dias__c, Aviso_de_vencimiento_Alphacam_a_90_dias__c, Aviso_de_vencimiento_Radan_a_90_dias__c, Info_1er_llamado__c, Info_2do_llamado__c, Info_3er_llamado__c, Info_4to_llamado__c, Estado_1er_llamado__c, Estado_2do_llamado__c, Estado_3er_llamado__c, Estado_4to_llamado__c, Area__c, Finalizacion_en_30_dias__c, Finalizacion_en_60_dias__c, Finalizacion_en_7_dias__c, Finalizacion_en_90_dias__c, Finalizacion_pasados_7_dias__c, Oportunidad__c, Otro_territorio__c, Brand__c, Producto__c, SubBrand__c, FromName__c

/*  */

SELECT  
co.Id, AC.Name, co.AccountId, AC.email__c, co.Email_Contacto_Tecnico__c, co.Email_Contacto_Comercial__c, co.OwnerExpirationNotice, co.StartDate, co.EndDate, co.BillingStreet, co.BillingCity, co.BillingState, co.BillingPostalCode, co.BillingCountry, co.BillingGeocodeAccuracy, co.BillingAddress, co.ShippingStreet, co.ShippingCity, co.ShippingState, co.ShippingPostalCode, co.ShippingCountry, co.ShippingGeocodeAccuracy, co.ShippingAddress, co.ContractTerm, co.OwnerId, co.Status, co.CompanySignedId, co.CompanySignedDate, co.CustomerSignedId, co.CustomerSignedTitle, co.CustomerSignedDate, co.SpecialTerms, co.ActivatedById, co.ActivatedDate, co.StatusCode, co.IsDeleted, co.ContractNumber, co.LastApprovedDate, co.CreatedDate, co.CreatedById, co.LastModifiedDate, co.LastModifiedById, co.SystemModstamp, co.LastActivityDate, co.LastViewedDate, co.LastReferencedDate, co.Fecha_Fin_Contrato__c, co.Estado_del_Contrato__c, co.Cantidad_de_Horas_Tecnicas__c, co.Trato_a_Contactos__c, co.Autodesk_Nro_Contrato__c, co.Refrescar__c, co.contrato_extendido__c, co.Sub_Brand__c, co.test_envio__c, co.Vence_en_dias__c, co.Restan_dias__c, co.Email_Contacto_Tecnico_Autodesk__c, co.Is_a_Radan_Contract__c, co.Is_an_Edgecam_Contract__c, co.Refrescar_Expiracion_en_Cuenta__c, co.Aviso_de_vencimiento_Radan_a_7_dias__c, co.Aviso_de_vencimiento_Radan_a_30_dias__c, co.Aviso_de_vencimiento_Edgecam_a_30_dias__c, co.Aviso_de_vencimiento_Edgecam_a_7_dias__c, co.Fecha_1_er_llamado__c, co.Fecha_2_do_llamado__c, co.Fecha_3_er_llamado__c, co.Territorio__c, co.Pais__c, co.Dias_para_vencer__c, co.Fecha_4_to_llamado__c, co.Aviso_de_vencimiento_Edgecam_a_60_dias__c, co.Aviso_de_vencimiento_Radan_a_60_dias__c, co.Is_a_SolidWorks_Contract__c, co.Is_an_Alphacam_Contract__c, co.Aviso_de_vencimiento_SW_a_30_dias__c, co.Aviso_de_vencimiento_SW_a_7_dias__c, co.Aviso_de_vencimiento_Alphacam_a_60_dias__c, co.Aviso_de_vencimiento_Alphacam_a_30_dias__c, co.Aviso_de_vencimiento_Alphacam_a_7_dias__c, co.Aviso_de_vencimiento_Edgecam_a_90_dias__c, co.Aviso_de_vencimiento_Alphacam_a_90_dias__c, co.Aviso_de_vencimiento_Radan_a_90_dias__c, co.Info_1er_llamado__c, co.Info_2do_llamado__c, co.Info_3er_llamado__c, co.Info_4to_llamado__c, co.Estado_1er_llamado__c, co.Estado_2do_llamado__c, co.Estado_3er_llamado__c, co.Estado_4to_llamado__c, co.Area__c, co.Finalizacion_en_30_dias__c, co.Finalizacion_en_60_dias__c, co.Finalizacion_en_7_dias__c, co.Finalizacion_en_90_dias__c, co.Finalizacion_pasados_7_dias__c, co.Oportunidad__c, co.Otro_territorio__c, co.Brand__c, co.Producto__c, co.SubBrand__c, co.FromName__c
FROM
SFImport_Contrato as co
LEFT JOIN SFImport_Accounts as AC on co.AccountId = AC.Id
WHERE AC.email__c IS NOT NULL or co.Email_Contacto_Tecnico__c IS NOT NULL or co.Email_Contacto_Comercial__c IS NOT NULL

/* una columna que unifica las 3 de emails en Contrato */

SELECT
  EmailAddress,
  Id,
  Name,
  AccountId,
  Pais__c,
  ShippingCountry,
  BillingCountry,
  Brand__c,
  Producto__c
FROM
(
  SELECT
    CombinedEmails.EmailAddress,
    co.Id,
    AC.Name,
    co.AccountId,
    co.Pais__c,
    co.ShippingCountry,
    co.BillingCountry,
    co.Brand__c,
    co.Producto__c,
    ROW_NUMBER() OVER (PARTITION BY CombinedEmails.EmailAddress ORDER BY co.Id) AS RowNum
  FROM
  (
    SELECT AC.email__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
    UNION
    SELECT co.Email_Contacto_Tecnico__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
    UNION
    SELECT co.Email_Contacto_Comercial__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
  ) AS CombinedEmails
  LEFT JOIN SFImport_Contrato AS co ON CombinedEmails.EmailAddress = co.Email_Contacto_Tecnico__c OR CombinedEmails.EmailAddress = co.Email_Contacto_Comercial__c
  LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
  WHERE CombinedEmails.EmailAddress IS NOT NULL
) AS RankedEmails
WHERE RowNum = 1

/* 776 rows */

/* Mexico */
SELECT
  EmailAddress,
  Id,
  Name,
  AccountId,
  Pais__c,
  ShippingCountry,
  BillingCountry,
  Brand__c,
  Producto__c
FROM
(
  SELECT
    CombinedEmails.EmailAddress,
    co.Id,
    AC.Name,
    co.AccountId,
    co.Pais__c,
    co.ShippingCountry,
    co.BillingCountry,
    co.Brand__c,
    co.Producto__c,
    ROW_NUMBER() OVER (PARTITION BY CombinedEmails.EmailAddress ORDER BY co.Id) AS RowNum
  FROM
  (
    SELECT AC.email__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
    UNION
    SELECT co.Email_Contacto_Tecnico__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
    UNION
    SELECT co.Email_Contacto_Comercial__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
  ) AS CombinedEmails
  LEFT JOIN SFImport_Contrato AS co ON CombinedEmails.EmailAddress = co.Email_Contacto_Tecnico__c OR CombinedEmails.EmailAddress = co.Email_Contacto_Comercial__c
  LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
  WHERE CombinedEmails.EmailAddress IS NOT NULL
) AS RankedEmails
WHERE RowNum = 1 AND (Pais__c = 'México' OR Pais__c = 'Mexico' OR Pais__c = 'MEXICO' OR ShippingCountry = 'México' OR ShippingCountry = 'Mexico' OR ShippingCountry = 'MEXICO' OR BillingCountry = 'México' OR BillingCountry = 'Mexico' OR BillingCountry = 'MEXICO')

/* 139 rows */

/*Query de la Automation   */
/*Unifica las columnas de email de Contrato para realizar envíos sin duplicados */

SELECT
EmailAddress,
Id,
Name,
AccountId,
Pais__c,
ShippingCountry,
BillingCountry,
Brand__c,
Producto__c
FROM
(
SELECT
CombinedEmails.EmailAddress,
co.Id,
AC.Name,
co.AccountId,
co.Pais__c,
co.ShippingCountry,
co.BillingCountry,
co.Brand__c,
co.Producto__c,
ROW_NUMBER() OVER (PARTITION BY CombinedEmails.EmailAddress ORDER BY co.Id) AS RowNum
FROM
(
SELECT AC.email__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
UNION
SELECT co.Email_Contacto_Tecnico__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
UNION
SELECT co.Email_Contacto_Comercial__c AS EmailAddress FROM SFImport_Contrato AS co LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
) AS CombinedEmails
LEFT JOIN SFImport_Contrato AS co ON CombinedEmails.EmailAddress = co.Email_Contacto_Tecnico__c OR CombinedEmails.EmailAddress = co.Email_Contacto_Comercial__c
LEFT JOIN SFImport_Accounts AS AC ON co.AccountId = AC.Id
WHERE CombinedEmails.EmailAddress IS NOT NULL
) AS RankedEmails
WHERE RowNum = 1

/* DE Results emails unicos Contrato (798 rows)*/

/*  */

SELECT  
co.Id as ContratoId, 
AC.Name as AccountName,
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
co.Territorio__c, co.Pais__c, co.Dias_para_vencer__c

FROM SFImport_Contrato as co
LEFT JOIN SFImport_Accounts as AC on co.AccountId = AC.Id
WHERE AC.email__c IS NOT NULL or co.Email_Contacto_Tecnico__c IS NOT NULL 
or co.Email_Contacto_Comercial__c IS NOT NULL

/*  (1800 rows)  */

/* con campo Tiene_contrato_activo__c */
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

/* (1854 rows) */