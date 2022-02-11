{{config(materialized='incremental', unique_key = 't_time')}}


select *,
to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) as time_concat
from
SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.TIME_DIM td
where time_concat <= current_time
--- and td.T_AM_PM = {{ var('AMPMvariable')}}

{%if is_incremental() %}

and time_concat > (select max(time_concat) from {{ this }})

{%endif%}

