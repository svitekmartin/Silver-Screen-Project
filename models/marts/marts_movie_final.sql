{{ config(materialized="table") }}

with

    sales_by_month as (select * from {{ ref("int_sales_by_month") }}),

    costs_by_month as (select * from {{ ref("int_invoices") }}),

    movie_catalogue as (select * from {{ ref("stg_movie_catalogue_cleaned") }})

select
    
    sales.month,
    sales.movie_id,
    sales.location_id,
    -- movie catalogue = mc
    mc.movie_title,
    mc.genre,
    mc.studio,
    sales.total_tickets_sold,
    sales.total_revenue,
    coalesce(costs.rental_cost, 0) as rental_cost

from sales_by_month as sales
left join
    costs_by_month as costs
    on sales.month = costs.month
    and sales.location_id = costs.location_id
    and sales.movie_id = costs.movie_id
left join movie_catalogue as mc on sales.movie_id = mc.movie_id
