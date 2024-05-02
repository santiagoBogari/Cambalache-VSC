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