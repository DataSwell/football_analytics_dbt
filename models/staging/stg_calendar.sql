with source as (

    select * from {{ ref('calendar')}}
)

select * from source
