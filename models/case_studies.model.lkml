connection: "snowlooker"

# include all the views
include: "/views/**/*.view"

# include LookML dashboards
include: "/dashboards/*.dashboard"

datagroup: case_studies_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup

explore: distribution_centers {}

explore: etl_jobs {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
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

explore: order_items {
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

# This view has a field that uses order_items, so it should only be used when order items is included in the join somewhere
  join: products_with_order_items {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products_with_order_items.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products_with_order_items.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {}
