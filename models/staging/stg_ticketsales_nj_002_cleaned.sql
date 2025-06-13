{{ config(materialized="table") }}


with source as (

  select * from {{ source("silverscreen", "ticketsales_nj_002") }}

),

aggregated_002 as (

  select
    movie_id,
    date_trunc('month', DATE) as month,
    sum(ticket_amount) as total_tickets_sold,
    sum(TOTAL_EARNED) as total_revenue,
     -- Add a literal location_id for this source
    'NJ_002' as location_id
  from source
  group by movie_id, date_trunc('month', DATE),TOTAL_EARNED

)

select * from aggregated_002

