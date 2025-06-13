-- This test ensures that the combination of month, location_id, and movie_id
-- in the int_monthly_sales model is unique, compensating for non-unique invoice data.
-- Any returned rows indicate duplicates and will cause the test to fail.

select month, location_id, movie_id, count(*) as count_duplicates
from {{ ref("int_sales_by_month") }}
group by 1, 2, 3
having count(*) > 1