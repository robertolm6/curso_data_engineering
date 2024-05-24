
{{
  config(
    materialized='view'
  )
}}

with 

source_order_items as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed_order_items as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted as deleted,
        _fivetran_synced as date_load

    from source_order_items

)

select * from renamed_order_items
