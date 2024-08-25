Select Id, Name, Cotizaciones_Totales__c From Account 
WHERE OwnerId = '0055f000004CQKRAA4' AND Cotizaciones_Totales__c > 0

/* 705 y  223 */


SELECT Id, Name, AccountId, CreatedDate, Account.OwnerId 
FROM Opportunity 
WHERE CreatedDate = THIS_YEAR 
AND Account.OwnerId = '0055f000004CQKRAA4'

/* 354 */


SELECT COUNT() 
FROM Account 
WHERE OwnerId = '0055f000004CQKRAA4'
/* 708 */

SELECT Name 
FROM SBQQ__Quote__c  
WHERE OwnerId  = '0055f000004CQKRAA4' AND CreatedDate = THIS_YEAR 
/* 286 */

SELECT Id, Name, 
Oportunidad__r.AccountId FROM SBQQ__Quote__c 
              WHERE OwnerId = '0055f000004CQKRAA4' 
              AND CreatedDate = THIS_YEAR

/* 286  incompleta */              


/* Promedio USD */
Opportunity.Importe_total__c:SUM / RowCount

/* % */
RowCount / PARENTGROUPVAL(RowCount, ROW_GRAND_SUMMARY , COLUMN_GRAND_SUMMARY)

ACCOUNT_NAME:UNIQUE
IF(B0#RowCount=0,0,B1#RowCount/B0#RowCount)
IF(B0#RowCount=0,0,B3#RowCount/B0#RowCount)

B1#ACCOUNT_NAME:UNIQUE/B0#RowCount
B2#ACCOUNT_NAME:UNIQUE/B0#RowCount