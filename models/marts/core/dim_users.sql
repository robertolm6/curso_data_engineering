with 

source as (
    select * from {{ ref('stg_sql_server_dbo__users') }}
),

renamed as (
    select
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        address_id,
        created_at,
        updated_at,
        total_orders,
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed