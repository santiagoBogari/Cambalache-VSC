/* Automation: Unsubscribed_Bounce_Held */

SELECT
SubscriberID,
DateUndeliverable,
DateJoined,
DateUnsubscribed,
EmailAddress,
BounceCount,
SubscriberKey,
SubscriberType,
Status
FROM _Subscribers
WHERE
Status IN ('unsubscribed','held','bounce')

/*  */

/* Automation: Bounce_SinMailboxFull_Mas15dias */
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

  /*  */
  /* Automation: Popular Contactos con Empresa */
  SELECT
CO.Id as Contact_ID,
CO.Email as Contact_Email,
CO.Name as Contact_Name,
EMP.Nombre as Account_Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE 
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL AND CO.Email IS NOT NULL

/* DE Contactos_con_Empresas */

/* Automation: Data_View_Sent */
Select
AccountID,
OYBAccountID, 
JobID, 
ListID, 
BatchID, 
SubscriberID, 
SubscriberKey, 
EventDate, 
Domain, 
TriggererSendDefinitionObjectID, 
TriggeredSendCustomerKey
From _Sent
/* Target Data Extension : Sent ,Data Extension	Sent, Data Action	Update */

/* ---------------------------------------------------------------------- */
/* Automation LEADS_SYNC */

/* 1ra activity Import 'SF_Import_Lead' Add and Update DE'SF_Import_Lead'*/

/* 3ra activity (Obtener Leads no Duplicados) que guarda en 'Leads_Generales'*/
SELECT
Leads.id,
Leads.LastName as Apellido,
Leads.FirstName as Nombre,
Leads.Name as Nombre_y_Apellido,
Leads.Phone as Telefono,
Leads.MobilePhone as Celular,
Leads.Email,
Leads.LeadSource as Origen,
Leads.Status as Estado,
Leads.Industry as Industria,
Leads.OwnerId,
Leads.Isconverted,
'' as Año_ult_Compra,
SFSucursal_Import_2.Name as Sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
localidad.name as Localidad,
provincia.name as Provincia,
pais.name as Pais,
RecordType.Name,
Leads.Rubro__c as Rubro,
RecordType.Name as RecordType,
Leads.Tipo__c as Tipo
from SF_Import_Lead as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
left join SFImport_Provincia as provincia on Leads.Provincia__c = provincia.id
left join SFImport_Localidad as localidad on Leads.Localidad__c = localidad.id
left join SFImport_Pais as pais on Leads.Pais__c = pais.id
Left Join RecordType on RecordType.Id = Leads.RecordTypeId
LEFT JOIN SFSucursal_Import_2 ON Leads.Sucursal__c = LEFT(SFSucursal_Import_2.ID_Top_Group__c, LEN(SFSucursal_Import_2.ID_Top_Group__c) - 2)
left join 
(select 
id,
ispersonaccount,
personemail
from SFImport_Accounts_4
where ispersonaccount = '1') as PersonAC on Leads.Email = PersonAC.personemail
left join
(select
id,
Email,
ispersonaccount
from SFIMport_Contacts
where ispersonaccount = '0') as Contact on Leads.Email = Contact.Email
where  
SFImport_Accounts_4.Id is null and
PersonAc.Id is null and
Contact.Id is null