{{ 
  config(
    materialized="table", 
    alias="final",
    database="workspace", 
    schema="dw" 
  ) 
}}

with cte as (
    select * from {{ ref("revenues") }}
)

select 
    product,
    sum(total_revenue) as total_revenue
from cte
group by product