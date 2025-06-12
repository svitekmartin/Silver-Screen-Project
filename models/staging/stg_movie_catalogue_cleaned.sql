{{ config(materialized="view") }}

select
    movie_id,
    movie_title,
    release_date,
    coalesce(genre, 'Unknown') as genre,
    country,
    studio,
    budget,
    director,
    coalesce(rating, 'Unknown') as rating,
    COALESCE(minutes, 0) as minutes	

from {{ source("silverscreen","movie_catalogue") }}
