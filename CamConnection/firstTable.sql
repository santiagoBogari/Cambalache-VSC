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