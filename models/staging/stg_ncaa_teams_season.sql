with source as (

    select * from {{ source('src_football', 'ncaa_teams_season') }}
),

ncaa_teams_seasons as (

    select
        *
    from source
)

select * from ncaa_teams_season