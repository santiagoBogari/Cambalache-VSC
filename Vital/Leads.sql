
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