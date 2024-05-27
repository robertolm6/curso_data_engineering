with 

source_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed_events as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,
        _fivetran_deleted,
        _fivetran_synced

    from source_events

)

select * from renamed_events
