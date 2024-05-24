
{{
  config(
    materialized='view'
  )
}}

with 

source_users as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed_users as (

    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted as deleted,
        _fivetran_synced as date_load

    from source_users

)

select * from renamed_users
