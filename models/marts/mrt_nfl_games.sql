with games_corrected as (

    select * from {{ ref('int_replace_scrambeled_scores')}}
),

stadiums as (

    select * from {{ ref('stg_nfl_stadiums')}}
),

teams as (

    select * from {{ ref('stg_nfl_teams')}}
),

states as (

    select * from {{ ref('stg_states')}}
),

calendar as (

    select * from {{ ref('stg_calendar')}}
),

nfl_games_final as (

    select 
        
        gam.*,
        case
            when gam.real_score_home > gam.real_score_away then team_home_name
            when gam.real_score_home < gam.real_score_away then team_away_name
            else 'tie'
            end as winner_team_name,
        case
            when gam.real_score_home > gam.real_score_away then teah.conference
            when gam.real_score_home < gam.real_score_away then teaa.conference
            else 'tie'
            end as winner_conference,
        case
            when gam.real_score_home > gam.real_score_away then teah.division
            when gam.real_score_home < gam.real_score_away then teaa.division
            else 'tie'
            end as winner_division,
        std.stadium_city,
        std.stadium_state,
        std.surface as stadium_surface,
        std.stadium_type,
        sta.state_name,
        sta.region,
        cal.month_name as month,
        cal.day_name as day

    from games_corrected gam

    -- joining the teams table two times to get the hometeam and the awayteam da
    left join teams teah on gam.home_teamid = teah.team_id
    left join teams teaa on gam.away_teamid = teaa.team_id
    left join stadiums std on gam.stadiumid = std.stadium_id
    left join states sta on std.stadium_state = sta.state_id
    left join calendar cal on gam.date = cal.date

)

select * from nfl_games_final