with source as (

    select * from {{ source('src_football', 'sd_teams') }}
),

nfl_teams as (

    select
        teamid as team_id,
        team_short,
        fullname as team_name,
        city as team_city,
        conference,
        division,
        stadiumid as stadium_id,
        offensive_schema,
        defensive_schema

    from source
)

select * from nfl_teams