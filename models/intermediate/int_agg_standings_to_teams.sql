with standings as (

    select * from {{ ref('stg_nfl_standings')}}
)

select * from standings