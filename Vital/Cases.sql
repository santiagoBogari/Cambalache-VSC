/* 
RecordType
Sucursal
CreatedBy
Owner 
*/

SELECT Id, IsDeleted, MasterRecordId, CaseNumber, ContactId, AccountId, SourceId, ParentId, SuppliedName, SuppliedEmail, SuppliedPhone, SuppliedCompany, Type, RecordTypeId, Status, Reason, Origin, Language, Subject, Priority, IsClosed, ClosedDate, IsEscalated, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, ContactPhone, ContactMobile, ContactEmail, ContactFax, Comments, LastViewedDate, LastReferencedDate, Tipo_de_reclamo_web_to_case__c, Precios__c, Tipo_de_Reclamo__c, Canal_de_contacto__c, Sucursal__c, Se_resolvio_operativamente__c, Medio_de_Pago__c, Motivo_de_Reclamo__c, Marca_de_Tarjeta__c, Tipo_de_producto__c, Tipo_de_documento__c, Banco_Entidad_Emisora__c, Fecha_y_hora_de_operacion__c, Error_en_terminal__c, Marca_propia__c, Importe__c, Se_llevo_la_mercaderia__c, Billetera_Virtual__c, Detallar__c, Motivo_de_Reclamo_Billetera__c, N_de_Tarjeta__c, N_de_Cupon__c, N_de_Lote__c, N_de_Comercio__c, N_de_Terminal__c, Marca__c, N_de_Operacion__c, Donde_adquirio_el_producto__c, Categoria_de_frescos__c, Tipo_de_Terminal__c, Tipo_de_Solicitud__c, Motivo_de_Devolucion__c, Requiere_instalacion__c, N_de_Factura__c, Fecha_de_Factura__c, Motivo_de_Cambio_Mano_a_Mano__c, Fecha_y_hora_del_cambio__c, Modelo__c, N_de_Material__c, N_de_Serie__c, N_de_EAN__c, Articulo__c, Marca_electro__c, DNI_o_CUIT__c, Motivo_del_contacto__c, Codigo_RNPA__c, Codigo_RNE__c, Codigo_EAN__c, Fecha_de_vencimiento__c, Fecha_y_hora_de_operacion_billetera_virt__c, N_de_Operacion_billetera_virtual__c, Importe_billetera_virtual__c, Se_llevo_la_mercaderia_billetera_virtual__c, Resolucion__c, Mandar_a_aprobar_con__c, Campo_flow__c, Estado_de_aprobacion__c, Cantidad_de_horas_del_caso__c, Motivo_Bonificacion__c, Motivo_Devolucion__c, N_de_Guia__c, Hs_de_edicion_del_estado__c, Firmo_la_Carta_Compromiso__c, Firmo_la_Carta_Compromiso_Billetera_Virt__c, Motivo__c, Submotivo__c, Equipo__c, Firmo_la_Carta_Compromiso_NEW__c, LLevo_la_Mercaderia__c, Aprobador__c, Web_FirstName__c, Web_LastName__c, Codigo_Pais_Telefono_Movil__c, Empresa_que_compro_GC__c
FROM SFImport_Cases

/*   */
SELECT SFImport_Cases.Id as ID, SFImport_Cases.IsDeleted as IsDeleted, MasterRecordId, CaseNumber, SFImport_Cases.ContactId as ContactID, SFImport_Cases.AccountId as AccountID, SourceId, ParentId, SuppliedName, SuppliedEmail,
SuppliedPhone, SuppliedCompany, Type,
RecordType.Name as RecordType,
Status, Reason, Origin, Subject, Priority, IsClosed,
ClosedDate, IsEscalated, SFImport_Cases.OwnerId as OwnerId, SFImport_Cases.CreatedDate as CreatedDate,
SFImport_Cases.CreatedById as CreatedById,
sfUser.Name as CreatedBy,
SFImport_Cases.LastModifiedDate as LastModifiedDate, SFImport_Cases.LastModifiedById as LastModifiedById , SFImport_Cases.SystemModstamp as SystemModstamp,
ContactPhone, ContactMobile, ContactEmail, Comments, SFImport_Cases.LastViewedDate as LastViewedDate, SFImport_Cases.LastReferencedDate as LastReferencedDate,
Tipo_de_reclamo_web_to_case__c, Precios__c, Tipo_de_Reclamo__c, Canal_de_contacto__c, Sucursal__c,
SFSucursal_Import_2.Name as Sucursal,
Se_resolvio_operativamente__c, Medio_de_Pago__c, Motivo_de_Reclamo__c, Marca_de_Tarjeta__c, Tipo_de_producto__c,
Tipo_de_documento__c, Banco_Entidad_Emisora__c, Fecha_y_hora_de_operacion__c, Error_en_terminal__c, 
Marca_propia__c, Importe__c, Se_llevo_la_mercaderia__c, Billetera_Virtual__c, Detallar__c, Motivo_de_Reclamo_Billetera__c,
N_de_Tarjeta__c, N_de_Cupon__c, N_de_Lote__c, N_de_Comercio__c, N_de_Terminal__c, Marca__c, N_de_Operacion__c,
Donde_adquirio_el_producto__c, Categoria_de_frescos__c, Tipo_de_Terminal__c, Tipo_de_Solicitud__c, Motivo_de_Devolucion__c,
Requiere_instalacion__c, N_de_Factura__c, Fecha_de_Factura__c, Motivo_de_Cambio_Mano_a_Mano__c, Fecha_y_hora_del_cambio__c,
Modelo__c, N_de_Material__c, N_de_Serie__c, N_de_EAN__c, Articulo__c, Marca_electro__c, DNI_o_CUIT__c, Motivo_del_contacto__c,
Codigo_RNPA__c, Codigo_RNE__c, Codigo_EAN__c, Fecha_de_vencimiento__c, Fecha_y_hora_de_operacion_billetera_virt__c,
N_de_Operacion_billetera_virtual__c, Importe_billetera_virtual__c, Se_llevo_la_mercaderia_billetera_virtual__c, Resolucion__c, 
Mandar_a_aprobar_con__c, Campo_flow__c, Estado_de_aprobacion__c, Cantidad_de_horas_del_caso__c, Motivo_Bonificacion__c,
Motivo_Devolucion__c, N_de_Guia__c, Hs_de_edicion_del_estado__c, Firmo_la_Carta_Compromiso__c,
Firmo_la_Carta_Compromiso_Billetera_Virt__c, Motivo__c, Submotivo__c, Equipo__c, Firmo_la_Carta_Compromiso_NEW__c,
LLevo_la_Mercaderia__c, Aprobador__c, Web_FirstName__c, Web_LastName__c, Codigo_Pais_Telefono_Movil__c,
Empresa_que_compro_GC__c
From SFImport_Cases
LEFT JOIN RecordType on RecordType.Id = SFImport_Cases.RecordTypeId
LEFT JOIN SFImport_User as sfUser on sfUser.Id = SFImport_Cases.CreatedById
LEFT JOIN SFSucursal_Import_2 ON SFImport_Cases.Sucursal__c = LEFT(SFSucursal_Import_2.ID_Top_Group__c, LEN(SFSucursal_Import_2.ID_Top_Group__c) - 2)
/* (14753 rows) */

SELECT Id,QueueId,SobjectType,SystemModstamp FROM QueueSobject

/* el OwnerId relacionado a Group trae Queue */
SELECT SFImport_Cases.Id as ID, SFImport_Cases.IsDeleted as IsDeleted, MasterRecordId, CaseNumber, SFImport_Cases.ContactId as ContactID, SFImport_Cases.AccountId as AccountID, SourceId, ParentId, SuppliedName, SuppliedEmail,
SuppliedPhone, SuppliedCompany, SFImport_Cases.Type as CaseType,
RecordType.Name as RecordType,
Status, Reason, Origin, Subject, Priority, IsClosed,
ClosedDate, IsEscalated, SFImport_Cases.OwnerId as OwnerId,sfGroup.Type as Owner, SFImport_Cases.CreatedDate as CreatedDate,
SFImport_Cases.CreatedById as CreatedById,
sfUser.Name as CreatedBy,
SFImport_Cases.LastModifiedDate as LastModifiedDate, SFImport_Cases.LastModifiedById as LastModifiedById , SFImport_Cases.SystemModstamp as SystemModstamp,
ContactPhone, ContactMobile, ContactEmail, Comments, SFImport_Cases.LastViewedDate as LastViewedDate, SFImport_Cases.LastReferencedDate as LastReferencedDate,
Tipo_de_reclamo_web_to_case__c, Precios__c, Tipo_de_Reclamo__c, Canal_de_contacto__c, Sucursal__c,
SFSucursal_Import_2.Name as Sucursal,
Se_resolvio_operativamente__c, Medio_de_Pago__c, Motivo_de_Reclamo__c, Marca_de_Tarjeta__c, Tipo_de_producto__c,
Tipo_de_documento__c, Banco_Entidad_Emisora__c, Fecha_y_hora_de_operacion__c, Error_en_terminal__c, 
Marca_propia__c, Importe__c, Se_llevo_la_mercaderia__c, Billetera_Virtual__c, Detallar__c, Motivo_de_Reclamo_Billetera__c,
N_de_Tarjeta__c, N_de_Cupon__c, N_de_Lote__c, N_de_Comercio__c, N_de_Terminal__c, Marca__c, N_de_Operacion__c,
Donde_adquirio_el_producto__c, Categoria_de_frescos__c, Tipo_de_Terminal__c, Tipo_de_Solicitud__c, Motivo_de_Devolucion__c,
Requiere_instalacion__c, N_de_Factura__c, Fecha_de_Factura__c, Motivo_de_Cambio_Mano_a_Mano__c, Fecha_y_hora_del_cambio__c,
Modelo__c, N_de_Material__c, N_de_Serie__c, N_de_EAN__c, Articulo__c, Marca_electro__c, DNI_o_CUIT__c, Motivo_del_contacto__c,
Codigo_RNPA__c, Codigo_RNE__c, Codigo_EAN__c, Fecha_de_vencimiento__c, Fecha_y_hora_de_operacion_billetera_virt__c,
N_de_Operacion_billetera_virtual__c, Importe_billetera_virtual__c, Se_llevo_la_mercaderia_billetera_virtual__c, Resolucion__c, 
Mandar_a_aprobar_con__c, Campo_flow__c, Estado_de_aprobacion__c, Cantidad_de_horas_del_caso__c, Motivo_Bonificacion__c,
Motivo_Devolucion__c, N_de_Guia__c, Hs_de_edicion_del_estado__c, Firmo_la_Carta_Compromiso__c,
Firmo_la_Carta_Compromiso_Billetera_Virt__c, Motivo__c, Submotivo__c, Equipo__c, Firmo_la_Carta_Compromiso_NEW__c,
LLevo_la_Mercaderia__c, Aprobador__c, Web_FirstName__c, Web_LastName__c, Codigo_Pais_Telefono_Movil__c,
Empresa_que_compro_GC__c
From SFImport_Cases
LEFT JOIN RecordType on RecordType.Id = SFImport_Cases.RecordTypeId
LEFT JOIN SFImport_User as sfUser on sfUser.Id = SFImport_Cases.CreatedById
LEFT JOIN SFSucursal_Import_2 on SFImport_Cases.Sucursal__c = LEFT(SFSucursal_Import_2.ID_Top_Group__c, LEN(SFSucursal_Import_2.ID_Top_Group__c) - 2)
LEFT JOIN SFImport_Group as sfGroup on SFImport_Cases.OwnerId = sfGroup.Id