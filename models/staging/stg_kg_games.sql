with source as (

    select * from {{ source('src_football', 'kg_scores_bets') }}
),
    
kg_games as (

    select    
        -- concat to create surrogate key
        concat_ws('-', schedule_date:: varchar(10), team_home, team_away) as game_id,
        schedule_date as date,
        schedule_season as season,
        schedule_week as week,
        schedule_playoff as playoffs,
        team_home,
        score_home,
        team_away,
        score_away,
        team_favorite_id,
        spread_favorite,
        over_under_line,
        stadium_name,
        stadium_neutral,
        weather_temperature as temperature,
        weather_wind_mph as wind_mph,
        weather_humidity as humidiy

    from source
)

select * from kg_games
