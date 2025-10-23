{{ config(materialized='table', alias='revenues') }}

with base as (
    select
        t.product,
        t.unitPrice,
        f.country,
        t.quantity,
        t.totalPrice
    from {{ source('bakehouse', 'sales_transactions') }} t
    left join {{ source('bakehouse', 'sales_franchises') }} f
      on t.franchiseID = f.franchiseID
),
aggregated as (
    select
        product,
        unitPrice,
        country,
        sum(quantity)    as total_quantity,
        sum(totalPrice)  as total_revenue
    from base
    group by product, unitPrice, country
)

select * from aggregated
;
