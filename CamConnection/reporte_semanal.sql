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

<script runat="server">
Platform.Load("core", "1");
// aqui configuras las variables
var resultsDE = DataExtension.Init("ClickMetrics");
var queryDefinition = QueryDefinition.Init("Your_SQL_Query_Name");
// Ejecucion de la query
try {
    queryDefinition.Start();
    Write("Query ejecutada correctamente.");
} catch (e) {
    Write("Error al ejecutar la consulta: " + Stringify(e));
}
// wait de la query
var queryStatus = queryDefinition.Status;
while (queryStatus != "Completed") {
    queryStatus = queryDefinition.Status;
    Platform.Response.Write("Esperando que la consulta finalice...<br>");
    Platform.Function.Sleep(5000); // Esperar 5 segundos antes de volver a comprobar
}
// captación de datos de la DE
var reportRows = resultsDE.Rows.Retrieve();
var emailContent = "<h1>Click Report</h1><table><tr><th>Email Name</th><th>Link Name</th><th>Total Clicks</th><th>Click Rate</th></tr>";
for (var i = 0; i < reportRows.length; i++) {
    emailContent += "<tr><td>" + reportRows[i].EmailName + "</td><td>" + reportRows[i].LinkName + "</td><td>" + reportRows[i].TotalClicks + "</td><td>" + reportRows[i].ClickRate + "%</td></tr>";
}
emailContent += "</table>";
// si se va a configurar y enviar un correo electrónico con la info
var email = {
    "To": "your-email@example.com",
    "From": "noreply@example.com",
    "Subject": "Weekly Click Report",
    "HTMLBody": emailContent
};
try {
    Platform.Function.SendEmail(email);
    Write("Email enviado correctamente.");
} catch (e) {
    Write("Error al enviar el email: " + Stringify(e));
}
</script>

/*  */
SELECT  acc.Name as Name,
        _Job.EmailName,
        _Subscribers.EmailAddress AS SubscriberEmail,
        _Open.EventDate AS OpenEventDate,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateJoined,
        _Subscribers.Status AS SubscribersStatus,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.ModifiedDate,
        _Job.EmailSubject,
        _Job.Category,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.SendClassificationType,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityType,
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
LEFT JOIN   Emails_Account_Contact_Lead as Acc
        ON Acc.Email = _Subscribers.EmailAddress
WHERE _Click.EventDate IS NOT NULL AND _Click.EventDate >= DATEADD(day, -90, GETDATE())

/* (208 rows) */

SELECT  acc.Name as Name,
        _Job.EmailName,
        _Subscribers.EmailAddress AS SubscriberEmail,
        _Open.EventDate AS OpenEventDate,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateJoined,
        _Subscribers.Status AS SubscribersStatus,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.ModifiedDate,
        _Job.EmailSubject,
        _Job.Category,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.SendClassificationType,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityType,
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
LEFT JOIN   Emails_Account_Contact_Lead as Acc
        ON Acc.Email = _Subscribers.EmailAddress
WHERE _Click.EventDate IS NOT NULL
/*  (1039 rows) */

/*  */
SELECT DISTINCT
acc.Name as Name,
        _Job.EmailName,
        _Subscribers.EmailAddress AS SubscriberEmail,
        _Open.EventDate AS OpenEventDate,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateJoined,
        _Subscribers.Status AS SubscribersStatus,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.ModifiedDate,
        _Job.EmailSubject,
        _Job.Category,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.SendClassificationType,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityType,
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
LEFT JOIN   Emails_Account_Contact_Lead as Acc
        ON Acc.Email = _Subscribers.EmailAddress
WHERE _Open.EventDate IS NOT NULL
/* DE tiene duplicados que abrieron varias veces (6531 rows)*/ 

/*  */
SELECT
    Name,
    EmailName,
    SubscriberEmail,
    OpenEventDate,
    ClickEventDate,
    URL,
    LinkName,
    LinkContent,
    DateJoined,
    SubscribersStatus,
    FromName,
    FromEmail,
    SchedTime,
    ModifiedDate,
    EmailSubject,
    Category,
    JobCreatedDate,
    SendClassificationType,
    ActivityName,
    ActivityType,
    JourneyName,
    VersionNumber,
    JourneyCreatedDate,
    LastPublishedDate,
    JourneyStatus
FROM (
    SELECT
        acc.Name as Name,
        _Job.EmailName,
        _Subscribers.EmailAddress AS SubscriberEmail,
        _Open.EventDate AS OpenEventDate,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateJoined,
        _Subscribers.Status AS SubscribersStatus,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.ModifiedDate,
        _Job.EmailSubject,
        _Job.Category,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.SendClassificationType,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityType,
        _Journey.JourneyName,
        _Journey.VersionNumber,
        _Journey.CreatedDate AS JourneyCreatedDate,
        _Journey.LastPublishedDate,
        _Journey.JourneyStatus,
        ROW_NUMBER() OVER (PARTITION BY _Subscribers.EmailAddress, _Job.EmailName ORDER BY _Open.EventDate) AS rn
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
    LEFT JOIN Emails_Account_Contact_Lead as Acc
        ON Acc.Email = _Subscribers.EmailAddress
    WHERE _Open.EventDate IS NOT NULL
) AS subquery
WHERE rn = 1
/* opens sin duplicados (3632 rows)*/

/*  */
SELECT
    Name,
    EmailName,
    SubscriberEmail,
    OpenEventDate,
    ClickEventDate,
    URL,
    LinkName,
    LinkContent,
    DateJoined,
    SubscribersStatus,
    FromName,
    FromEmail,
    SchedTime,
    ModifiedDate,
    EmailSubject,
    Category,
    JobCreatedDate,
    SendClassificationType,
    ActivityName,
    ActivityType,
    JourneyName,
    VersionNumber,
    JourneyCreatedDate,
    LastPublishedDate,
    JourneyStatus
FROM (
    SELECT
        acc.Name as Name,
        _Job.EmailName,
        _Subscribers.EmailAddress AS SubscriberEmail,
        _Open.EventDate AS OpenEventDate,
        _Click.EventDate AS ClickEventDate,
        _Click.URL,
        _Click.LinkName,
        _Click.LinkContent,
        _Subscribers.DateJoined,
        _Subscribers.Status AS SubscribersStatus,
        _Job.FromName,
        _Job.FromEmail,
        _Job.SchedTime,
        _Job.ModifiedDate,
        _Job.EmailSubject,
        _Job.Category,
        _Job.CreatedDate AS JobCreatedDate,
        _Job.SendClassificationType,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityType,
        _Journey.JourneyName,
        _Journey.VersionNumber,
        _Journey.CreatedDate AS JourneyCreatedDate,
        _Journey.LastPublishedDate,
        _Journey.JourneyStatus,
        ROW_NUMBER() OVER (PARTITION BY _Subscribers.EmailAddress, _Click.URL ORDER BY _Click.EventDate) AS rn
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
    LEFT JOIN Emails_Account_Contact_Lead as Acc
        ON Acc.Email = _Subscribers.EmailAddress
    WHERE _Click.EventDate IS NOT NULL
) AS subquery
WHERE rn = 1
/* clicks sin duplicados (405 rows) */

