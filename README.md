# football_analytics
NFL and NCAAF analytics 


## nfl-games


## nfl-team-stats per game
The NFL team season stats for teh season 2023 only provides the total stats for all 17 regular games.

Because the project and data extracted was started during the season 2022, we didn`t have the data for the games 1-4.
The NFL team season stats for the season 2022 has 30 teams with 17 games and 2 teams with only 16 games, because the buffalo-cincinatti game was posponed but never replayed.
For the m

## Staging

Standings_2022: Contains weekly data for the standing of each team. This allows us to analyse which team improved over time or has the most range between ranked in the bottom/top. Because of the startdate of this project the data of the weeks 1-3 are missing. The ranking data is per division and conference.

## Intermediate

standings_2022: Aggregate the Conference and Division ranks. Count amount of individual ranks and the total sum for the 15 weeks. For example, a team was placed 10 weeks at rank 1, 3 weeks at rank 2 and 2 weeks at rank 4. The total sum for the 15 game_weeks in 2022 would be 24 (10x1 + 3x2, 2x4). The MIN, MAX, AVG and range between MIN & MAX for each team.


Team_stats.: Scores per each quarter for games played during week 5 till 18. total score per quarter and game , percentage points per quarter of total points. Average Points per quarter (total points per quarter / by games played).

## Marts 

In this project the marts will be organised as wide tables per entity/topic instead of a classic dimensional star/snowflake schema. This design approach is common in the odern data stack with cheap costs of storage. 

All datasests we will only focus on the regualar and postseason games. We don`t have enough data for interesting preseason analytics. Also the the matched Kaggle game data doesn`t include preseason, only regular and postseason scores. 

### NFL Teams 2021-2022 (SD dataset)


### NFL Teams full history (Kaggle dataset)


### College Teams
