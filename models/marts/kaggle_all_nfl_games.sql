with kg_games as (

    select * from {{ ref('stg_kg_games')}}
),

kg_teams as (

    select * from {{ ref('stg_kg_teams')}}
),

kg_stadiums as (

    select * from {{ ref('stg_kg_stadiums')}}
),

kg_all_games as (

    select 
        kgg.*,
        case 
            when kgg.home_or_away_win = 'Hometeam win' and kgth.team_id = kgg.team_favorite_id then 'yes'
            else 'no'
            end as favorite_win,
        case
            when kgg.home_or_away_win = 'Hometeam win' then kgth.team_id
            else kgta.team_id
            end as winner_team_id,
        case
            when kgg.home_or_away_win = 'Hometeam win' then kgth.team_conference
            else kgta.team_conference
            end as winner_team_conference_post_2002,
        case
            when kgg.home_or_away_win = 'Hometeam win' then kgth.team_division
            else kgta.team_division
            end as winner_division_post_2002,
        case
            when kgg.home_or_away_win = 'Hometeam win' then kgth.team_conference_pre2002
            else kgta.team_conference_pre2002
            end as winner_conference_pre_2002,
        case
            when kgg.home_or_away_win = 'Hometeam win' then kgth.team_division
            else kgta.team_division
            end as winner_division_pre_2002,
        kgth.team_id as home_team_id,
        kgth.team_conference as home_conference_post_2002,
        kgth.team_division as home_division_post_2002,
        kgth.team_conference_pre2002 as home_conference_pre_2002,
        kgth.team_division_pre2002 as home_division_pre_2002,
        kgta.team_id as away_team_id,
        kgta.team_conference as away_conference_post_2002,
        kgta.team_division as away_division_post_2002,
        kgta.team_conference_pre2002 as away_conference_pre_2002,
        kgta.team_division_pre2002 as away_division_pre_2002,
        kgs.stadium_state,
        kgs.stadium_type,
        kgs.stadium_surface

    from kg_games kgg

    -- joining the teams table two times to get the hometeam and the awayteam data
    left join kg_teams kgth on kgg.team_home = kgth.team_name
    left join kg_teams kgta on kgg.team_away = kgta.team_name
    left join kg_stadiums kgs on kgg.stadium_name = kgs.stadium_name
)

select * from kg_all_games