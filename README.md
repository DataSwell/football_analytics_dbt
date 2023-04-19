# football_analytics
Transforming and analysing the extracted NFL and College (NCAA) football data (https://github.com/DataSwell/NFL_Analytics_ETL). The different data warehouse layers are all build with dbt as transformation tool. The data warehouse cotains:
- **staging models**: Staging layer for the raw data.
- **seeds**: CSV files which are used as a source for data which doesn`t change often over time (calender, states of the USA).
- **intermediate models**: More complex functions and transformations.
- **marts**: In this project we use wide tables for the different topics (NFL, NCAA). Compared to dimensional models the same data is stored in multiple marts. This increase the needed storage volume, but decrease the more expensive costs for computing.

![DWH-structure](https://user-images.githubusercontent.com/63445819/233022217-e4004b46-4d0c-46e9-9bcb-765512800c5b.png)

## NFL-Analytics


### Staging
All staging models contain the prefix "stg". The source tables which deliver the data for the staging models are configured in the sources.yml file. The description of the staging models and the generic tests (not null, unique, relationships) are configured in the staging.yml file.
![staging_yml_screenshot](https://user-images.githubusercontent.com/63445819/233024130-68f89395-0140-4a48-acf6-28777237e486.png)

For each raw data table exists one staging model. The models process light transformations of the raw data like renaming, filtering, concating, casting etc.
![staging_kg_games](https://user-images.githubusercontent.com/63445819/233024951-40f18c43-853c-4b42-be7e-86b3df342187.png)


Standings_2022: Contains weekly data for the standing of each team. This allows us to analyse which team improved over time or has the most range between ranked in the bottom/top. Because of the startdate of this project the data of the weeks 1-3 are missing. The ranking data is per division and conference.

### Intermediate

standings_2022: Aggregate the Conference and Division ranks. Count amount of individual ranks and the total sum for the 15 weeks. For example, a team was placed 10 weeks at rank 1, 3 weeks at rank 2 and 2 weeks at rank 4. The total sum for the 15 game_weeks in 2022 would be 24 (10x1 + 3x2, 2x4). The MIN, MAX, AVG and range between MIN & MAX for each team.


Team_stats.: Scores per each quarter for games played during week 5 till 18. total score per quarter and game , percentage points per quarter of total points. Average Points per quarter (total points per quarter / by games played).

### Marts 
In this project the marts will be organised as wide tables per entity/topic instead of a classic dimensional star/snowflake schema. This design approach is common in the odern data stack with cheap costs of storage. 



## NCAA-Analytics


