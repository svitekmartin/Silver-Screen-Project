WITH source AS (

    SELECT * FROM {{ source("silverscreen", "invoices") }}

)

SELECT
    
    date_trunc('month', month) as month,
    location_id,
    movie_id,
    SUM(total_invoice_sum) as rental_cost

FROM source
GROUP BY
    month,
    location_id,
    movie_id