with source as (

    select * from {{ source('src_football', 'sd_scores')}}
),


nfl_games as (

    select *

    from source
    -- select only regualar and postseason games (season_types: 1 = regular, 2 = preseason, 3 = postseason)
    where season_type <> 2 
)

select * from nfl_games