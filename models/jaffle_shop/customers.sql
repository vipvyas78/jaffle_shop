with customers as 
(
    select id as customer_id, 
    first_name,
    last_name 
    from 
    jaffle_shop.customer
),

orders as (
    select id as order_id, 
    user_id as customer_id,
    order_date,
    status
    from jaffle_shop.orders
),

customer_orders as (
    select 
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    count(order_id) as no_of_orders
    from 
    orders
    group by 1
),

final as (

    select customers.customer_id,
    customers.first_name,
    customers.last_name ,
    customer_orders.first_order_date,
    customer_orders.last_order_date,
    customer_orders.no_of_orders
    from customers
    left outer join customer_orders  using( customer_id)

)


select * from final
