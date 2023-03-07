with source as (

    select * from {{ source('src_football', 'sd_standings') }}
),

nfl_standings as (

    select
        -- create unique surrogate key for each standing per season, seasontype, team and week
        concat_ws('-', season, season_type, week, teamid) as standings_id,
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

    -- the raw data contains duplicated data for oone game week. The data for game_week 18 is duplicated.
    -- the duplicates contain the value -26
    where week <> -26
)

select * from nfl_standings