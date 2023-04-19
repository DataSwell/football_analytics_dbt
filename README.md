# football_analytics
Transforming and analysing the extracted NFL and College (NCAA) football data (https://github.com/DataSwell/NFL_Analytics_ETL). The different data warehouse layers are all build with dbt as transformation tool. The data warehouse cotains:
- **staging models**: Staging layer for the raw data.
- **seeds**: CSV files which are used as a source for data which doesn`t change often over time (calender, states of the USA).
- **intermediate models**: More complex functions and transformations.
- **marts**: In this project we use wide tables for the different topics (NFL, NCAA). Compared to dimensional models the same data is stored in multiple marts. This increase the needed storage volume, but decrease the more expensive costs for computing.

![DWH-structure](https://user-images.githubusercontent.com/63445819/233022217-e4004b46-4d0c-46e9-9bcb-765512800c5b.png)

## NFL-Analytics
In this project are two different data sources for the NFL data. One dataset from kaggle which provides the data for all seasons since 1966 till 2022. The other data is from the API SportsData.io which provides more information then the kaggle set. But some of the information like scores are scrambeled, what means they are not the real scores.

### Staging
All staging models contain the prefix "stg". The source tables which deliver the data for the staging models are configured in the sources.yml file. The description of the staging models and the generic tests (not null, unique, relationships) are configured in the staging.yml file.
![staging_yml_screenshot](https://user-images.githubusercontent.com/63445819/233024130-68f89395-0140-4a48-acf6-28777237e486.png)

For each raw data table exists one staging model. The models process light transformations of the raw data like renaming, filtering, concating, casting etc.

![staging_kg_games](https://user-images.githubusercontent.com/63445819/233024951-40f18c43-853c-4b42-be7e-86b3df342187.png)


### Intermediate
The intermediate model int_replace_scrambeled_scores handles the problem with the scrambeled scores of the data from SportsData.io. We do not want to override the scrambeled scores, thats why we add the real scores and additional data from the kaggle staging models. It is necessary to create a new key in both data sets to join the data for the same games. A unique combination for a key is the date of the game and the name of the hometeam. We create the key by casting the date to a varchar and concatting it with the hometeam name. 

![int_model](https://user-images.githubusercontent.com/63445819/233028823-5a96c15b-a9b2-4ee0-813d-36e1690a5bb5.png)


### Marts 
In this project the marts will be organised as wide tables per entity/topic instead of a classic dimensional star/snowflake schema. This design approach is common in the modern data stack with cheap costs of storage. 

The marts join the transformed data from the staging and intermediate models and maybe add new columns. In this layer are no complex functions or transformations. All mart models start with the prefix "mrt". Special for this data structure is that each row contains a hometeam and a awayteam. Because of that we have to join the teams table twice but on different coluns. One join to add the data for the hometeam and the same for the awayteam. The tables need to get different aliases.

![mrt_model](https://user-images.githubusercontent.com/63445819/233033200-d8056ef0-5026-400a-95cb-0e0ca35a1d11.png)


### Analytics & Visualization
The NFL data marts are accessed by MS PowerBI.

The image below shows the data for all seasons from 1966-2022 (slicer on the right) but only the regular season games. The fields for the postseason games (Wildcard, Division, Conference, Superbowl) are deactivated. 
- Dallas is the team with the most wins over all seasons. But it is important to know that the teams exists for different years. Houston is the newest team of the NFL, so it is not surprising, that this team has the fewest wins.
- Over the years the amount of scored points increased, that is the result of more pass then run offenses, as well as the whole improvement of the sport and athletics. 1982 is a specuial year with a big drop in the amount of scored points. Because of a long strike of the players the season was reduced from 16 games per team to 9 games.
- Around 57% of the regular season games was won by the hometeam, which shows the advantage of homegames. 
- In total the teams of the NFC Conference have won more regular season games then the teams of the AFC.

![nfl_all_seasons_regularseason](https://user-images.githubusercontent.com/63445819/233038176-a22f83f4-b2f6-41cd-b7df-a590b328fd0e.png)

Compared to the data of the postseason (Playoffs and Superbowl) we can identify some differences. 
- Dallas was the team with the most regular season wins. That shows that they made it often into the playoffs, but there they are not as successful as other teams like New England who won a lot of SUperbowl ins the last 20 years.
- The increasing trend of scoring more points also exists for postseason games.
- The win percentage for hometeams is by 65% compared to the 57% of the regular season. But if we only select the data for Superbowl games, the win percentage drops to 54%. A reason for that will be, that the stadium for the super bowl is decided before the season. At this point it is not clear which teams are playing in the superbowl. In most cases they play in a neutral Stadium and the amount of fans for each team si equal or the people in the stadium are neutral, that reduces the crowd/fan-factor.

![nfl_all_seasons_postseason](https://user-images.githubusercontent.com/63445819/233038211-ba7b94ab-f18c-48a7-ba04-2b21b745d5c2.png)


## NCAA-Analytics
**In progress** 
The staging layer are already finished. Data marts, analytics and visualization needs  to be completed.

