connection: "snowlooker"
label: "Case Studies Demo"
# include all the views
include: "/views/**/*.view"
include: "/dashboards/**/*.dashboard"
include: "/global_settings/*.lkml"

# datagroup: case_studies_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

persist_with: case_studies_default_datagroup

explore: distribution_centers {
  #group_label: "Products & Orders"
}

explore: etl_jobs { }

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  #group_label: "Products & Orders"
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
}
########################################################################################################

explore: order_items {    # Use the lowest grain as to join to and make sure the relationship is correct
  #group_label: "Products & Orders"
    # always_filter:{
    #   filters: [created_date : "7 Days"]
    #   }
    sql_always_where: YEAR(CURRENT_DATE()) - ${created_year} <= '2' ;;
    join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one

  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
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
}

# Place in `case_studies` model

# explore: +order_items {
#   aggregate_table: rollup__created_month__products_category {
#     query: {
#       dimensions: [created_month, products.category]
#       measures: [count, total_margin_amount, total_sale_price]
#       #filters: [order_items.created_year: "3 years"]
#     }

#     materialization: {
#       datagroup_trigger: case_studies_default_datagroup
#     }
#   }
# }

# Place in `case_studies` model

# explore: +order_items {
#   aggregate_table: rollup__created_month__products_brand__products_category__products_name {
#     query: {
#       dimensions: [created_month, products.brand, products.category, products.name]
#       measures: [total_margin_amount, total_sale_price]
#     }

#     materialization: {
#       datagroup_trigger: case_studies_default_datagroup
#     }
#   }
# }


########################################################################################################

explore: products {
  #group_label: "Products & Orders"
   join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  hidden:  yes
}
