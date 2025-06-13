{{ config(materialized="table") }}

with source as (

  select * from {{ source("silverscreen", "ticketsales_nj_001") }}

),

aggregated_001 as (
select
    movie_id,
    date_trunc('month', timestamp) as month,
    sum(ticket_amount) as total_tickets_sold,
    sum(transaction_total) as total_revenue,
    -- Add a literal location_id for this source
    'NJ_001' as location_id
from source
group by movie_id, date_trunc('month', timestamp)
order by month, movie_id
)

select * from aggregated_001
