{{ config(materialized="view") }}

select
INVOICE_ID,
LOCATION_ID,
MONTH,
inv.MOVIE_ID,
MOVIE_TITLE,
genre,
inv.STUDIO,
TOTAL_INVOICE_SUM as rental_cost,
WEEKLY_PRICE
from {{ source("silverscreen", "invoices") }} as inv
left join {{ ref("stg_movie_catalogue_cleaned") }} as mc on inv.movie_id = mc.movie_id

