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



## NCAA-Analytics
**In progress** 
The staging layer are already finished. Data marts, analytics and visualization needs  to be completed.

