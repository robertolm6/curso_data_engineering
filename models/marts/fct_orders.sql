{{ config(
    materialized='table',
    on_schema_change='fail'
    ) 
}}

WITH cte_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

cte_order_items AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo__order_items')}}
)

renamed as (
    select a.order_id, b.product_id, quantity, shipping_cost_dollars, order_cost_dollars, order_total_dollars
    from cte_orders a
    inner join cte_order_items b
    on a.order_id=b.order_id
)

select * from renamed