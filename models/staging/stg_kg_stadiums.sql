with source as (

    select * from {{ source('src_football', 'kg_stadiums') }}
),

kg_stadiums as (

    select 
        stadium_name,
        stadium_location,
        -- get the state (GA) from the location value (Atlanta, GA)
        -- all states shortcuts are two characters, so it is possible to use a simple right string function
        right(stadium_location, 2) as stadium_state,
        stadium_open_year,
        stadium_close_year,
        stadium_type,
        stadium_capacity,
        stadium_surface

    from source
)

select * from kg_stadiums
