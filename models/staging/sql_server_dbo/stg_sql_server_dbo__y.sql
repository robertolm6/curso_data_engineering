{{
  config(
    materialized='view'
  )
}}

with 

source_users_addresses as (

    select * from {{ref('stg_sql_server_dbo__users')}} a
             inner join {{ref('stg_sql_server_dbo__addresses')}} b
             on a.address_id = b.address_id

),

renamed_users_addresses as (

    select
        country,
        state,
        last_name,
        first_name,
        email,
        phone_number

    from source_users_addresses

)

select * from renamed_users_addresses
