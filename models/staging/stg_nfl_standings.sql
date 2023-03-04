with source as (

    select * from {{ source('src_football', 'sd_standings') }}
),

nfl_standings as (

    select
        -- create unique surrogate key for each standing per season, seasontype, team and week
        concat_ws('-', season, season_type, week, teamid),
        season,
        season_type,
        week as game_week,
        teamid as team_id,
        team as team_short,
        name as team_name,
        conference,
        division,
        wins,
        losses,
        ties,
        percentage as win_percentage,
        points_for,
        points_against,
        net_points,
        touchdowns,
        division_wins,
        division_losses,
        division_ties,
        division_rank,
        conference_wins,
        conference_losses,
        conference_ties,
        conference_rank

    from source
)

select * from nfl_standings