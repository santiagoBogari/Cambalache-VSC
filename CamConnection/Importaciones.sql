SELECT *
FROM [SFImport_Contacts]

----

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

/* DE 'Results emails unicos Contrato'  */