with source as (

    select * from {{ source('src_football', 'sd_standings') }}
    )

--surrogate key

select * from source