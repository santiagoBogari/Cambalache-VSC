/* DE Unsubscribed_Bounce_Held , Automation: Unsubscribed_Bounce_Held */
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

/* (65551 rows) */

SELECT
        _Subscribers.SubscriberID,
        _Subscribers.SubscriberKey,
        _Subscribers.DateUndeliverable,
        _Subscribers.DateJoined,
        _Subscribers.DateUnsubscribed AS SubscribersDateUnsubscribed,
        _Subscribers.Domain,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus,
        _Subscribers.Locale
FROM _Subscribers

/*  */

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
        _Bounce.TriggeredSendCustomerKey,
        _Subscribers.DateUndeliverable,
        _Subscribers.DateJoined,
        _Subscribers.DateUnsubscribed AS SubscribersDateUnsubscribed,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus,
        _Subscribers.Locale
FROM _Bounce
LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
WHERE _Bounce.BounceCategory <> 'Soft bounce'  

/* (32457 rows) */

/*  */
SELECT
  COUNT(CASE WHEN Status = 'unsubscribed' THEN 1 END) AS UnsubscribedCount,
  COUNT(CASE WHEN Status = 'held' THEN 1 END) AS HeldCount,
  COUNT(CASE WHEN Status = 'bounce' THEN 1 END) AS BounceCount
FROM _Subscribers
WHERE
  Status IN ('unsubscribed', 'held', 'bounce')
  /* 
  UNSUBSCRIBEDCOUNT  16400
  HELDCOUNT    49126
  BOUNCECOUNT     0
   */

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
/* (46522 rows) */

SELECT
        _Subscribers.SubscriberID,
        _Subscribers.SubscriberKey,
        _Subscribers.DateUndeliverable,
        _Subscribers.DateJoined,
        _Subscribers.DateUnsubscribed AS SubscribersDateUnsubscribed,
        _Subscribers.Domain,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus,
        _Subscribers.Locale
FROM _Subscribers

/*  */

SELECT
        _Bounce.AccountID,
        _Bounce.JobID,
        _Bounce.SubscriberID,
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.Domain,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.Status AS SubscribersStatus
FROM _Bounce
LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
WHERE _Subscribers.Status IN ('unsubscribed','held','bounced') AND _Bounce.BounceCategory <> 'Soft bounce'  

/* (18985 rows) */

/*  */
SELECT
        _Bounce.AccountID,
        _Bounce.JobID,
        _Bounce.SubscriberID,
        _Bounce.SubscriberKey,
        _Bounce.EventDate AS BounceEventDate,
        _Bounce.Domain,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Bounce.BounceCategory,
        _Subscribers.Status AS SubscribersStatus
FROM _Bounce
LEFT JOIN _Subscribers 
        ON _Bounce.SubscriberID = _Subscribers.SubscriberID
WHERE NOT (_Bounce.BounceCategory = 'Soft bounce' AND _Subscribers.BounceCount < 3) AND _Subscribers.Status <> 'active'

/*  (35427 rows) */

/* SubscriberID  únicos  */
SELECT DISTINCT
    _Bounce.SubscriberID
FROM _Bounce
LEFT JOIN _Subscribers ON _Bounce.SubscriberID = _Subscribers.SubscriberID
/* (17967 rows) */

/*  */
SELECT DISTINCT
    _Subscribers.EmailAddress
FROM _Bounce
LEFT JOIN _Subscribers ON _Bounce.SubscriberID = _Subscribers.SubscriberID

/* (17960 rows) */

/*  */
SELECT DISTINCT
    _Bounce.SubscriberKey
FROM _Bounce
LEFT JOIN _Subscribers ON _Bounce.SubscriberID = _Subscribers.SubscriberID
/* (17962 rows) */