with calendar as (

    select * from {{ ref('calendar_short')}}
)

select * from calendar