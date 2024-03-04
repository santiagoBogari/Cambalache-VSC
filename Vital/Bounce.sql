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
  -- (42316 rows)  QueryStudioResultsat20240301T1131010000

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

-- (699.028 rows)


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
AND NOT EXISTS (
    SELECT 1
    FROM BOUNCE
    WHERE BOUNCE.SubscriberKey = AC.Id
        AND (BOUNCE.BounceSubcategory = 'Mailbox Full'
        AND (BOUNCE.EventDate + 15) >= GETDATE())
)
-- (696.473 rows)

/* obtener un row por subscriberKey en Bounce */
 
SELECT
    B1.BounceTypeID,
    B1.TriggererSendDefinitionObjectID,
    B1.IsUnique,
    B1.BounceSubcategory,
    B1.TriggeredSendCustomerKey,
    B1.BounceCategory,
    B1.SubscriberID,
    B1.BounceType,
    B1.Domain,
    B1.IsFalseBounce,
    B1.AccountID,
    B1.OYBAccountID,
    B1.BounceCategoryID,
    B1.EventDate,
    B1.ListID,
    B1.BounceSubcategoryID,
    B1.BatchID,
    B1.SMTPCode,
    B1.SubscriberKey,
    B1.JobID
FROM
    BOUNCE AS B1
LEFT JOIN BOUNCE AS B2 ON
    B1.SubscriberKey = B2.SubscriberKey AND
    B1.EventDate < B2.EventDate
WHERE
    B2.SubscriberKey IS NULL AND
    NOT (B1.BounceSubcategory = 'Mailbox Full' AND (B1.EventDate + 15) < GETDATE())

-- (36690 rows)


-- QueryStudioResultsat20240229T1221080000   696.473
-- QueryStudioResultsat20240227T1920070000    42.316
-- QueryStudioResultsat20240229T1733010000   690.777

SELECT QS1.SubscriberKey
FROM QueryStudioResultsat20240227T1920070000 AS QS1
LEFT JOIN QueryStudioResultsat20240229T1221080000 AS QS2
ON QS1.SubscriberKey = QS2.Id
WHERE QS2.Id IS NULL
--(37559 rows)
SELECT QS1.SubscriberKey
FROM QueryStudioResultsat20240227T1920070000 AS QS1
WHERE NOT EXISTS (
  SELECT 1
  FROM QueryStudioResultsat20240229T1221080000 AS QS2
  WHERE QS2.Id = QS1.SubscriberKey
)
--(37559 rows)
SELECT QS1.SubscriberKey
FROM QueryStudioResultsat20240227T1920070000 AS QS1
LEFT JOIN QueryStudioResultsat20240229T1221080000 AS QS2
ON QS1.SubscriberKey = QS2.Id
WHERE QS2.Id IS NULL
--(37559 rows)

/*  */
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
 AND NOT EXISTS (
    SELECT 1
    FROM BOUNCE
    WHERE BOUNCE.SubscriberKey = AC.Id
        AND NOT(BOUNCE.BounceSubcategory = 'Mailbox Full'
        AND (BOUNCE.EventDate + 15) >= GETDATE())
)

-- (691.149 rows)  QueryStudioResultsat20240301T1037490000

/* 001Dn00000hQ7JEIA0	 2024-02-02 05:17:27.960	 	Soft bounce		Mailbox Full */
/* no está en QueryStudioResultsat20240229T1733010000 */

/* 001Dn00000R5pOlIAJ	. 2024-02-27 05:30:30.523   Soft bounce		Mailbox Full */
/* si está en QueryStudioResultsat20240229T1733010000 */ 

/* con NOT */
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
LEFT JOIN BOUNCE ON BOUNCE.SubscriberKey = AC.Id
        AND NOT(BOUNCE.BounceSubcategory = 'Mailbox Full' AND (BOUNCE.EventDate + 15) >= GETDATE())
WHERE
    u1bm.Email IS NULL
    AND ubh.EmailAddress IS NULL
    AND IsPersonAccount = '1'
    AND BOUNCE.SubscriberKey IS NULL
--(690.777 rows)  QueryStudioResultsat20240229T1845510000

/* sin NOT */
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
LEFT JOIN BOUNCE ON BOUNCE.SubscriberKey = AC.Id
        AND (BOUNCE.BounceSubcategory = 'Mailbox Full' AND (BOUNCE.EventDate + 15) >= GETDATE())
WHERE
    u1bm.Email IS NULL
    AND ubh.EmailAddress IS NULL
    AND IsPersonAccount = '1'
    AND BOUNCE.SubscriberKey IS NULL

--(696475 rows)  QueryStudioResultsat20240229T2142580000

/* cambio de < */
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
 AND NOT EXISTS (
    SELECT 1
    FROM BOUNCE
    WHERE BOUNCE.SubscriberKey = AC.Id
        AND NOT(BOUNCE.BounceSubcategory = 'Mailbox Full'
        AND (BOUNCE.EventDate + 15) <= GETDATE())
)
-- (693134 rows)  QueryStudioResultsat20240301T0105060000

/*  */
SELECT
    AC.id,
    AC.PersonIndividualId AS PersonIndividualId,
    AC.PersonContactId AS PersonContactId,
    AC.Name AS Name,
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
    AC.Type AS Tipo,
    AC.RecordTypeId,
    rt.Name AS Tipo_Cliente,
    AC.ParentId,
    AC.OwnerID,
    AC.CreatedDate AS Fecha_Creacion,
    AC.AccountSource AS Origen_Cuenta,
    AC.Razon_social__c AS Razon_Social,
    AC.CUIT__c AS CUIT,
    CASE
        WHEN AC.Rubro__c = '9' THEN 'Almacen'
        WHEN AC.Rubro__c = '12' THEN 'Autoservicio'
        WHEN AC.Rubro__c = '35' THEN 'Comisionista'
        WHEN AC.Rubro__c = '95' THEN 'Cultivo / Tabaco'
        WHEN AC.Rubro__c = '30' THEN 'Empresa'
        WHEN AC.Rubro__c = '40' THEN 'Escuela'
        WHEN AC.Rubro__c = '48' THEN 'Farmacia'
        WHEN AC.Rubro__c = '45' THEN 'Ferreteria'
        WHEN AC.Rubro__c = '80' THEN 'Gastronomico'
        WHEN AC.Rubro__c = '50' THEN 'Geriatrico'
        WHEN AC.Rubro__c = '60' THEN 'Hospital / Sanatorio'
        WHEN AC.Rubro__c = '70' THEN 'Mayorista / Disctribuidor'
        WHEN AC.Rubro__c = '75' THEN 'ONG'
        WHEN AC.Rubro__c = '20' THEN 'Perfumeria y Art de Limpieza'
        WHEN AC.Rubro__c = '90' THEN 'Productor Agropecuario'
        WHEN AC.Rubro__c = '55' THEN 'Profesional'
        WHEN AC.Rubro__c = '85' THEN 'Otro'
        ELSE ''
    END AS Rubro1,
    AC.Cantidad_de_Empleados__c AS Cant_Empleados,
    AC.Frecuencia__c AS Frecuencia,
    SUC.Name AS Sucursal,
    CASE
        WHEN AC.Condicion_de_IVA__c = '1' THEN 'Responsable Inscripto'
        WHEN AC.Condicion_de_IVA__c = '2' THEN 'Consumidor Final'
        WHEN AC.Condicion_de_IVA__c = '3' THEN 'Iva No responsable'
        WHEN AC.Condicion_de_IVA__c = '4' THEN 'Exento'
        WHEN AC.Condicion_de_IVA__c = '5' THEN 'Responsable Monotributo'
        WHEN AC.Condicion_de_IVA__c = '7' THEN 'Monotributo-Contribuyente Eventual'
        WHEN AC.Condicion_de_IVA__c = '8' THEN 'IVA no alcanzado'
        ELSE ''
    END AS Cond_Iva,
    AC.Fecha_Ultima_Compra__c AS Fecha_Ult_Compra,
    P.Name AS Pais,
    PROV.Name AS Provincia,
    LOC.Name AS Localidad,
    CP.Name AS Codigo_Postal,
    AC.Calle__c AS Calle,
    AC.Altura__c AS Altura,
    AC.Id_Top_Group_texto__c AS Id_Topgroup,
    AC.Tipo_Registro_de_Cuenta__pc AS Tipo_Reg_Cuenta,
    AC.Rubro__pc AS Rubro,
    AC.Empleados_de_la_Compa_a__pc AS Empleados_de_la_Compra,
    AC.Industria_de_la_Compa_a__pc AS Industria_de_la_Compra
FROM
    SFImport_Accounts_4 AS AC
INNER JOIN RecordType AS rt ON rt.Id = AC.RecordTypeId
LEFT JOIN SFImport_Pais AS P ON AC.Pais__c = P.Id
LEFT JOIN SFImport_Provincia AS PROV ON AC.Provincia__c = PROV.Id
LEFT JOIN SFImport_Localidad AS LOC ON AC.Localidad__c = LOC.Id
LEFT JOIN SFImport_Codigo_Postal AS CP ON AC.Codigo_Postal__c = CP.Id
LEFT JOIN SFSucursal_Import_2 AS SUC ON SUC.id_top_group__c = (AC.Sucursal__c + '.0')
LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = AC.PersonEmail
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = AC.PersonEmail
LEFT JOIN (
    SELECT
        BounceSubcategory,
        SubscriberKey,
        EventDate
    FROM
        BOUNCE
    WHERE
        NOT (BounceSubcategory = 'Mailbox Full' AND (EventDate + 15) >= GETDATE())
) AS BOUNCE ON BOUNCE.SubscriberKey = AC.Id
WHERE
    u1bm.Email IS NULL
    AND ubh.EmailAddress IS NULL
    AND IsPersonAccount = '1'
    AND BOUNCE.SubscriberKey IS NULL
    -- 691149 rows)  QueryStudioResultsat20240301T1025060000


-- QUERY POPULAR PERSONAS ANTES DE MODIFICAR: !!!!!!!!!!!!!!!!!!!!!!!!
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

-- QUERY POPULAR PERSONAS quitando la nueva tabla de bounce: Bounce_SinMailboxFull_Mas15dias
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
LEFT JOIN Bounce_SinMailboxFull_Mas15dias AS bsmb ON bsmb.SubscriberKey = AC.id
where 
u1bm.Email IS NULL AND 
ubh.EmailAddress IS NULL AND
bsmb.SubscriberKey IS NULL AND
IsPersonAccount = '1'




--------------------------------------------------------------
-- Automation Bounce_SinMailboxFull_Mas15dias

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


-------------------
-- Automation Personas Sync

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
LEFT JOIN Bounce_SinMailboxFull_Mas15dias AS bsmb ON AC.id = bsmb.SubscriberKey
where 
u1bm.Email IS NULL AND 
ubh.EmailAddress IS NULL AND
bsmb.SubscriberKey IS NULL AND
IsPersonAccount = '1'

/*  */
--  (8344 rows) bounce fmb + de 15 dias
-- bounce fmb + de 15 dias  001Dn00000EC3NIIA1
-- bounce fmb - de 15 dias  001Dn00000h6dLpIAI

