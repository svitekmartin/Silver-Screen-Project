{{ config(materialized="table") }}

 SELECT
  details AS movie_id,
  DATE_TRUNC('month', timestamp) AS month,
  COUNT(transaction_id) AS total_tickets_sold,
  SUM(amount) AS total_revenue
FROM {{ source("silverscreen", "ticketsales_nj_003") }}
WHERE product_type = 'ticket'
  AND details IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, 2


