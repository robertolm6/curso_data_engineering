
with 

source_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        md5(promo_id) as promo_id,
        promo_id as promo_name,
        discount as discount_dollars,
        case
            when status = 'active' then '1'
            when status = 'inactive' then '0'
        end as status_id,
        _fivetran_deleted,
        _fivetran_synced

    from source_promos

),

new_row as(
    select
        md5('no promo') as promo_id,
        'no promo' as promo_name,
        0 as discount_dollars,
        '0' as status,
        null as _fivetran_deleted,
        current_timestamp as _fivetran_synced
)

select * from
    (select * from renamed_promos
    where _fivetran_deleted is null or _fivetran_deleted = false
    union all 
    select* from new_row)