with team_stats_reg_seasons as (

    select *

    from {{ ref('stg_nfl_team_stats')}}

    where season_type = 1
)

/* for season 2021 all teams have played 17 games. For season 2022 two teams only played 16 games, the rest of the teams played 17 games.
 Because of that we can´t select the stats of the teams were games_played = 17, we would miss out on two teams.
There are multiple approaches to deal with this:
1. Select for all teams the data from their first 16 games. So we would lose the data for 30 teams and ther 17th game.
2. Select the data for each team and their max games_played (30 teams with 17 and two teams with 16 games). But that would be a disadvantage for the two teams if we compare absolute numbers.
3. Update the data for the two teams with the average values (scores per quarter, times sacked percentage)

For this project we will use the 3rd approach because it is also a common method to deal with missing data.
 */


select * from team_stats_reg_seasons



