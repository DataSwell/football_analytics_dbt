with states as (

    select * from {{ source('src_football', 'dim_regions')}}
)

select * from states