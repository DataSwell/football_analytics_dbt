with source as (

    select * from {{ source('src_football', 'ncaa_teams_season') }}
    )

select * from source