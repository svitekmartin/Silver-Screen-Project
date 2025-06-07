{{ config(materialized="table") }}

select
    movie_id,
    date_trunc('month', timestamp) as month,
    sum(ticket_amount) as total_tickets_sold,
    sum(transaction_total) as total_revenue
from {{ source("silverscreen", "ticketsales_nj_001") }}
group by movie_id, date_trunc('month', timestamp)
order by month, movie_id

