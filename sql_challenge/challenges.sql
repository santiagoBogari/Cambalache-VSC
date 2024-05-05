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
