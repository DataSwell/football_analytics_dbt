with source as (

    select * from {{ source('src_football', 'ncaa_games') }}
),

ncaa_games as (

    select
        gameid as game_id,
        season,
        season_type,
        week,
        status as game_status,
        day as date,
        away_teamid as away_team_id,
        away_team as away_team_short,
        away_team_name,
        home_teamid as home_team_id,
        home_team as home_team_short,
        home_team_name,
        away_team_score,
        home_team_score,
        point_spread,
        over_under,
        stadiumid as stadium_id,
        title as game_title

    from source
)

select * from ncaa_games