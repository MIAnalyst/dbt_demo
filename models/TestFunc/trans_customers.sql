{{ config(materlized='ephemeral')}}

select distinct first_name from {{ ref('stg_customers')}} 