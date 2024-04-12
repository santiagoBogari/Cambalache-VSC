
/* Leads_Sync */
--automations.  sql query
select
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
Leads.Sucursal__c as sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
Leads.Localidad__c as Localidad,
Leads.Provincia__c as Provincia,
Leads.Pais__c as Pais,
Leads.Rubro__c as Rubro
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
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
------------------------------------------------------------11-3
/* agregar recordType */
select
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
Leads.Sucursal__c as sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
Leads.Localidad__c as Localidad,
Leads.Provincia__c as Provincia,
Leads.Pais__c as Pais,
Leads.Rubro__c as Rubro,
RecordType.Name
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
left join RecordType on SFIMport_Accounts_4.RecordTypeId = RecordType.Id
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

------------------------------------------------------------14-3
select
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
Leads.Sucursal__c as sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
localidad.name as Localidad,
provincia.name as Provincia,
pais.name as Pais,
RecordType.Name,
Leads.Rubro__c as Rubro
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
left join SFImport_Provincia as provincia on Leads.Provincia__c = provincia.id
left join SFImport_Localidad as localidad on Leads.Localidad__c = localidad.id
left join SFImport_Pais as pais on Leads.Pais__c = pais.id
left join RecordType on SFIMport_Accounts_4.RecordTypeId = RecordType.Id
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

/*  */
QueryStudioResultsat20240314T2110320000

/*  */

select
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
Leads.Sucursal__c as sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
localidad.name as Localidad,
provincia.name as Provincia,
pais.name as Pais,
RecordType.Name,
Leads.Rubro__c as Rubro
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
left join SFImport_Provincia as provincia on Leads.Provincia__c = provincia.id
left join SFImport_Localidad as localidad on Leads.Localidad__c = localidad.id
left join SFImport_Pais as pais on Leads.Pais__c = pais.id
left join RecordType on SFIMport_Accounts_4.RecordTypeId = RecordType.Id
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

-- QueryStudioResultsat20240314T2333120000

/*  */
/* select  
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
Leads.Sucursal__c as sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
localidad.name as Localidad,
provincia.name as Provincia,
pais.name as Pais,
RecordType.Name as RecordType,
Leads.Rubro__c as Rubro
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
left join SFImport_Provincia as provincia on Leads.Provincia__c = provincia.id
left join SFImport_Localidad as localidad on Leads.Localidad__c = localidad.id
left join SFImport_Pais as pais on Leads.Pais__c = pais.id
left join RecordType on SFIMport_Accounts_4.RecordTypeId = RecordType.Id
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
Leads.IsConverted = 'False' and
PersonAc.Id is null and
Contact.Id is null */
-- (5978 rows) (Leads.IsConverted = 'False') test

/* Autom Leads_Sync  query original  */
select
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
Leads.Sucursal__c as Sucursal,
Leads.Convertido__c as Convertido_custom,
Leads.Lead_Type__c as Lead_Type,
Leads.Fecha_Primer_Contacto__c as Primer_Contacto,
Leads.Localidad__c as Localidad,
Leads.Provincia__c as Provincia,
Leads.Pais__c as Pais,
Leads.Rubro__c as Rubro
from Leads_2 as Leads
left join SFIMport_Accounts_4 on 
Leads.ConvertedAccountId = SFIMport_Accounts_4.Id
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
/*  */

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
Leads.Sucursal__c as sucursal,
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

/* query en la automatizacion 'Leads_Sync' y se guarda en la DE 'Leads_Generales' */

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
Leads.Sucursal__c as sucursal,
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

/* Added sucursal name */
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
SFSucursal_Import_2.Name as sucursal,
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
--(6476 rows)
/*  */