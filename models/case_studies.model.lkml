connection: "snowlooker"

# include all the views
include: "/views/**/*.view"
include: "/models/custom_value_formats"

datagroup: case_studies_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

# access_grant: see_sale_price {
#   allowed_values: ["Eric"]
#   user_attribute: first_name
# }

persist_with: case_studies_default_datagroup

explore: distribution_centers {}

# explore: etl_jobs {}

explore: events {
  fields: [ALL_FIELDS*, -users.reference_other_views*]
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  # sql_always_having: ${products.is_above_avg_cost} ;;
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    # sql_where: ${products.category} = 'Jeans' ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  # sql_always_where: '{{_user_attributes.first_name | upcase}}' = ${users.first_name} ;;
  always_join: [users]
  # conditionally_filter: {
  #   filters: [created_date: "last 90 days"]
  #   unless: [users.state]
  # }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: order_items.user_id = users.id ;;
    relationship: many_to_one
    # sql_where: '{{_user_attributes.first_name | upcase}}' = ${users.first_name} ;;
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: dt_total_sales_by_order {
    view_label: "Per Order Derived Table"
    type: left_outer
    sql_on: ${order_items.id} = ${dt_total_sales_by_order.id}
              AND ${dt_total_sales_by_order.rank} = 1 ;;
    relationship: one_to_one
    # sql_where: ${dt_total_sales_by_order.rank} = 1 ;;
  }

  # Table that aggregates across all orders, showing average gross revenue per order across all orders
  join: dt_2 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dt_total_sales_by_order.has_more_than_one_item_in_order} = ${dt_2.has_more_than_one_item_in_order} ;;
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  fields: [ALL_FIELDS*, -users.reference_other_views*]
}

###############################
#      AGGREGATE TABLES       #
###############################

# Place in `case_studies` model
# explore: +order_items {
#   aggregate_table: rollup__users.state__users.city {
#     query: {
#       dimensions: [users.state, users.city]
#       measures: [sales_calculations*]
#     }

    # materialization: {
    #   datagroup_trigger: case_studies_default_datagroup
    # }
  # }
# }
