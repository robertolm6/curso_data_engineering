{% set event_types = obtener_valores(ref('stg_sql_server_dbo__events'),'event_type') %}
WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__events') }}
    ),

stg_users AS(
    SELECT user_id, first_name, last_name, email
    FROM {{ref('stg_sql_server_dbo__users')}}
),

renamed_casted AS (
    SELECT
        session_id,
        a.user_id,
        first_name,
        last_name,
        email,
        min(created_at_utc) as first_event_time_utc,
        max(created_at_utc) as last_event_time_utc,
        datediff(minute, first_event_time_utc, last_event_time_utc) as session_lenght_minutes,
        {%- for event_type in event_types   %}
        sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
    FROM stg_events a
    inner join stg_users b
    on a.user_id=b.user_id
    GROUP BY 1,2,3,4,5
    )

SELECT * FROM renamed_casted