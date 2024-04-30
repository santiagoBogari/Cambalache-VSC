/* 	Este Query arma los registros para popular la DE Empresas, con la informacion agregada de otros objetos */
/* Empresas_Sync  Automation */
select
AC.id,
AC.Name as Nombre,
AC.Type as Tipo,
AC.RecordTypeId,
rt.Name as Tipo_Cliente,
AC.ParentId,
AC.Phone as Telefono,
AC.OwnerID,
AC.CreatedDate as Fecha_Creacion,
AC.AccountSource as Origen_Cuenta,
AC.Razon_social__c as Razon_Social,
AC.CUIT__c as CUIT,
AC.Email__c as Email,
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
where IsPersonAccount = '0'