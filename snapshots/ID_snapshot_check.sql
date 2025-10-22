{% snapshot ID_snapshot_check %}

{{
  config(
    target_schema='snapshots',
    strategy='check',
    unique_key='customer_id',
    check_cols=['created_at'],
  )
}}

select * from {{ref("stg_customers")}}

{% endsnapshot %}
