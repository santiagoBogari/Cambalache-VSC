SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
WHERE CO.Email IS NOT NULL

/* (32409 rows) */

/*  */




SELECT OPP.Id, OPP.AccountId, OPP.CloseDate
FROM Oportunidades as OPP
WHERE OPP.StageName = 'Cerrada/Ganada' 
AND OPP.RecordTypeId = '012Dn000000RxVUIA0' AND OPP.CloseDate > '2024-04-01'

/*  ( 72 rows) */ 

/*  */

SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Oportunidades as OPP on OPP.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.Id = OPP.AccountId
WHERE GC.Id IS NULL

/*  */
/* 
SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Oportunidades as OPP on OPP.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.Id = OPP.AccountId
WHERE GC.Id IS NULL 
*/
/*  */
/*  */
SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.AccountId = CO.AccountId
WHERE GC.Id IS NULL

/* 32344 */

SELECT
        _Bounce.AccountID,
        _Bounce.OYBAccountID,
        _Bounce.JobID,
        _Bounce.ListID,
        _Bounce.BatchID,
        _Bounce.SubscriberID,
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.Domain,
        _Bounce.BounceCategoryID,
        _Bounce.BounceCategory,
        _Bounce.BounceSubcategoryID,
        _Bounce.BounceSubcategory,
        _Bounce.BounceTypeID,
        _Bounce.BounceType,
        _Bounce.SMTPBounceReason,
        _Bounce.SMTPMessage,
        _Bounce.SMTPCode,
        _Bounce.TriggererSendDefinitionObjectID,
        _Bounce.TriggeredSendCustomerKey
FROM _Bounce

/*  */

/* 
SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.AccountId = CO.AccountId
LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = EMP.PersonEmail
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = EMP.PersonEmail
LEFT JOIN Bounce_SinMailboxFull_Mas15dias AS bsmb ON EMP.id = bsmb.SubscriberKey
WHERE GC.Id IS NULL AND u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL AND
bsmb.SubscriberKey IS NULL  
*/

/* SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.AccountId = CO.AccountId
LEFT JOIN _Bounce as BO on BO.AccountID = EMP.Id
WHERE GC.Id IS NULL AND BO.AccountID IS NULL */

SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id
LEFT JOIN Opp_GiftCard as GC on GC.AccountId = CO.AccountId
LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE GC.Id IS NULL AND
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL


/* test, quitar bounces  */
SELECT
CO.Id,
CO.Email,
CO.Name
FROM SFIMport_Contacts as CO
INNER JOIN Empresas as EMP on CO.AccountId = EMP.Id

LEFT JOIN Unsubscribed_Bounce_Held AS ubh ON ubh.EmailAddress = CO.Email
LEFT JOIN Unsubscribed_1895_1_BBDD_Maestra AS u1bm ON u1bm.Email = CO.Email
WHERE 
u1bm.Email IS NULL AND
ubh.EmailAddress IS NULL AND CO.Email IS NOT NULL
/* (28180 rows) */
