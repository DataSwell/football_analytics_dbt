with source as (

    select * from {{ source('src_football', 'sd_team_stats') }}
),

nfl_team_stats as (

    select
        -- create unique surrogate key for each standing per season, seasontype, team and games
        concat_ws('-', season, season_type,teamid, games) as team_stat_id,
        season,
        season_type,
        teamid as team_id,
        team as team_short,
        team_name,
        games as games_played,
        score,
        opponent_score,
        score_q1 as score_1_quarter,
        score_q2 as score_2_quarter,
        score_q3 as score_3_quarter,
        score_q4 as score_4_quarter,
        score_overtime,
        time_of_possession, -- in varchar format mm:ss
        -- cast (substring minutes) to int, multiplie by 60 + casted seconds
        (cast(substring(time_of_possession,1,2) as int) * 60) + cast(substring(time_of_possession,4,2) as int) as time_of_possession_in_seconds,
        opponent_score_q1 as opponent_score_1_quarter,
        opponent_score_q2 as opponent_score_2_quarter,
        opponent_score_q3 as opponent_score_3_quarter,
        opponent_score_q4 as opponent_score_4_quarter,
        opponent_score_overtime,
        opponent_time_of_possession,
        (cast(substring(opponent_time_of_possession,1,2) as int) * 60) + cast(substring(opponent_time_of_possession,4,2) as int) as opponent_time_of_possession_in_seconds,
        times_sacked_percentage

    from source
    
)

select * from nfl_team_stats