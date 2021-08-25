# 1)  Head to this explore: https://analytics8.looker.com/explore/case_studies/order_items?qid=CdkXLipaQkLw9JXdWuHU7J

# 2)  Observe the Average Sale Price fields, are they equal?

# 3)  Take a look at the Generated SQL and identify which part of the SQL is the derived table definition and which is the main query.
#         - Also, look specifically at the 'WHERE' statements

# 4)  Uncomment 'bind_all_filters: yes' and repeat steps 1 - 3

# 5)  What do you notice changes when bind_all_filters is on vs. off?

# 6)  You can also bind only *specific* filters, if you'd like, using the 'bind_filters:' param. You can see that below.
#         - This takes one filter *from* the base explore and applies it *to* another field in that explore
#         - You can have multiple bind_filters parameters, and they will combine when you run the query.
#         - You can, for instance, take the filter on age, and apply it to sale_price, if you wanted to
#         - If you can't tell, I don't have a good use case for this, yet.

# 7)  Uncomment the first 'bind_filters' parameter (with order_items.created_date in it) to see how it replicates the behavior
#     of 'bind_all_filters'

# 8)  Now, let's see what happens when bind one filter to another:
#         - Add Users > Age as a filter to the explore at the top of this list
#         - Comment out the bind_all_filters: parameter
#         - Comment out the first bind_filters parameter (with order_items.created_date)
#         - Uncomment the second bind_filters parameter (with users.age)
#         - Save, then refresh the explore and run it again, check the SQL and observe the WHERE clause in the derived table defintion. What is happening?

view: brand_rollup {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: average_sale_price {}
      # bind_all_filters: yes
      # bind_filters: {
      #   from_field: order_items.created_date
      #   to_field: order_items.created_date
      # }
      # bind_filters: {
      #   from_field: users.age
      #   to_field: users.sale_price
      # }
    }
  }
  dimension: brand {
    primary_key: yes
  }
  dimension: average_sale_price {
    label: "Order Items Sale Price | Average"
    value_format: "$#,##0.00"
    type: number
  }
}

include: "/models/case_studies.model"

explore: +order_items {
  join: brand_rollup {
    relationship: many_to_one
    type: left_outer
    sql_on: ${products.brand} = ${brand_rollup.brand} ;;
  }
}
