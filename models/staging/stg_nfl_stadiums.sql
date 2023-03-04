with source as (

    select * from {{ source('src_football', 'sd_stadiums') }}
),

nfl_stadiums as (

    select
        stadiumid as stadium_id,
        stadium_name,
        stadium_city,
        stadium_state,
        stadium_country,
        stadium_capacity as capacity,
        stadium_surface as surface,
        stadium_type

    from source
)

select * from nfl_stadiums