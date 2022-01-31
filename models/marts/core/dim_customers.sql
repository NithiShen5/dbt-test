with customers as (

    select * from {{ ref('stg_customers')}}

),

orders as (

    select * from {{ ref('fct_orders')}}

),

customer_orders as (

    select
        customer_id,
        sum(amount) as lifetime_value

    from orders

    group by customer_id

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.lifetime_value

    from customers

    left join customer_orders using (customer_id)

)

select * from final