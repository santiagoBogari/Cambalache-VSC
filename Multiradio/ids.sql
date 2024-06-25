/* muchos nulls salvo Email */

SELECT DNI, Email, Nombre, Apellido, Telefono

FROM Cliente

/*  92887 rows  */


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

/* (179711 rows) */

/*  */

SELECT
        Cl.Email,
        Sub.SubscriberID,
        Sub.SubscriberKey,
        Sub.Domain,
        Sub.EmailAddress,
        Sub.Status AS SubscribersStatus
FROM _Subscribers as Sub
INNER JOIN Cliente as Cl on Cl.Email = Sub.EmailAddress

/* (92260 rows) */

/*  */

SELECT
        Cl.Email,
        Sub.SubscriberID,
        Sub.SubscriberKey,
        Sub.Domain,
        Sub.EmailAddress,
        Sub.Status AS SubscribersStatus
FROM _Subscribers as Sub
LEFT JOIN Cliente as Cl on Cl.Email = Sub.EmailAddress
WHERE Sub.SubscriberID IS NOT NULL

/* (179717 rows) */

/*  */
SELECT
    Cl.Email,
    Sub.SubscriberID,
    Sub.SubscriberKey,
    Sub.Domain,
    Sub.EmailAddress,
    Sub.Status AS SubscribersStatus
FROM _Subscribers AS Sub
LEFT JOIN Cliente AS Cl ON Cl.Email = Sub.EmailAddress
WHERE CHARINDEX('@', Sub.SubscriberKey) = 0

/* 6 records */


