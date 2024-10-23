/* ⚡ SQL Power-Up: Week 1 Exercise 1 Ready – Finish & Earn Points! */

SELECT 
FirstName,LastVisitedDate,LastBookingAmount,LoyaltyTier, EmailOptOut, SMSOptOut,
UPPER(InterestedProperty) AS Property,
CASE
    WHEN LoyaltyTier = 'Gold' THEN CONCAT(UPPER(LEFT(LoyaltyTier, 4)), '-10OFF')
    WHEN LoyaltyTier = 'Platinum' THEN CONCAT(UPPER(LEFT(LoyaltyTier, 4)), '-15OFF')
END AS DiscountOffer
/* 
●	Gold and Platinum Tiers
●	Visited Casino Royale and MGM Grand properties within the last 6 months
●	Last booking amount more than $7,000
●	Excluding customers that are opted out from either Email or SMS communications
*/

FROM ZdlxLy63

WHERE
(LoyaltyTier = 'Gold' OR LoyaltyTier = 'Platinum')
AND
LastVisitedDate >= DATEADD(month, -6, GETDATE())
AND
LastBookingAmount > 7000
AND 
(EmailOptOut = 'FALSE' OR SMSOptOut = 'FALSE')

/* Vince solution */

SELECT      ContactKey,
            FirstName,
            LastName,
            LoyaltyTier,
            LastVisitedDate,
            InterestedProperty,
            UPPER(InterestedProperty) AS InterestedPropertyCAPS,
            LastBookingAmount,
            EmailOptOut,
            SMSOptOut,
            CASE
                WHEN LoyaltyTier = 'Gold' THEN 'GOLD-10OFF'
                ELSE 'PLAT-15OFF'
            END AS 'DiscountCode'
FROM        [LEEJXQUa]
/* AUDIENCE CRITERIA */

/* TIER MEMBERSHIP INCLUSION */
WHERE       LoyaltyTier IN ('Gold', 'Platinum')

/* LAST VISITED PROPERTY WITHIN 6 MONTHS */
AND         InterestedProperty IN ('Casino Royale','MGM Grand')
AND         LastVisitedDate >= DATEADD(Month, -6, GETDATE())

/* LAST BOOKING AMOUNT FILTER */
AND         LastBookingAmount > 7000

/* CONSENT EXCLUSIONS */
AND         EmailOptOut = 0
AND         SMSOptOut = 0

/*  */

/* Week 1: Sample Brief Exercise 2 - FitLife Gym & Wellness Center*/

SELECT
    ContactKey,
    FirstName,
    LastName,
    MembershipTier,
    LastVisitDate,
    ClassesAttended,
    EmailOptOut,
    SMSOptOut,
    InterestedInOnlineClasses,
    InterestedInWellness,
    AttendedInPersonClasses,
    CASE 
        WHEN ClassesAttended > 15 AND LastVisitDate >= DATEADD(Month, -6, GETDATE()) THEN 'A'
        WHEN InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0 THEN 'B'
        WHEN InterestedInWellness = 1 AND AttendedInPersonClasses = 1 THEN 'C'
        WHEN MembershipTier IN ('Platinum', 'Diamond') THEN 'D'
        ELSE 'D'
    END AS Segment,
    CASE 
        WHEN MembershipTier = 'Gold' THEN 'GOLD-10OFF'
        WHEN MembershipTier = 'Platinum' THEN 'PLAT-10OFF'
        WHEN MembershipTier = 'Diamond' THEN 'DIAM-10OFF'
    END AS Discount
FROM 
    [FitnessGym_Members]
WHERE
    (MembershipTier IN ('Gold', 'Platinum', 'Diamond') AND ClassesAttended > 10)
    OR
    (InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0)
    OR
    (MembershipTier IN ('Platinum', 'Diamond') AND LastVisitDate >= DATEADD(Day, -90, GETDATE()))

    /* Vince solution */

    SELECT  ContactKey,
                FirstName,
                LastName,
                MembershipTier,
                LastVisitDate,
                ClassesAttended,
                EmailOptOut,
                SMSOptOut,
                InterestedInOnlineClasses,
                InterestedInWellness,
                AttendedInPersonClasses,
                UPPER(LEFT(MembershipTier,4)) + '-10OFF' AS DiscountCode,
                CASE
                    WHEN ClassesAttended > 15 THEN 'A'
                    WHEN InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0 THEN 'B'
                    WHEN InterestedInWellness = 1 AND AttendedInPersonClasses = 1 THEN 'C'
                    ELSE 'D'
                END AS 'Segment'
FROM            [mKbM7B4V]

/* AUDIENCE 1 */
WHERE           (
                    MembershipTier IN ('Gold','Platinum','Diamond')
                    AND             
                    ClassesAttended > 10
                )
                
/* AUDIENCE 2 */
OR              (
                    (InterestedInOnlineClasses = 1 OR InterestedInWellness = 1)
                    AND
                    AttendedInPersonClasses = 0
                )

/* AUDIENCE 3 */


/* ------------------------------------- */

/* DE-DEUPLICATION VIA ROW_NUMBER FUNCTION */
/*COPY AND PASTE THE BELOW SQL CODE SNIPPET */

/* PARTITION BY ONE FIELD */
SELECT	X.*
FROM    (
		SELECT	CustomerID,
	          	TransactionDate,
	          	TransactionAmount,          
	          	ROW_NUMBER() OVER (PARTITION BY CustomerID
						ORDER BY TransactionDate DESC) AS RowNum
		FROM    [Orders]            
	) X
WHERE	X.RowNum = 1


/* PARTITION BY TWO FIELDS */
SELECT	X.*
FROM    (
		SELECT	CustomerID,
	          	TransactionDate,
	          	TransactionAmount,          
	          	ROW_NUMBER() OVER (PARTITION BY CustomerID, PhoneID
						ORDER BY TransactionDate DESC) AS RowNum
		FROM    [Orders]            
	) X
WHERE	X.RowNum = 1


/* Sample Brief Exercise 1: Loyalty Program Promotional Offer */
SELECT 
    M.MemberID, 
    M.Email, 
    M.LoyaltyTier, 
    Tra.TransactionDate, 
    Tra.TransactionAmount
FROM 
    [Members_DE] M
INNER JOIN 
    Transactions_DE Tra 
    ON Tra.MemberID = M.MemberID 
WHERE 
    M.LoyaltyTier IN ('Bronze', 'Silver', 'Gold')
    AND Tra.TransactionAmount > 500 
    AND Tra.TransactionDate > DATEADD(month, -3, GETDATE())
    AND NOT EXISTS (
        SELECT 1
        FROM [Exclusions_DE] Exc
        WHERE Exc.MemberID = M.MemberID 
    )
    AND NOT EXISTS (
        SELECT 1
        FROM [OfferRedemptions_DE] Red
        WHERE Red.MemberID = M.MemberID 
        AND Red.RedemptionDate > DATEADD(month, -6, GETDATE())
    )

    /* Vince solution */

SELECT      Member.*
FROM        [Members_DE] Member

/* CAMPAIGN CRITERIA */
WHERE       Member.LoyaltyTier IN ('Bronze', 'Silver', 'Gold')

/* MEMBERS WHO HAVE A SINLGE TRANSACTION OVER $500 IN THE LAST 3 MONTHS */
AND         EXISTS (    SELECT  1
                        FROM    [Transactions_DE] Txn
                        WHERE   Member.MemberID = Txn.MemberID
                        AND     Txn.TransactionAmount > 500
                        AND     Txn.TransactionDate >= DATEADD(M,-3, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'AUS Eastern Standard Time'))
                        
/* EXCLUDING MEMBERS IN THE EXCLUSION DE */
AND         NOT EXISTS (    SELECT  1
                            FROM    [Exclusions_DE] Ex
                            WHERE   Member.MemberID = Ex.MemberID   )

/* EXCLUDING MEMBERS WHO HAVE REDEEMED AN OFFER IN THE LAST 6 MONTHS */
AND         NOT EXISTS (    SELECT  1
                            FROM    [OfferRedemptions_DE] OfferRed
                            WHERE   Member.MemberID = OfferRed.MemberID
                            AND     OfferRed.RedemptionDate >= DATEADD(M,-6, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'AUS Eastern Standard Time'))

/*  */