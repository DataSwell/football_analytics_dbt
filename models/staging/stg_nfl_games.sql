with source as (

    select * from {{ source('src_football', 'sd_scores')}}
)

select * from source