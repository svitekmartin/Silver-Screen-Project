{{ config(materialized="table") }}

with source as (

  select * from {{ source("silverscreen", "ticketsales_nj_003") }}

),

aggregated_003 as (
 SELECT
  details AS movie_id,
  DATE_TRUNC('month', timestamp) AS month,
  amount AS total_tickets_sold,
  total_value AS total_revenue,
   -- Add a literal location_id for this source
   'NJ_003' as location_id

FROM source
WHERE product_type = 'ticket'
  AND details IS NOT NULL
)
select *
from aggregated_003


