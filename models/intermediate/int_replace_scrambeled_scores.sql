/*
Some of the game scores in the NFL data are scrambeled by the provider. That means, if you use only a free account, 
the data differ from the actual results. Therefore we use the kaggle data set, which privides us the correct game scores.

We have to map the scores from tkaggle with the ones from SportsData API.


sd_teams: team_short = ARI, team_name = Arizona Cardinals
kg_teams:  team_name = Arizona Cardinals, team_id = ARI !!! not uique, because 3x WAS (Redskins, Team, Commanders)


sd_games: home_team_id = 1 or home_team = ARI
kg_games: team_home = Arizona Cardinals

*/

with sd_games as (

    select * from {{ ref('stg_nfl_games')}}
),

sd_teams as (

    select * from {{ ref('stg_nfl_teams')}}
),

kg_games as (

    select * from {{ ref('stg_kg_games')}}
),

kg_teams as (

    select * from {{ ref('stg_kg_teams')}}
)