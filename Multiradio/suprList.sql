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

/* query para autosuppression list */
Select B.SubscriberKey, B.EventDate, B.BounceCategory, B.BounceSubcategory, J.EmailAddress
from [_bounce] B
inner Join [_Subscribers] J
on J.SubscriberKey = B.SubscriberKey
where B.EventDate > dateadd(hour, -24, getdate())
AND B.BounceSubcategory = 'User Unknown' OR B.BounceSubcategory = 'Inactive Account'
/*  */


/* eliotharper/UpdateQuery.js */

<script language="javascript" runat="server">
// Author: Eliot Harper <eliot@eliot.com.au>
// Revision date: January 31, 2021

// DISCLAIMER
// While due care has been taken in the preparation of this
// supplied code example, no liability is assumed for incidental
// or consequential damages in connection with or arising out its 
// use. Example code is provided on an "as is" basis and no 
// expressed or implied warranty of any kind is made for the 
// suitability of this code for your purpose. Salesforce Marketing 
// Cloud operational procedures and programming methods may change 
// between releases and you are solely responsible for determining 
// whether this code is applicable for your intended use.

Platform.Load('Core', '1');

var prox = new Script.Util.WSProxy();

var queryStr = '';
    queryStr += 'SELECT';
    queryStr += '\n_Subscribers.SubscriberID,';
    queryStr += '\n_Subscribers.SubscriberKey,';
    queryStr += '\n_Subscribers.DateUnsubscribed AS DateUnsubscribed';  
    queryStr += '\n_Subscribers.Domain,';
    queryStr += '\n_Subscribers.EmailAddress,';
    queryStr += '\n_Subscribers.BounceCount,';
    queryStr += '\n_Subscribers.Status AS Status';
    queryStr += '\nFROM _Subscribers';
    queryStr += '\n_WHERE  _Subscribers.Status = 'unsubscribed'';

  var queryDef = {
    CustomerKey: 'D87F630C-78EF-465E-B3A2-4FA90AE4551D',
    ObjectID: 'd87f630c-78ef-465e-b3a2-4fa90ae4551d',
    QueryText: queryStr,
    TargetType: 'DE',
    TargetUpdateType: 'Update',
    DataExtensionTarget: {
      CustomerKey: '624CFAB6-F204-462A-8A26-8D4E27BE2644',
      Name: 'SB_AutoSuppression_List'
    }
  };
var updateQuery = prox.updateItem('QueryDefinition', queryDef);

Write('result: ' + Stringify(updateQuery))

</script>
/*  */