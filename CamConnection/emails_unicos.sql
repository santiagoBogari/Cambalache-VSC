SELECT
   Id,
    Name,
    Email,DataExtension
FROM
(
    SELECT
        Id,
        Name,
        email__c AS Email,
        'SFImport_Accounts_2' AS DataExtension,
        ROW_NUMBER() OVER (PARTITION BY email__c ORDER BY Id) AS RowNum
    FROM SFImport_Accounts_2
    WHERE Name IS NOT NULL AND email__c IS NOT NULL
    
    UNION ALL
    
    SELECT
        Id,
        Name,
        Email,
        'SFImport_Contacts' AS DataExtension,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS RowNum
    FROM SFImport_Contacts
    WHERE Name IS NOT NULL AND Email IS NOT NULL
    
    UNION ALL
    
    SELECT
        Id,
        Name,
        Email,
        'SFImport_Lead_2' AS DataExtension,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS RowNum
    FROM SFImport_Lead_2
    WHERE Name IS NOT NULL AND Email IS NOT NULL
) AS UnifiedData
WHERE RowNum = 1

/* (DE  Emails_Account_Contact_Lead   7814 rows) */

