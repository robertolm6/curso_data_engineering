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
),

cte_promos AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo__promos')}}
),

cte_products AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo__products')}}
),

renamed as (
    select a.order_id, b.product_id, name, price, quantity, discount_dollars, shipping_cost_dollars, order_cost_dollars, order_total_dollars
    from cte_orders a
    inner join cte_order_items b
    on a.order_id=b.order_id
    inner join cte_promos c
    on a.promo_id=c.promo_id
    inner join cte_products d
    on b.product_id=d.product_id
)

select * from renamed