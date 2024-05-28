with 

source_status as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_status as (

    select distinct
        case
            when status = 'active' then '1'
            when status = 'inactive' then '0'
        end as status_id,
        status as status_desc

    from source_status
)

select * from renamed_status
