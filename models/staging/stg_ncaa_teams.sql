with source as (

    select * from {{ source('src_football', 'ncaa_teams') }}
),

ncaa_teams as (

    select
        teamid as team_id,
        school,
        name as team_name,
        active,
        conferenceid as conference_id,
        conference,
        stadiumid as stadium_id

    from source
)

select * from ncaa_teams