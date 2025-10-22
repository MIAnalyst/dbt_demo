{% macro get_date_parts(date_column) %}
(
    -- This will give you a column `extract_date` of type STRUCT (nested object)
    -- It includes fields like year, month, day, etc.
  SELECT struct ( 
    {{ date_column }} AS original_date,
    EXTRACT(YEAR FROM {{ date_column }}) AS year,
    EXTRACT(MONTH FROM {{ date_column }}) AS month,
    EXTRACT(DAY FROM {{ date_column }}) AS day,
    EXTRACT(DAYOFWEEK FROM {{ date_column }}) AS day_of_week,
    EXTRACT(DAYOFYEAR FROM {{ date_column }}) AS day_of_year,
    EXTRACT(WEEK FROM {{ date_column }}) AS week,
    EXTRACT(QUARTER FROM {{ date_column }}) AS quarter
  ) AS extract_date
)
{% endmacro %}
