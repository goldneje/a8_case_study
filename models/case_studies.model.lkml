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
  # cancel_grouping_fields: [calendar.cal_date]

  join: order_items {
    # outer_only: yes
    type: full_outer
    sql_on: ${calendar.cal_date} = ${order_items.created_date} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_many
  }

  join: users {
    type: full_outer
    sql_on: ${order_items.user_id} = ${users.id};;
    relationship: one_to_many
  }

  join: products {
    type: full_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: full_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: brand_dt0 {
    type: full_outer
    sql_on: ${calendar.cal_date} = ${brand_dt0.calendar_date} AND ${products.brand} = ${brand_dt0.brand} ;;
    relationship: one_to_many
  }

  join: category_dt0 {
    type: full_outer
    sql_on: ${products.category} = ${category_dt0.category} AND ${calendar.cal_date} = ${category_dt0.calendar_date} ;;
    relationship: one_to_many
  }

  join: utilization_dt {
    type: full_outer
    # sql_on:
    # IFF({% parameter order_items.join_switch %} = 'brand',
    #   ${brand_dt0.brand} = ${utilization_dt.brand},
    #   ${category_dt0.category} = ${utilization_dt.category})
    # AND ${utilization_dt.cal_date} = ${calendar.cal_date} ;;
    # sql_on:
    # IFF({% parameter order_items.join_switch %} = 'brand',
    # ${brand_dt0.brand} = ${utilization_dt.brand},
    # ${category_dt0.category} = ${utilization_dt.category})
    # AND ${utilization_dt.cal_date} = ${calendar.cal_date} ;;
    sql_on: ${calendar.cal_date} = ${utilization_dt.cal_date} ;;
    # sql_on:
    # ${brand_dt0.brand} = ${utilization_dt.brand}
    # AND ${category_dt0.category} = ${utilization_dt.category}
    # AND ${utilization_dt.cal_date} = ${calendar.cal_date} ;;
    relationship: one_to_many
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
