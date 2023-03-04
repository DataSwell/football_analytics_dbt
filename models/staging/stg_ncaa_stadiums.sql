with source as (

    select * from {{ source('src_football', 'ncaa_stadiums') }}
    )

select * from source