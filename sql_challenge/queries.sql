/* obtener los caminos de un Journey Random Split activity */

SELECT
        _Sent.SubscriberKey,
        _Sent.EventDate AS SentEventDate,
        _Sent.TriggererSendDefinitionObjectID,
        _Sent.TriggeredSendCustomerKey,
        _JourneyActivity.ActivityID,
        _JourneyActivity.ActivityName,
        _Journey.JourneyName,
        CASE
            WHEN _JourneyActivity.ActivityID = 'activityID-camino1' THEN 'Camino1'
            WHEN _JourneyActivity.ActivityID = 'activityID-camino2' THEN 'Camino2'
        END AS Camino
FROM _Sent
LEFT JOIN _JourneyActivity
        ON _Sent.TriggererSendDefinitionObjectID = _JourneyActivity.JourneyActivityObjectID
LEFT JOIN _Journey
        ON _JourneyActivity.VersionID = _Journey.VersionID
WHERE _Journey.JourneyName = 'nombre-del-journey'


/*DE  Empresas Giftcard Dia del Trabajador */

SELECT
        _Sent.SubscriberKey,
        _Sent.EventDate AS SentEventDate,
        _JourneyActivity.ActivityName,
        _Journey.JourneyName,
        GC.Email,
        GC.Name,
        CASE
            WHEN _JourneyActivity.ActivityID = '9eeb6e93-8353-4934-a9e3-4e72c25fd218' THEN 'Camino1'
            WHEN _JourneyActivity.ActivityID = '7c376280-663a-4993-b8d8-f2a1bd93c08b' THEN 'Camino2'
        END AS Camino
FROM _Sent
LEFT JOIN _JourneyActivity
        ON _Sent.TriggererSendDefinitionObjectID = _JourneyActivity.JourneyActivityObjectID
LEFT JOIN _Journey
        ON _JourneyActivity.VersionID = _Journey.VersionID
        
INNER JOIN [Empresas Giftcard Dia del Trabajador] GC 
    on GC.ID = _Sent.SubscriberKey
WHERE _Journey.JourneyName = '21-05-24 Giftcard Journey Mayo A-B testing aguinaldo y dia del padre'

/*  (24789 rows) */