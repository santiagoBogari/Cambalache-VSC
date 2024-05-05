-- day 01

SELECT email, first_name, last_name
FROM [Nextmobile_Users]

-- day 02
SELECT id, internet_package
FROM [NextMobile_Packages]
WHERE internet_package <> 'Gigabit Fibe 1.5'     --internet_package != 'Gigabit Fibe 1.5'

-- day 03
SELECT COUNT(id) AS eligible_customers
FROM NextMobile__Usage
WHERE data_usage < 20

--day 04
SELECT 
    id, 
    points * 1.5 AS bonus_points
FROM [NextMobile Loyalty]
WHERE 
    points * 1.5 >= 150000

--day 05
SELECT id, 
email
FROM NextMobile_Services
Where internet = 'Fibe 500' OR mobility = 'Essential 120'

--day 06
SELECT id
FROM NextMobile_Community
Where is_active = 1 AND logged_12_months = 0

--day 07
SELECT 
    id,
    data_usage,
    data_plan
FROM [NextMobile_Usage]
WHERE 
    data_usage / data_plan BETWEEN 0.5 AND 0.75

--day 08
SELECT 
    id,
    data_plan
FROM [NextMobile_Plans]
WHERE
    data_plan IN ('Flex', 'Flex Plus', 'Essential')

--day 09
SELECT 
    id,email,role
FROM [NextMobile_Commercial]
WHERE
    role LIKE '%administrator%'

--day 10
SELECT 
    id,email,phone,role
FROM NextMobile_Commercial
WHERE phone IS NULL and role LIKE '%administrator%'

--day 11
SELECT TOP 50
    id , amount
FROM NextMobile_Spend
WHERE amount > 2000
ORDER BY amount DESC

--day 12
SELECT 
    status,
    COUNT(amount),
    SUM(amount)
FROM [NextMobile Orders_2023]
GROUP BY status

--day 13
SELECT 
    DISTINCT CONCAT_WS(',', address, city, state, postal_code, country)
FROM [NextMobile_Users]

--day 14
SELECT id, data_usage,
CASE
WHEN data_usage > 50 THEN 'Heavy'
WHEN data_usage > 25 THEN 'Moderate'
ELSE 'Light'

END AS user_type
    
FROM NextMobile_Usage
WHERE data_usage != 0

--day 15
SELECT 
    state,
    COUNT(id)
FROM NextMobile_Users
GROUP BY
    state
HAVING COUNT(id) > 50

--day 16
SELECT top 12
    MONTH(date),
    MIN(amount) as MinOrder,
    MAX(amount) as MaxOrder
    
FROM NextMobile_Orders_2023
WHERE status = 'shipped'
GROUP BY MONTH(date)
ORDER BY MONTH(date)

--day 17
SELECT id, launch_date
FROM Nextmobile_Users
WHERE launch_date >= DATEADD(DAY, -90, GETDATE()) 
AND launch_date < GETDATE()

--day 18
SELECT 
    order_id, 
    date AS order_date, 
    ship_date
FROM NextMobile_Orders_2023
WHERE 
    DATEDIFF(day, date, ship_date) > 7
    AND status = 'shipped'

--day 19
    SELECT top 4
    DATEPART(quarter, date) AS quarter,
    SUM(amount) AS total_sales
FROM NextMobile_Orders_2023
WHERE status = 'shipped'
GROUP BY DATEPART(quarter, date)
ORDER BY quarter

--day 20

SELECT 
    id, 
    launch_date,
    DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date) AS renewal_date
FROM 
    NextMobile_Users
WHERE
    DATEDIFF(DAY, GETDATE(), DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date)) BETWEEN 0 AND 30
    AND DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date) > GETDATE()

--day 21

SELECT 
     US.state, AVG(USG.data_usage) as average_data_usage
     
FROM   NextMobile_Users as US
    INNER JOIN NextMobile_Usage as USG on USG.id = US.id
GROUP BY US.state

--day 22

SELECT 
    DISTINCT u.id, 
    u.first_name, 
    u.last_name, 
    u.email
FROM [NextMobile_Users] u
JOIN [NextMobile_Orders] o ON u.id = o.customer_id
WHERE o.date BETWEEN DATEADD(day, -60, GETDATE()) AND DATEADD(day, -15, GETDATE())
AND o.status = 'shipped'

--day 23

SELECT
SRV.id, SRV.last_name, Resp.nps_score
FROM NextMobile_Survey as SRV
LEFT JOIN NextMobile_Survey_Responses as Resp on SRV.id = Resp.id

--day 24

SELECT
    id,
    nps_score
FROM   [NextMobile_Survey_Responses]
UNION
SELECT
    id,
    nps_score
FROM   [NextMobile_Survey_Responses_Sales]

--day 25

SELECT 
US.id, US.last_name
FROM NextMobile_Users as US

WHERE US.id IN (SELECT customer_id
    FROM NextMobile_Orders_2023
    GROUP BY customer_id
    HAVING SUM(amount) > 10000)

--day 26

SELECT 
 o.state, COUNT(o.order_id) AS order_count

FROM (
        SELECT o.order_id, u.state
        FROM NextMobile_Orders_2023 as o
        JOIN NextMobile_Users as u
        on o.customer_id = u.id
        WHERE o.status = 'shipped'
)AS o

GROUP BY o.state

--day 27

SELECT 
    id,
    email,
    o.eventdate AS opened,
    c.eventdate AS clicked
FROM [NextMobile_Users] u
LEFT JOIN   [NextMobile_Open] o
ON   o.subscriberkey = u.id
LEFT JOIN   [NextMobile_Click] c
ON  c.jobid = o.jobid AND c.subscriberkey = o.subscriberkey
WHERE
  o.jobid = '765452' OR o.jobid IS NULL

--day 28

SELECT
    COUNT(subscriberkey),
    domain,
    LEFT(SMTPBounceReason,100) AS BounceReason
FROM
    [NextMobile_Bounce]
WHERE
    eventdate BETWEEN '2024-02-01' AND '2024-02-29'
GROUP BY
    domain,
    LEFT(SMTPBounceReason,100)
HAVING
    COUNT(subscriberkey) > 1

--day 29

SELECT
    DATENAME(WEEKDAY, eventdate) AS day_of_week,
    COUNT(subscriberkey) AS unsubscribe_count
FROM
    NextMobile_Unsubscribe
GROUP BY
    DATENAME(WEEKDAY, eventdate)

--day 30

SELECT
    u.state,
    (SUM(CASE WHEN c.IsUnique = 1 THEN 1.0 ELSE 0 END) / (COUNT(s.SubscriberKey) - SUM(CASE WHEN b.IsUnique = 1 THEN 1.0 ELSE 0 END))) * 100 AS ctr
FROM
    [NextMobile_Users] u
JOIN 
    [NextMobile_Sent_2023] s 
ON
    u.id = s.SubscriberKey
LEFT JOIN
    [NextMobile Click_2023] c
ON
    s.SubscriberKey = c.SubscriberKey AND s.JobId = c.JobId
LEFT JOIN
    [NextMobile_Bounce_2023] b
ON
    s.SubscriberKey = b.SubscriberKey AND s.JobId = b.JobId    
WHERE
    s.EventDate >= '2023-01-01' 
    AND s.EventDate <= '2023-12-31' 
GROUP BY
    u.state