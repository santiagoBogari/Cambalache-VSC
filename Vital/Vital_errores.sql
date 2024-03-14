/* registros en la Data Extension 'SF_Import_Accounts_7' que no existen en la Data Extension 'SF_Import_Accounts_5' */

SELECT 
    IA7.id,
    IA7.Name,
    IA7.Phone,
    IA7.PersonMobilePhone,
    IA7.PersonHomePhone,
    IA7.PersonOtherPhone,
    IA7.PersonAssistantPhone,
    IA7.PersonEmail,
    IA7.Email__c,
    IA7.Activa__c,
    IA7.OwnerId
FROM SF_Import_Accounts_7 AS IA7
LEFT JOIN SF_Import_Accounts_5 AS IA5 ON IA7.id = IA5.id
WHERE IA5.id IS NULL and (IA7.Phone IS NOT NULL)

-- (236 rows) DE Phones_con_error -- Data Extensions / Test / Phones_con_error