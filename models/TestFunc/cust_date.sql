{{ config(materlized='ephemeral')}}

select 
customer_id,
{{get_date_parts('created_at')}} as date_extrac
from
{{ ref('stg_customers')}} 