/*
Some of the game scores in the NFL data are scrambeled by the provider. That means, if you use only a free account, 
the data differ from the actual results. Therefore we use the kaggle data set, which privides us the correct game scores.
We have to map the scores from kaggle with the ones from SportsData API.


sd_teams: team_short = ARI, team_name = Arizona Cardinals
kg_teams:  team_name = Arizona Cardinals, team_id = ARI !!! not unique, because 3x WAS (Redskins, Team, Commanders). 

But if we use fullname some games can not be matched, because in the SD-API data team table, only exists Commanders no Redskins or Team. 
They treated the slowly changing dimension by overwriting the full team name. Kaggle geneated for every full name a new row.


sd_games: home_team_id = 1 or home_team = ARI
kg_games: team_home = Arizona Cardinals

*/

with sd_games as (

    select * from {{ ref('stg_nfl_games')}}
),


kg_games as (

    select * from {{ ref('stg_kg_games')}}
),

kg_teams as (

    select * from {{ ref('stg_kg_teams')}}
),

-- CTE to map the team_id (ARI) to the kg_games table and create a key for matching the SportsData rows.
kg_games_final as (

    select
        concat_ws('-', cast(kgg.date as varchar(10)), kgt.team_id) as kgg_game_id,
        kgt.team_id,
        kgg.*

    from kg_games kgg

    left join kg_teams kgt on kgg.team_home = kgt.team_name
),

-- CTE to create the SD-API surrogate key and match with kaggle dataset
nfl_games_final as (

    select 
        sdg.season,
        sdg.season_type,
        sdg.date,
        sdg.away_team,
        sdg.home_team,
        sdg.away_score,
        sdg.home_score,
        sdg.point_spread,
        sdg.over_under,
        sdg.stadiumid,
        sdg.away_teamid,
        sdg.home_teamid,
        sdg.status,
        -- create column to map games with kaggle. The same games of both datasets can be selected by date and home team.
        concat_ws('-', cast(sdg.date as varchar(10)), sdg.home_team) as sd_game_id,
        kgg.kgg_game_id,
        kgg.team_id as home_team_id,
        kgg.week as kgg_week,
        kgg.playoffs as kgg_playoffs,
        kgg.team_home as team_home_name,
        kgg.score_home as real_score_home,
        kgg.team_away as team_away_name,
        kgg.score_away as real_score_away,
        case 
            when kgg.score_home <> home_score or kgg.score_away <> away_score then 'scrambeled'
            else 'not scrambeled'
            end as score_scrambeled,
        case 
            when kgg.score_home > kgg.score_away then 'Hometeam win'
            when kgg.score_home = kgg.score_away then 'tie'
            else 'Awayteam win'
            end as game_result,
        kgg.stadium_neutral

    from sd_games sdg 

    left join kg_games_final kgg on 
        concat_ws('-', cast(sdg.date as varchar(10)), sdg.home_team) = kgg.kgg_game_id
)

 select * from nfl_games_final