with source as (

    select * from {{ source('src_football', 'kg_scores_bets') }}
),
    
kg_games as (

    select    
        -- concat to create surrogate key
        concat_ws('-', schedule_date:: varchar(10), team_home) as game_id,
        schedule_date as date,
        schedule_season as season,
        schedule_week as week,
        schedule_playoff as playoffs,
        team_home,
        score_home,
        team_away,
        score_away,
        case 
            when score_home > score_away then 'Hometeam' 
            when score_home < score_away then 'Awayteam' 
            else 'Tie'
            end as home_or_away_win,
        case when team_favorite_id = 'NaN' then null else team_favorite_id end,
        case when spread_favorite = 'NaN' then null else spread_favorite end,
        case when over_under_line = 'NaN' then null else over_under_line end,
        stadium_name,
        stadium_neutral,
        case when weather_temperature = 'NaN' then null else weather_temperature end as temperature,
        case when weather_wind_mph = 'NaN' then null else weather_wind_mph end as wind_mph,
        case when weather_humidity = 'NaN' then null else weather_humidity end as humidity

    from source
)


select * from kg_games
