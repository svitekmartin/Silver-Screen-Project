{{ config(materialized="table") }}


with source as (

  select * from {{ source("silverscreen", "ticketsales_nj_002") }}

),

aggregated as (

  select
    movie_id,
    date_trunc('month', DATE) as month,
    sum(ticket_amount) as total_tickets_sold,
    sum(TOTAL_EARNED) as total_revenue,
  from source
  group by movie_id, date_trunc('month', DATE)

)

select * from aggregated

