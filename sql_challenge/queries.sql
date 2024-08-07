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
FROM
    _Sent
    LEFT JOIN _JourneyActivity ON _Sent.TriggererSendDefinitionObjectID = _JourneyActivity.JourneyActivityObjectID
    LEFT JOIN _Journey ON _JourneyActivity.VersionID = _Journey.VersionID
    INNER JOIN [Empresas Giftcard Dia del Trabajador] GC on GC.ID = _Sent.SubscriberKey
WHERE
    _Journey.JourneyName = '21-05-24 Giftcard Journey Mayo A-B testing aguinaldo y dia del padre'
/*  (24789 rows) */

/* query reporte de clicks Luca */

SELECT
    s.SubscriberKey,
    j.JourneyName AS Journey,
    s.EventDate as Fecha_envio,
    'Email' AS Canal,
    ja.ActivityName,
    CASE WHEN s.EventDate IS NOT NULL THEN 1 ELSE NULL END AS Sent_,
    CASE WHEN o.EventDate IS NOT NULL THEN 1 ELSE NULL END AS Open_,
    CASE WHEN c.EventDate IS NOT NULL THEN 1 ELSE NULL END AS Click_,
    CASE WHEN b.EventDate IS NOT NULL THEN 1 ELSE NULL END AS Bounce_,
    CASE WHEN u.EventDate IS NOT NULL THEN 1 ELSE NULL END AS Unsubs_
FROM _Sent AS s
   LEFT JOIN _Job AS job
       ON job.JobID = s.JobID
   LEFT JOIN _Open AS o
       ON o.JobID = s.JobID
       AND o.ListID = s.ListID
       AND o.BatchID = s.BatchID
       AND o.SubscriberID = s.SubscriberID
       AND o.IsUnique = 1
   LEFT JOIN _Click AS c
       ON s.JobID = c.JobID
       AND c.ListID = s.ListID
       AND c.BatchID = s.BatchID
       AND c.SubscriberID = s.SubscriberID
       AND c.IsUnique = 1
   LEFT JOIN _Bounce AS b
       ON s.JobID = b.JobID
       AND b.ListID = s.ListID
       AND b.BatchID = s.BatchID
       AND b.SubscriberID = s.SubscriberID
       AND b.IsUnique = 1
   LEFT JOIN _Unsubscribe AS u
       ON s.JobID = u.JobID
       AND u.ListID = s.ListID
       AND u.BatchID = s.BatchID
       AND u.SubscriberID = s.SubscriberID
       AND u.IsUnique = 1
   LEFT JOIN _JourneyActivity AS ja
       ON ja.JourneyActivityObjectID = s.TriggererSendDefinitionObjectID
   LEFT JOIN _Journey AS j
       ON j.VersionID = ja.VersionID 
WHERE  j.JourneyName IN ('journey1','journey2','journey3')

/*  */

SELECT
    s.SubscriberKey AS SubscriberKey,
    j.JourneyName AS JourneyName,
    job.EmailName AS EmailName,
    s.EventDate AS SentDate,
    o.EventDate AS OpenDate,
    c.EventDate AS ClickDate,
    b.EventDate AS BounceDate,
    u.EventDate AS UnsubscribeDateFROM _Sent AS s
    LEFT JOIN _Job AS job ON job.JobID = s.JobID
    LEFT JOIN _Open AS o ON o.JobID = s.JobID
    AND o.ListID = s.ListID
    AND o.BatchID = s.BatchID
    AND o.SubscriberID = s.SubscriberID
    AND o.IsUnique = 1
    LEFT JOIN _Click AS c ON s.JobID = c.JobID
    AND c.ListID = s.ListID
    AND c.BatchID = s.BatchID
    AND c.SubscriberID = s.SubscriberID
    AND c.IsUnique = 1
    LEFT JOIN _Bounce AS b ON s.JobID = b.JobID
    AND b.ListID = s.ListID
    AND b.BatchID = s.BatchID
    AND b.SubscriberID = s.SubscriberID
    AND b.IsUnique = 1
    LEFT JOIN _Unsubscribe AS u ON s.JobID = u.JobID
    AND u.ListID = s.ListID
    AND u.BatchID = s.BatchID
    AND u.SubscriberID = s.SubscriberID
    AND u.IsUnique = 1
    LEFT JOIN _JourneyActivity AS ja ON ja.JourneyActivityObjectID = s.TriggererSendDefinitionObjectID
    LEFT JOIN _Journey AS j ON j.VersionID = ja.VersionID
WHERE
    s.EventDate >= DATEADD(DAY, -1, GETDATE())

    /*  */

SELECT bd.Account_Id,
       bd.Flag_Sellos,
       au.Fecha_ultima_Compra_GO,
       au.First_Name,
       au.Last_Name,
       au.Email,
       au.Phone_Number,
       au.Locate,
       au.City,
       CASE 
          WHEN bd.Flag_Sellos >= 3 THEN 'True' 
          ELSE 'False' 
       END AS Sello_Finalizado
FROM (
  SELECT bd.MC_AccountId AS Account_Id,
         COUNT(CASE WHEN bd.Rango_Ticket = '$300+' AND CAST(bd.fecha_orden_mioxxo AS DATE) >= '2024-07-01' THEN 1 ELSE NULL END) AS Flag_Sellos
  FROM Base_Barracuda_Importacion bd
  GROUP BY bd.MC_AccountId
) bd

 /* subquery con un count de pedidos +300 pesosy en la otra query preguntas 
 si tiene al menos 3 de esos pedidos le pones true en un campo */

 /*  */
 CAST(st.ActionDateTime AS Date) >= '2023-07-13'

 CAST(EndDate AS Date)  > 'Jan 1 2020' 


 /* Reporte filtrado por dia de todas las acciones del canal Email */
 SELECT
    s.SubscriberKey AS SubscriberKey,
    j.JourneyName AS JourneyName,
    job.EmailName AS EmailName,
    s.EventDate AS SentDate,
    o.EventDate AS OpenDate,
    c.EventDate AS ClickDate,
    b.EventDate AS BounceDate,
    u.EventDate AS UnsubscribeDate
FROM
    _Sent AS s
    LEFT JOIN _Job AS job ON job.JobID = s.JobID
    LEFT JOIN _Open AS o ON
        o.JobID = s.JobID AND
        o.ListID = s.ListID AND
        o.BatchID = s.BatchID AND
        o.SubscriberID = s.SubscriberID AND
        o.IsUnique = 1
    LEFT JOIN _Click AS c ON
        s.JobID = c.JobID AND
        c.ListID = s.ListID AND
        c.BatchID = s.BatchID AND
        c.SubscriberID = s.SubscriberID AND
        c.IsUnique = 1
    LEFT JOIN _Bounce AS b ON
        s.JobID = b.JobID AND
        b.ListID = s.ListID AND
        b.BatchID = s.BatchID AND
        b.SubscriberID = s.SubscriberID AND
        b.IsUnique = 1
    LEFT JOIN _Unsubscribe AS u ON
        s.JobID = u.JobID AND
        u.ListID = s.ListID AND
        u.BatchID = s.BatchID AND
        u.SubscriberID = s.SubscriberID AND
        u.IsUnique = 1
    LEFT JOIN _JourneyActivity AS ja ON
        ja.JourneyActivityObjectID = s.TriggererSendDefinitionObjectID
    LEFT JOIN _Journey AS j ON
        j.VersionID = ja.VersionID
WHERE
    s.EventDate >= DATEADD(DAY, -1, GETDATE());

    /*  */

SELECT accountname, Estado_segun_Contrato, fecha_vto_ultimo_contrato, accountemail, email_contacto_tecnico, email_contacto_comercial
FROM Cuentas_Contratos

WHERE accountname LIKE '%Hiperinox%'

/*  */