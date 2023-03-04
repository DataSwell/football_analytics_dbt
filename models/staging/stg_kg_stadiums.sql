with source as (

    select * from {{ source('src_football', 'kg_stadiums') }}
),

kg_stadiums as (

    select 
        stadium_name,
        stadium_location,
        stadium_open_year,
        stadium_close_year,
        stadium_type,
        stadium_capacity,
        stadium_surface

    from source
)

select * from kg_stadiums
