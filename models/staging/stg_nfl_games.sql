with nfl_games as (

    select * from {{ source('src_football', 'sd_scores')}}
)

select * from nfl_games