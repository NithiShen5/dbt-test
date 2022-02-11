
{{ config(materialized='table') }}

with custorder2m as 
(
select C.C_CUSTKEY, C.C_NAME, SUM(O.O_TOTALPRICE) from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER" C
left join "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" O
ON C.C_CUSTKEY = O.O_CUSTKEY
---where C.C_CUSTKEY > {{ VAR('minid')}}
GROUP BY C.C_CUSTKEY, C.C_NAME
HAVING SUM(O.O_TOTALPRICE) > 2000000
)

select * from custorder2m