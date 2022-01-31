select
ID,
ORDERID as order_id,
PAYMENTMETHOD,
STATUS,
(AMOUNT/100) as AMOUNT ,
CREATED,
_BATCHED_AT
from 
{{ source('stripe', 'payment') }}
