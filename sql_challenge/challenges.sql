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
