/* Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date(on the same order date or after it).
If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it's called scheduled.

Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
The query result format is in the following example:

Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+

Result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
The orders with delivery id 2 and 3 are immediate while the others are scheduled. */

# 1. Using single query
SELECT ROUND(100*(COUNT(delivery_id)/(SELECT COUNT(delivery_id) FROM delivery)),2) AS 'immediate_percentage' 
FROM Delivery WHERE order_date = customer_pref_delivery_date

# 2. Using CTE(WITH)
WITH immediate_pt AS (
    SELECT COUNT(delivery_id) AS ct
    FROM Delivery
    WHERE order_date = customer_pref_delivery_date
)
SELECT round(100*(ct / (SELECT COUNT(delivery_id) from Delivery)), 2) AS 'immediate_percentage' FROM immediate_pt
  
# 3. Using CASE WHEN
SELECT
ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)/COUNT(delivery_id),2) AS 'immediate_percentage'
FROM Delivery
