-- models/revenues_ephemeral.sql
{{
  config(materialized="ephemeral")
}}

with base as (
  select t.product, t.unitprice, f.country, t.quantity, t.totalprice
  from {{ source("bakehouse", "sales_transactions") }} t
  left join {{ source("bakehouse", "sales_franchises") }} f
    on t.franchiseid = f.franchiseid
),
aggregated as (
  select
    product,
    unitprice,
    country,
    sum(quantity)   as total_quantity,
    sum(totalprice) as total_revenue
  from base
  group by product, unitprice, country
)
select * from aggregated
