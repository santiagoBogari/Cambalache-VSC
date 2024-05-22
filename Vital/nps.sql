SELECT 
RESP_1, ROLE_1, RESP_2, ROLE_2, RESP_3, ROLE_3, RESP_4, ROLE_4, RESP_5, MONTH(FECHA) 
AS MES, YEAR(FECHA) AS AÑO, SUCURSAL, ID, SUBSCRIBERKEY 
FROM NPS_POSTCOMPRA
_____________________________________________________________________________________
/* Automation Procesamiento_NPS */
/* Query 1 - DE NPS_PROCESADO*/
SELECT 
    B.PERSONEMAIL AS EMAIL,
    CASE
    WHEN CHARINDEX('.',B.NAME) = 1 THEN UPPER(SUBSTRING(B.NAME, 2, LEN(B.NAME)))
    ELSE UPPER(B.NAME)
    END AS NOMBRE,
    B.ID AS SUBSCRIBERKEY,
    NEWID() AS ID,
    A.DESCRIPCION_SUCURSAL AS SUCURSAL
FROM 
(SELECT
    ID_CLIENTE_TOPGROUP,
    ID_DOCUMENTO_TRX,
    DESCRIPCION_SUCURSAL,
    FECHA_DE_DOCUMENTO
  FROM
    CABECERAS_VENTAS WHERE CANAL_DE_VENTA LIKE 'SA') A
LEFT JOIN Personas B
ON CONVERT(INT,A.ID_CLIENTE_TOPGROUP) = B.ID_TOPGROUP
WHERE
    B.PERSONEMAIL IS NOT NULL  AND DATEDIFF(DAY, FECHA_DE_DOCUMENTO, GETDATE()) = 1
GROUP BY
    B.PERSONEMAIL,
    B.NAME,
    B.ID,
    A.DESCRIPCION_SUCURSAL

/*  Query 2 - DE NPS_ENVIADO*/
SELECT 
    su.emailaddress AS EMAIL,
    su.subscriberkey AS SUBSCRIBERKEY
FROM   [_sent] AS s
    INNER JOIN [_journeyactivity] AS ja
        ON s.triggerersenddefinitionobjectid = ja.journeyactivityobjectid
    INNER JOIN [_journey] AS j
        ON ja.versionid = j.versionid
    INNER JOIN [_subscribers] AS su
        ON s.subscriberid = su.subscriberid
WHERE 
    s.eventdate > Dateadd(day, -90, Getdate()) AND ja.activitytype in ('EMAIL','EMAILV2') AND j.journeyname = 'NPS'

 /* Query 3 - DE NPS_ENVIAR  */   
 SELECT 
    A.NOMBRE,
    A.EMAIL,
    A.SUBSCRIBERKEY,
    A.ID,
    A.SUCURSAL
FROM
    NPS_PROCESADO A
LEFT JOIN
    NPS_ENVIADO B
    ON A.SUBSCRIBERKEY = B.SUBSCRIBERKEY
WHERE
    B.SUBSCRIBERKEY IS NULL

/*  */ 
SELECT SUBSCRIBERKEY, ROLE_1, FECHA

FROM NPS_POSTCOMPRA

WHERE FECHA > '5/1/2024'
/* (749 rows) */   