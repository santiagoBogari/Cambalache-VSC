-- ej.1
SELECT salesman.name, customer.cust_name, salesman.city
FROM salesman, customer
WHERE salesman.city = customer.city

/* https://www.w3resource.com/sql-exercises/sql-joins-exercises.php#SQLEDITOR 
ej.2 */

SELECT  a.ord_no, a.purch_amt, b.cust_name, b.city 
FROM orders a, customer b 
WHERE a.customer_id = b.customer_id 
AND a.purch_amt BETWEEN 500 AND 2000;

SELECT orders.ord_no, orders.purch_amt, customer.cust_name, customer.city
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
WHERE orders.purch_amt BETWEEN 500 AND 2000;

-- ej.3

SELECT a.cust_name AS "Customer Name", 
       a.city, 
       b.name AS "Salesman", 
       b.commission 
FROM customer a
INNER JOIN salesman b
ON a.salesman_id = b.salesman_id 

-- ej.4

SELECT a.cust_name AS "Customer Name", a.city AS "customer city", b.name AS "Salesman", b.commission
FROM customer a
INNER JOIN salesman b
ON a.salesman_id = b.salesman_id 
WHERE b.commission > 0.12

-- ej.5

SELECT a.cust_name AS "Customer Name", a.city AS "customer city", b.name AS "Salesman",b.city AS "salesman city", b.commission
FROM customer a
INNER JOIN salesman b
ON a.salesman_id = b.salesman_id 
WHERE b.commission > 0.12 AND a.city <> b.city

-- ej.6

SELECT a.ord_no, a.ord_date, a.purch_amt, 
       b.cust_name AS "Customer Name", b.grade, 
       c.name AS "Salesman", c.commission
FROM orders a
INNER JOIN customer b 
ON a.salesman_id = b.salesman_id 
INNER JOIN salesman c
ON a.salesman_id = c.salesman_id 

-- ej.7

__________________________________________________________________
SELECT
    Client_id,
    CAST(AVG(CONVERT(DECIMAL, monto_cobrado)) AS DECIMAL(18, 2)) AS TicketProm_Last60_GO
FROM Base_Barracuda_Data
WHERE order_type = 'GO'
AND fecha_orden_mioxxo >= DATEADD(day, -60, GETDATE())
GROUP BY Client_id