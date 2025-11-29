-- Check payment status
SELECT p.package_id,
       CASE WHEN p.payment_date IS NULL THEN 'N' ELSE 'Y' END AS payment_status,
       CASE WHEN d.delivered_date IS NULL THEN 'N' ELSE 'Y' END AS delivery_status
FROM payments p
LEFT JOIN deliveries d
ON p.package_id = d.package_id;

-- Use ROW_NUMBER to detect first payment entry.

SELECT * FROM (select * ,
row_number() over(partition by dsp_id order by payment_date asc) as first_payment_row
from dsp_payments) t where first_payment_row = 1;

-- Calculate % of delayed payments
SELECT 
    COUNT(*) AS total_packages,
    SUM(CASE WHEN payment_date IS NULL THEN 1 ELSE 0 END) AS delayed_payments,
    ROUND(SUM(CASE WHEN payment_date IS NULL THEN 1 ELSE 0 END)*100.0 / COUNT(*), 2) AS pct_delayed
FROM payments;

-- Aggregate report example
SELECT EXTRACT(MONTH FROM payment_date) AS month,
       COUNT(*) AS total_payments,
       SUM(amount) AS total_amount
FROM payments
WHERE payment_date IS NOT NULL
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY month;

