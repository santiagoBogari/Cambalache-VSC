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