SELECT
        _Job.EmailName,
        _Open.AccountID,
        _Open.OYBAccountID,
        _Open.JobID,
        _Open.ListID,
        _Open.BatchID,
        _Open.SubscriberID,
        _Open.SubscriberKey,
        _Open.EventDate AS OpenEventDate,
        _Open.Domain,
        _Open.TriggererSendDefinitionObjectID,
        _Open.TriggeredSendCustomerKey,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateUndeliverable,
        _Subscribers.DateJoined,
        _Subscribers.DateUnsubscribed AS SubscribersDateUnsubscribed,
        _Subscribers.EmailAddress,
        _Subscribers.BounceCount,
        _Subscribers.SubscriberType AS SubscribersSubscriberType,
        _Subscribers.Status AS SubscribersStatus,
        _Subscribers.Locale,
        _Job.AccountUserID,
        _Job.EmailID,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.PickupTime,
        _Job.DeliveredTime,
        _Job.EventID,
        _Job.IsMultipart,
        _Job.JobType,
        _Job.JobStatus,
        _Job.ModifiedBy,
        _Job.ModifiedDate,
        
        _Job.EmailSubject,
        _Job.IsWrapped,
        _Job.TestEmailAddr,
        _Job.Category,
        _Job.BccEmail,
        _Job.OriginalSchedTime,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.CharacterSet,
        _Job.IPAddress,
        _Job.SalesForceTotalSubscriberCount,
        _Job.SalesForceErrorSubscriberCount,
        _Job.SendType,
        _Job.DynamicEmailSubject,
        _Job.SuppressTracking,
        _Job.SendClassificationType,
        _Job.SendClassification,
        _Job.ResolveLinksWithCurrentData,
        _Job.EmailSendDefinition,
        _Job.DeduplicateByEmail,
        _JourneyActivity.VersionID,
        _JourneyActivity.ActivityID,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityExternalKey,
        _JourneyActivity.JourneyActivityObjectID,
        _JourneyActivity.ActivityType,
        _Journey.JourneyID,
        _Journey.JourneyName,
        _Journey.VersionNumber,
        _Journey.CreatedDate AS JourneyCreatedDate,
        _Journey.LastPublishedDate,
        _Journey.JourneyStatus
FROM _Open
LEFT JOIN _Click 
        ON _Open.JobID = _Click.JobID 
        AND _Open.ListID = _Click.ListID 
        AND _Open.BatchID = _Click.BatchID 
        AND _Open.SubscriberID = _Click.SubscriberID 
        AND _Click.IsUnique = 1
LEFT JOIN _Subscribers 
        ON _Open.SubscriberID = _Subscribers.SubscriberID
LEFT JOIN _Job 
        ON _Open.JobID = _Job.JobID
LEFT JOIN _JourneyActivity 
        ON _Open.TriggererSendDefinitionObjectID = _JourneyActivity.JourneyActivityObjectID
LEFT JOIN _Journey 
        ON _JourneyActivity.VersionID = _Journey.VersionID
        
WHERE _Journey.JourneyName = 'New_Release'


/*  */

SELECT
    j.EmailName,
    l.LinkName,
    COUNT(c.SubscriberKey) AS TotalClicks,
    (COUNT(c.SubscriberKey) * 100.0 / CAST(SUM(j.Sent) AS DECIMAL(10, 2))) AS ClickRate,
    DATEADD(day, 6 - DATEPART(weekday, GETDATE()), GETDATE()) AS WeekEndingDate
FROM
    _Job j
JOIN
    _Click c ON j.JobID = c.JobID
JOIN
    _Sent s ON j.JobID = s.JobID AND s.SubscriberKey = c.SubscriberKey
JOIN
    _Link l ON c.LinkID = l.LinkID
WHERE
    j.SendDate >= DATEADD(day, -7, GETDATE())
GROUP BY
    j.EmailName,
    l.LinkName,
    j.Sent

/*  */

