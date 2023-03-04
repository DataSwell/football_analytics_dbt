with source as (

    select * from {{ source('src_football', 'ncaa_teams') }}
    )

select * from source