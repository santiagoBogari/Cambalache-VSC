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

/*  */

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
