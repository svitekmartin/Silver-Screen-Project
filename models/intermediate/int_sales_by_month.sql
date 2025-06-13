{{ config(materialized="table") }}

with

    total_sales_nj001 as (

        select
            month,
            location_id,
            movie_id,
            sum(total_tickets_sold) as total_tickets_sold,
            sum(total_revenue) as total_revenue
        from {{ ref("stg_ticketsales_nj_001_cleaned") }}
        group by 1, 2, 3
    ),

    total_sales_nj002 as (
        -- No aggregation needed 
        select month, location_id, movie_id, total_tickets_sold, total_revenue
        from {{ ref("stg_ticketsales_nj_002_cleaned") }}
    ),

   total_sales_nj003 as (
        select
            month,
            location_id,
            movie_id,
            sum(total_tickets_sold) as total_tickets_sold,
            sum(total_revenue) as total_revenue
        from {{ ref("stg_ticketsales_nj_003_cleaned") }}
        group by 1, 2, 3
    ),

    combined_sales as (
        select *
        from total_sales_nj001
        union all
        select *
        from total_sales_nj002
        union all
        select *
        from total_sales_nj003
    )

select *
from combined_sales