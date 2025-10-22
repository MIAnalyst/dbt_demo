{% macro collect_column_stats(schema_name, table_name) %}
  {% set relation = adapter.get_relation(
      database=target.database,
      schema=schema_name,
      identifier=table_name
  ) %}

  {# Get column names from information_schema #}
  {% set columns_query %}
    SELECT column_name
    FROM {{ target.database }}.{{ schema_name }}.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = '{{ table_name }}'
  {% endset %}

  {% set columns_result = run_query(columns_query) %}
  {% set columns = columns_result.columns[0].values() %}

  {% set stats_sql_parts = [] %}

  {# Build SQL expressions like COUNT(column), COUNT(DISTINCT column), COUNT(*) - COUNT(column) #}
  {% for col in columns %}
    {% set part %}
      COUNT({{ col }}) AS non_null_{{ col }},
      COUNT(*) - COUNT({{ col }}) AS null_{{ col }},
      COUNT(DISTINCT {{ col }}) AS distinct_{{ col }}
    {% endset %}
    {% do stats_sql_parts.append(part) %}
  {% endfor %}

  {% set final_sql %}
    SELECT {{ stats_sql_parts | join(',\n') }}
    FROM {{ relation }}
  {% endset %}

  {% set results = run_query(final_sql) %}
  {% set row = results.columns | zip(results.rows[0]) | dict %}

  {{ log("Column stats for " ~ table_name ~ ": " ~ row | tojson, info=True) }}

  {{ return(row) }}
{% endmacro %}
