/*  */
SELECT ac.Id as AccountId, ac.Name as AccountName, ac.Industry as Industry,
co.Name as ContactName, co.Email as ContactEmail,
op.Name as OpportunityName, op.StageName as OpptyStageName, op.Type as OpptyType, 
op.Region__c as OpptyRegion, op.Brand__c as OpptyBrand, op.Area__c as OpptyArea
FROM SFImport_Accounts as ac
LEFT JOIN SFImport_Contacts as co on ac.Id = co.AccountId
LEFT JOIN SFImport_Opportunity as op on ac.Id = op.AccountId
/*  (41257 rows) */

/* email de contacto no null */
SELECT ac.Id as AccountId, ac.Name as AccountName, ac.Industry as Industry,
co.Name as ContactName, co.Email as ContactEmail,
op.Name as OpportunityName, op.StageName as OpptyStageName, op.Type as OpptyType, 
op.Region__c as OpptyRegion, op.Brand__c as OpptyBrand, op.Area__c as OpptyArea
FROM SFImport_Accounts as ac
LEFT JOIN SFImport_Contacts as co on ac.Id = co.AccountId
LEFT JOIN SFImport_Opportunity as op on ac.Id = op.AccountId
WHERE co.Email IS NOT NULL
/* Email no repetido */
SELECT ac.Id as AccountId, ac.Name as AccountName, ac.Industry as Industry,
       MAX(co.Name) as ContactName, co.Email as ContactEmail,
       MAX(co.MailingCountry) as MailingCountry,
       MAX(op.Name) as OpportunityName, MAX(op.StageName) as OpptyStageName, MAX(op.Type) as OpptyType,
       MAX(op.Region__c) as OpptyRegion, MAX(op.Brand__c) as OpptyBrand, MAX(op.Area__c) as OpptyArea
FROM SFImport_Accounts as ac
LEFT JOIN SFImport_Contacts as co on ac.Id = co.AccountId
LEFT JOIN SFImport_Opportunity as op on ac.Id = op.AccountId
WHERE co.Email IS NOT NULL 
GROUP BY co.Email, ac.Id, ac.Name, ac.Industry
/*  (5258 rows) */
SELECT ac.Id as AccountId, ac.Name as AccountName, ac.Industry as Industry,
       MAX(co.Name) as ContactName, co.Email as ContactEmail,
       MAX(co.MailingCountry) as MailingCountry,
       MAX(op.Name) as OpportunityName, MAX(op.StageName) as OpptyStageName, MAX(op.Type) as OpptyType,
       MAX(op.Region__c) as OpptyRegion, MAX(op.Brand__c) as OpptyBrand, MAX(op.Area__c) as OpptyArea
FROM SFImport_Accounts as ac
LEFT JOIN SFImport_Contacts as co on ac.Id = co.AccountId
LEFT JOIN SFImport_Opportunity as op on ac.Id = op.AccountId
WHERE co.Email IS NOT NULL AND (co.MailingCountry IS NOT NULL OR )
GROUP BY co.Email, ac.Id, ac.Name, ac.Industry
/*  */
SELECT ac.Id as AccountId, ac.Name as AccountName, ac.Industry as Industry,
       MAX(co.Name) as ContactName, co.Email as ContactEmail,
       MAX(co.MailingCountry) as MailingCountry,
       MAX(op.Name) as OpportunityName, MAX(op.StageName) as OpptyStageName, MAX(op.Type) as OpptyType,
       MAX(op.Region__c) as OpptyRegion, MAX(op.Brand__c) as OpptyBrand, MAX(op.Area__c) as OpptyArea
FROM SFImport_Accounts as ac
LEFT JOIN SFImport_Contacts as co on ac.Id = co.AccountId
LEFT JOIN SFImport_Opportunity as op on ac.Id = op.AccountId
WHERE co.Email IS NOT NULL 
GROUP BY co.Email, ac.Id, ac.Name, ac.Industry
/* 5259 rows */

/* con SHIPPINGCOUNTRY */
SELECT
  ac.Id as AccountId,
  ac.Name as AccountName,
  ac.Industry as Industry,
  MAX(co.Name) as ContactName,
  co.Email as ContactEmail,
  MAX(co.MailingCountry) as MailingCountry,
  ac.ShippingCountry as ShippingCountry,  
  MAX(op.Name) as OpportunityName,
  MAX(op.StageName) as OpptyStageName,
  MAX(op.Type) as OpptyType,
  MAX(op.Region__c) as OpptyRegion,
  MAX(op.Brand__c) as OpptyBrand,
  MAX(op.Area__c) as OpptyArea
FROM
  SFImport_Accounts as ac
  LEFT JOIN SFImport_Contacts as co ON ac.Id = co.AccountId
  LEFT JOIN SFImport_Opportunity as op ON ac.Id = op.AccountId
WHERE
  co.Email IS NOT NULL
GROUP BY
  co.Email,
  ac.Id,
  ac.Name,
  ac.Industry,
  ac.ShippingCountry
  /* 5259 */








SFImport_Accounts
Id, IsDeleted, MasterRecordId, Name, Type, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingLatitude, ShippingLongitude, ShippingGeocodeAccuracy, ShippingAddress, Phone, Fax, Website, PhotoUrl, Industry, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, IsCustomerPortal, Jigsaw, JigsawCompanyId, AccountSource, SicDesc, Nro_Id_Tributaria__c, Condicion_IVA__c, Razon_Social__c, Identificacion_Tributaria__c, Vendedor__c, Nro_Cliente__c, Capacidad_de_pago__c, Contacto_comercial_SW__c, Contacto_tecnico_SW__c, Contacto_tecnico__c, Contacto_comercial__c, Contacto_generado_por__c, Partner__c, Skype__c, Forma_de_pago__c, Financiacion__c, Exhibition__c, Cantidad_de_cuotas__c, Busqueda_contratos__c, ltima_fecha_de_contacto__c, Vendedor_SW__c, email__c, Exhibicion_de_origen__c, CAS_Utilizado__c, CAD_Otro__c, CAM_Madera_actual__c, CAM_Metal_Actual__c, CAM_Madera_Otro__c, CAM_Metal_Otro__c, CAM_Sheet_Metal_Actual__c, CAM_ShMt_Otro__c, Copia_Origen_de_Cuenta__c, Empleados_Text__c, Comentarios_de_candidato__c, Radan_last_contract_expire__c, Edgecam_last_contract_expire__c, Fecha_proximo_vencimiento_contrato__c, Observaciones__c, Vendedor_Solid__c, Vendedor_Vero_Software__c, Condici_n_de_pago_Provedeedor__c, Alphacam_last_contract_expire__c, SolidWorks_last_contract_expire__c, Cuenta_asignada_a__c, Contacto_Tecnico_DS_BS__c, Contacto_Tecnico_InspecVision__c, Contacto_comercial_DS_BS__c, Contacto_comercial_InspecVision__c, Vendedor_InspecVision__c, Otro_territorio__c, Region__c, Territorio__c, ON_HOLD__c, 
 
SFImport_Contacts
Id, IsDeleted, MasterRecordId, AccountId, LastName, FirstName, Salutation, Name, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry, OtherLatitude, OtherLongitude, OtherGeocodeAccuracy, OtherAddress, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingLatitude, MailingLongitude, MailingGeocodeAccuracy, MailingAddress, Phone, Fax, MobilePhone, HomePhone, OtherPhone, AssistantPhone, ReportsToId, Email, Title, Department, AssistantName, LeadSource, Birthdate, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastCURequestDate, LastCUUpdateDate, LastViewedDate, LastReferencedDate, EmailBouncedReason, EmailBouncedDate, IsEmailBounced, PhotoUrl, Jigsaw, JigsawContactId, IndividualId, Inactivo__c, Estado__c, Correo_adicional_1__c, Correo_adicional_2__c, Skype__c, Cargo__c, Comentarios__c, Technical_Contact_is__c, Funcion_del_Cargo__c, Autoridad_para_compra__c, Extencion_Telefonica__c, LinkedIn__c, et4ae5__HasOptedOutOfMobile__c, et4ae5__Mobile_Country_Code__c, 

SFImport_Lead_2
Id, IsDeleted, MasterRecordId, LastName, FirstName, Salutation, Name, Title, Company, Street, City, State, PostalCode, Country, GeocodeAccuracy, Address, Phone, Email, Website, PhotoUrl, LeadSource, Status, Industry, Rating, AnnualRevenue, NumberOfEmployees, OwnerId, IsConverted, ConvertedDate, ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId, IsUnreadByOwner, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Jigsaw, JigsawContactId, EmailBouncedReason, EmailBouncedDate, IndividualId, IsPriorityRecord, Partner__c, Origen_del_candidato_info__c, Candidato_generado_por__c, Territorio__c, Correo_Electronico_Adicional__c, CADCAM_Actual__c, Technical_Sales__c, Technical_Demo__c, Sub_brand__c, Exhibition__c, ADSK_Inv__c, Fecha_de_interes_curso__c, Curso_de_insteres_candidato__c, Partner_de_origen__c, Funcion_Cargo__c, Numero_empleados_Text__c, Autoridad_para_compra__c, Otro_CAD__c, Producto_de_interes_en_expo__c, Fecha_escaneo_de_candidato__c, Extencion_Telefonica__c, Categorida_de_registacion__c, Otro_CAM_Metal__c, Tecnical_Sales_Autodesk__c, Tecnical_Demo_Autodesk__c, CAM_Madera__c, CAM_Madera_Otro__c, CAD_Actual__c, CAM_Sheet_Metal_Actua__c, CAM_Metal_Actual__c, Cargo_cuenta__c, Brand__c, Comentarios__c, Area__c, CAD_CAM_Corriente__c, et4ae5__HasOptedOutOfMobile__c, et4ae5__Mobile_Country_Code__c, Calificacion__c, LinkedIn__c, Movil__c, Otro_territorio__c, Producto_de_interes__c, Producto__c, SubBrand__c, Region__c, Industria_Texto__c, 

/*  */
SELECT 
    Id, 
    Name, 
    email__c AS Email
FROM SFImport_Accounts
WHERE Name IS NOT NULL AND email__c IS NOT NULL

UNION ALL

SELECT 
    Id, 
    Name, 
    Email
FROM SFImport_Contacts
WHERE Name IS NOT NULL AND Email IS NOT NULL

UNION ALL 

SELECT
    Id,
    Name,
    Email
FROM SFImport_Lead_2
WHERE Name IS NOT NULL AND Email IS NOT NULL

/*  */
/*  */
SELECT
    MAX(DataExtension) AS DataExtension,
    Id,
    Name,
    Email
FROM
(
    SELECT 
        'SFImport_Accounts' AS DataExtension,
        Id, 
        Name, 
        email__c AS Email
    FROM SFImport_Accounts
    WHERE Name IS NOT NULL AND email__c IS NOT NULL

    UNION ALL

    SELECT 
        'SFImport_Contacts' AS DataExtension,
        Id, 
        Name, 
        Email
    FROM SFImport_Contacts
    WHERE Name IS NOT NULL AND Email IS NOT NULL

    UNION ALL 

    SELECT
        'SFImport_Lead_2' AS DataExtension,
        Id,
        Name,
        Email
    FROM SFImport_Lead_2
    WHERE Name IS NOT NULL AND Email IS NOT NULL
) AS UnifiedData
GROUP BY Email, Id, Name

/* (8045 rows) algunos duplicados  */
/*  */
SELECT
    DataExtension,
    Id,
    Name,
    Email
FROM
(
    SELECT
        'SFImport_Accounts' AS DataExtension,
        Id,
        Name,
        email__c AS Email,
        ROW_NUMBER() OVER (PARTITION BY email__c ORDER BY Id) AS RowNum
    FROM SFImport_Accounts
    WHERE Name IS NOT NULL AND email__c IS NOT NULL

    UNION ALL

    SELECT
        'SFImport_Contacts' AS DataExtension,
        Id,
        Name,
        Email,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS RowNum
    FROM SFImport_Contacts
    WHERE Name IS NOT NULL AND Email IS NOT NULL

    UNION ALL

    SELECT
        'SFImport_Lead_2' AS DataExtension,
        Id,
        Name,
        Email,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS RowNum
    FROM SFImport_Lead_2
    WHERE Name IS NOT NULL AND Email IS NOT NULL
) AS UnifiedData
WHERE RowNum = 1

/* (7645 rows) */

/*  */
UNION
SELECT
    bb.Id,
    bb.Name,
    bb.Email,
    'SFImport_Contacts' AS DataExtension
FROM SFImport_Contacts bb
WHERE bb.Email IS NOT NULL
UNION
SELECT
    bc.Id,
    bc.Name,
    bc.Email,
    'SFImport_Lead_2' AS DataExtension
FROM SFImport_Lead_2 bc
WHERE bc.Email IS NOT NULL
/*  */