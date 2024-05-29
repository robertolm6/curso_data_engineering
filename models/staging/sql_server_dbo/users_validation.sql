with users as (

    select * from {{ ref('stg_sql_server_dbo__users') }}

),
    
validate_users_email as (

    select
        user_id,
        first_name,
        coalesce (regexp_like(first_name, '^[A-Z]{1}[a-z]*(\s)?([A-Z]{1}[a-z]*)?$')= true,false) as is_valid_first_name,
        last_name,
        coalesce (regexp_like(last_name, '^[A-Z]{1}[a-z]*(\s)?([A-Z]{1}[a-z]*)?$')= true,false) as is_valid_last_name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        phone_number,
        coalesce (regexp_like(phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')= true,false) as is_valid_phone_number
    from users

)

select * from validate_users_email