
{{
  config(
    materialized='view'
  )
}}

WITH src_budget_reduced AS (
    select *
        from {{ref('stg_google_sheets__budget')}}
    ),

renamed_budget_reduced AS (
    SELECT
          product_id
        , quantity
        , month
    FROM src_budget_reduced
    )

SELECT * FROM renamed_budget_reduced