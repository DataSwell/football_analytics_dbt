with games as (

    select * from {{ ref('stg_ncaa_games')}}
),

stadiums as (

    select * from {{ ref('stg_ncaa_stadiums')}}
), 

teams as (

    select * from {{ ref('stg_ncaa_teams')}}
),

states as (

    select * from {{ ref('stg_states')}}
),

calendar as (

    select * from {{ ref('stg_calendar')}}
),


ncaa_football as (

    select
        gam.*,
        case 
            when gam.away_team_score > gam.home_team_score then 'away win'
            when gam.away_team_score < gam.home_team_score then 'home win'
            else 'tie'
            end as home_or_away_win,
        case 
            when gam.away_team_score > gam.home_team_score then gam.away_team_id
            when gam.away_team_score < gam.home_team_score then gam.home_team_id
            else null
            end as winner_team_id,
        teaa.conference as away_team_conference,
        teah.conference as home_team_conference,
        case
            when gam.away_team_score > gam.home_team_score then teaa.conference
            when gam.away_team_score < gam.home_team_score then teah.conference
            else 'tie'
            end as winner_conference, 
        std.stadium_name,
        std.stadium_dome,
        std.stadium_state,
        sta.state_name,
        sta.region,
        cal.month_name as month,
        cal.day_name as day

    from games gam

    -- joining the teams table two times to get the hometeam and the awayteam data
    left join teams teah on gam.home_team_id = teah.team_id
    left join teams teaa on gam.away_team_id = teaa.team_id
    left join stadiums std on gam.stadium_id = std.stadium_id
    left join states sta on std.stadium_state = sta.state_id
    left join calendar cal on gam.date = cal.date

)

select * from ncaa_football