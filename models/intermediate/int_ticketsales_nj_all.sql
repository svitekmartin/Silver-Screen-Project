
{{ config(materialized="view") }}

SELECT *
from {{ ref('stg_ticketsales_nj_001_cleaned') }}
UNION 
SELECT * from {{ ref('stg_ticketsales_nj_002_cleaned') }}
UNION 
SELECT * from {{ ref('stg_ticketsales_nj_003_cleaned') }}