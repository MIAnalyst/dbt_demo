{{ config(materlized='ephemeral')}}

WITH customer_cte AS (
  SELECT 1 AS customer_id, 'Alice' AS first_name, 'Smith' AS last_name, 'alice@example.com' AS email, DATE('2023-06-01') AS created_at
  UNION ALL
  SELECT 2, 'Bob', 'Johnson', 'bob@example.com', DATE('2023-06-05')
  UNION ALL
  SELECT 3, 'Carol', 'Lee', 'carol@example.com', DATE('2023-07-10')
  UNION ALL
  SELECT 4, 'David', 'Kim', 'david@example.com', DATE('2023-08-15')
)

SELECT
  *
FROM customer_cte

