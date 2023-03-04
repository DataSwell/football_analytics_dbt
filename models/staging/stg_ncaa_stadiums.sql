with source as (

    select * from {{ source('src_football', 'ncaa_stadiums') }}
),

ncaa_stadiums as (

    select
        stadiumid as stadium_id,
        stadium_name,
        stadium_city,
        stadium_state,
        stadium_active,
        stadium_dome

    from source
)

select * from ncaa_stadiums