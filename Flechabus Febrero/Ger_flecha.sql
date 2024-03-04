/*  */

SELECT DISTINCT a.id,
       a.PersonContactId,
       a.Name AS Nombre,
       a.FirstName,
       a.LastName,
       a.Type AS Tipo,
       a.RecordTypeId,
       a.Phone AS Telefono,
       a.OwnerID,
       a.CreatedDate AS Fecha_Creacion,
       a.AccountSource AS Origen_Cuenta,
       a.Tipo_de_Documento__PC AS tipo_documento,
       a.Nro_Documento__pc,
       a.ID_Pasajero__PC,
       a.Id_del_pasajero__c,
       a.Fecha_de_Nacimiento__c,
       a.PersonBirthDate,
       a.Email__c,
       a.PersonEmail,
       a.Phone
FROM SFImport_Account AS a
INNER JOIN (
  SELECT DISTINCT *
  FROM SFImport_Boletos
  WHERE Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')
) AS b
  ON b.Id_Pasajero_Salesforce__c = a.Id
WHERE a.PersonEmail IS NOT NULL
  AND a.IsPersonAccount = '1'

  /* (65634 rows)  */

  SELECT DISTINCT a.id,  
       a.PersonContactId,
       a.Name AS Nombre,    
       a.FirstName,
       a.LastName,
       a.Type AS Tipo,
       a.RecordTypeId,
       a.Phone AS Telefono,    
       a.OwnerID, 
       a.CreatedDate AS Fecha_Creacion,
       a.AccountSource AS Origen_Cuenta,
       a.Tipo_de_Documento__PC AS tipo_documento,
       a.Nro_Documento__pc,  
       a.ID_Pasajero__PC,
       a.Id_del_pasajero__c,
       a.Fecha_de_Nacimiento__c,     
       a.PersonBirthDate,
       a.Email__c,
       a.PersonEmail,    
       a.Phone
FROM SFImport_Account AS a 
LEFT JOIN (
  SELECT DISTINCT *
  FROM SFImport_Boletos
  WHERE Empresa_Venta__c IN ('Chevallier','Flechabus','Urquiza','La Veloz')
) AS boletos
  ON boletos.Id_Pasajero_Salesforce__c = a.Id  
INNER JOIN _subscribers AS s
  ON s.subscriberid = a.id
LEFT JOIN _bounce AS bounce
  ON bounce.subscriberid = a.id
WHERE a.PersonEmail IS NOT NULL
  AND a.IsPersonAccount = '1'
  AND s.status NOT IN ('Held','Bounce','Unsubscribed')
  AND bounce.subscriberid IS NULL

  -- error
  -- Query failed during execution. Error: Conversion failed when converting the nvarchar value '001Dn00000RG7jdIAD' to data type int.