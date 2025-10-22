-- Test to check if there are records created  today
select count(*) as num_created_today
from {{ ref('stg_customers') }}
where created_at = CURRENT_DATE()
having count(*) > 0