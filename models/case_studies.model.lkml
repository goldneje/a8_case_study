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
  from: calendar
  view_name: calendar

  join: order_items {
    sql_on: ${calendar.cal_date} = ${order_items.created_date} ;;
    relationship: one_to_many
  }

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

  join: brand_dt0 {
    sql_on: ${products.brand} = ${brand_dt0.brand} AND ${order_items.created_date} = ${brand_dt0.created_date} ;;
    relationship: many_to_one
  }

  join: category_dt0 {
    sql_on: ${products.category} = ${category_dt0.category} AND ${order_items.created_date} = ${category_dt0.created_date} ;;
    relationship: many_to_one
  }

  join: utilization_dt {
    sql_on:
    ${brand_dt0.brand} = ${utilization_dt.brand} AND ${category_dt0.category} = ${utilization_dt.category}
        AND ${utilization_dt.cal_date} = ${calendar.cal_date} ;;
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
