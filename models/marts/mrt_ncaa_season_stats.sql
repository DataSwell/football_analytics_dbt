with stats as (

    select * from {{ ref('stg_ncaa_teams_season')}}
),

teams as (

    select * from {{ ref('stg_ncaa_teams')}}
),

stadiums as (

    select * from {{ ref('stg_ncaa_stadiums')}}
), 

states as (

    select * from {{ ref('stg_states')}}
),

ncaa_season_stats as (

    select 
        stats.*,
        teams.conference,
        stadiums.stadium_dome,
        states.state_name,
        states.region as state_region

    from stats
    
    left join teams on stats.teamid = teams.team_id
    left join stadiums on teams.stadium_id = stadiums.stadium_id
    left join states on stadiums.stadium_state = states.state_id
)

select * from ncaa_season_stats