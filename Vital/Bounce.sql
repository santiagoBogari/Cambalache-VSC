/* 27-2-2024 BOUNCE (condiciones de exclusión) quitar todos los Bounce !=  SOFT BOUNCE = mailbox full , EventDate > 15 dias
  Data Extensions / Sendlog_and_DataViews / Bounce     72.337 records   */

SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  Bounce
WHERE BounceCategory = 'Soft bounce' AND EventDate > 15

-- (37977 rows)

/*  */
SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  Bounce
WHERE BounceCategory = 'Soft bounce' AND DATEDIFF(day, EventDate, GETDATE()) > 15

-- (31383 rows)

/*  */

SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  Bounce
WHERE BounceSubcategory != 'Mailbox Full' AND DATEDIFF(day, EventDate, GETDATE()) > 15

--  (35138 rows)

/*  */

SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  Bounce
WHERE BounceSubcategory != 'Mailbox Full' AND EventDate > 15

-- (35768 rows)

/*  */
SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  BOUNCE
WHERE
  NOT (BounceSubcategory = 'Mailbox Full' AND DATEDIFF(day, DATEADD(day, 15, EventDate), GETDATE()) >= 0)

  -- (42316 rows)

  /*  */

  SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  QueryStudioResultsat20240227T1743000000
WHERE
  BounceSubcategory = 'Mailbox Full' 

  --  (6548 rows)

SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  BOUNCE
WHERE
  NOT (BounceSubcategory = 'Mailbox Full' AND (EventDate + 15) < GETDATE())
  -- (42316 rows)

  /*  */
  SELECT 
  BounceTypeID,
  TriggererSendDefinitionObjectID,
  IsUnique,
  BounceSubcategory,
  TriggeredSendCustomerKey,
  BounceCategory,
  SubscriberID,
  BounceType,
  Domain,
  IsFalseBounce,
  AccountID,
  OYBAccountID,
  BounceCategoryID,
  EventDate,
  ListID,
  BounceSubcategoryID,
  BatchID,
  SMTPCode,
  SubscriberKey,
  JobID
FROM
  BOUNCE
WHERE
  (BounceSubcategory = 'Mailbox Full' AND (EventDate + 15) < GETDATE())

  -- (30021 rows)

  /* query de la automation 'Personas Sync' que popula personas 
  
  */
  select
AC.id,
AC.PersonIndividualId AS PersonIndividualId,
AC.PersonContactId AS PersonContactId,
AC.Name as Name,
AC.PersonTitle AS PersonTitle,
AC.LastName AS Apellido,
AC.FirstName AS Nombre,
AC.IsPersonAccount AS IsPersonAccount,
AC.PersonDepartment AS PersonDepartment,
AC.PersonLeadSource AS PersonLeadSource,
AC.PersonEmail AS PersonEmail,
AC.PersonBirthdate AS PersonBirthdate,
AC.PersonMobilePhone AS PersonMobilePhone,
AC.PersonHomePhone AS PersonHomePhone,
AC.PersonOtherPhone AS PersonOtherPhone,
AC.PersonAssistantPhone AS PersonAssistantPhone,
AC.Type as Tipo,
AC.RecordTypeId,
rt.Name as Tipo_Cliente,
AC.ParentId,
AC.OwnerID,
AC.CreatedDate as Fecha_Creacion,
AC.AccountSource as Origen_Cuenta,
AC.Razon_social__c as Razon_Social,
AC.CUIT__c as CUIT,
case
when AC.Rubro__c = '9' then 'Almacen'
when AC.Rubro__c = '12' then 'Autoservicio'
when AC.Rubro__c = '35' then 'Comisionista'
when AC.Rubro__c = '95' then 'Cultivo / Tabaco'
when AC.Rubro__c = '30' then 'Empresa'
when AC.Rubro__c = '40' then 'Escuela'
when AC.Rubro__c = '48' then 'Farmacia'
when AC.Rubro__c = '45' then 'Ferreteria'
when AC.Rubro__c = '80' then 'Gastronomico'
when AC.Rubro__c = '50' then 'Geriatrico'
when AC.Rubro__c = '60' then 'Hospital / Sanatorio'
when AC.Rubro__c = '70' then 'Mayorista / Disctribuidor'
when AC.Rubro__c = '75' then 'ONG'
when AC.Rubro__c = '20' then 'Perfumeria y Art de Limpieza'
when AC.Rubro__c = '90' then 'Productor Agropecuario'
when AC.Rubro__c = '55' then 'Profesional'
when AC.Rubro__c = '85' then 'Otro'
else ''
end as Rubro1,
AC.Cantidad_de_Empleados__c as Cant_Empleados,
AC.Frecuencia__c as Frecuencia,
SUC.Name as Sucursal,
case
when AC.Condicion_de_IVA__c = '1' then 'Responsable Inscripto'
when AC.Condicion_de_IVA__c = '2' then 'Consumidor Final'
when AC.Condicion_de_IVA__c = '3' then 'Iva No responsable'
when AC.Condicion_de_IVA__c = '4' then 'Exento'
when AC.Condicion_de_IVA__c = '5' then 'Responsable Monotributo'
when AC.Condicion_de_IVA__c = '7' then 'Monotributo-Contribuyente Eventual'
when AC.Condicion_de_IVA__c = '8' then 'IVA no alcanzado'
else ''
end as Cond_Iva,
AC.Fecha_Ultima_Compra__c as Fecha_Ult_Compra,
P.Name as Pais,
PROV.Name as Provincia,
LOC.Name as Localidad,
CP.Name as Codigo_Postal,
AC.Calle__c as Calle,
AC.Altura__c as Altura,
AC.Id_Top_Group_texto__c as Id_Topgroup,
AC.Tipo_Registro_de_Cuenta__pc as Tipo_Reg_Cuenta,
AC.Rubro__pc as Rubro,
AC.Empleados_de_la_Compa_a__pc as Empleados_de_la_Compra,
AC.Industria_de_la_Compa_a__pc as Industria_de_la_Compra


from SFImport_Accounts_4 as AC
INNER JOIN RecordType AS rt ON rt.Id = AC.RecordTypeId
left join SFImport_Pais as P on AC.Pais__c = P.Id
left join SFImport_Provincia as PROV on AC.Provincia__c = PROV.Id
left join SFImport_Localidad as LOC on AC.Localidad__c = LOC.Id
left join SFImport_Codigo_Postal as CP on AC.Codigo_Postal__c = CP.Id
LEFT JOIN SFSucursal_Import_2 as SUC on SUC.id_top_group__c = (AC.Sucursal__c + '.0')
LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = AC.PersonEmail
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = AC.PersonEmail
where 
u1bm.Email IS NULL AND 
ubh.EmailAddress IS NULL AND
IsPersonAccount = '1'

-- (699028 rows)