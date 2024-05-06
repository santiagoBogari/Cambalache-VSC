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
/*  */