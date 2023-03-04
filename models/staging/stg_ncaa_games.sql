with source as (

    select * from {{ source('src_football', 'ncaa_games') }}
    )

select * from source