{{ config(materialized="table") }}

select
    mcl.movie_id,
    movie_title,
    genre,
    studio,
    mcl.month,
    location_id as location,
    rental_cost,
    total_tickets_sold as tickets_sold,
    total_revenue as revenue
from {{ ref("int_movie_costs_by_location") }} as mcl
left join {{ ref("int_ticketsales_nj_all") }} as tsa on mcl.movie_id = tsa.movie_id
