connection: "snowlooker"

# include all the views
include: "/views/**/*.view"

# include LookML dashboards
include: "/dashboards/*.dashboard"

# include access grants
include: "/access_grants"

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
  # This will apply row-level security if the values match, but in this case,
  # the field is all caps, and the user attribute only has the first letter capitalized
  # access_filter: {
  #   field: users.first_name
  #   user_attribute: team_test
  # }

  # This effectively does the same thing as the access filter above, but it allows you to
  # maniulate the user attribute using liquid. Full list liquid filters available at https://shopify.github.io/liquid/
  sql_always_where: ${users.first_name} = '{{ _user_attributes["first_name"] | upcase }}' ;;

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

explore: products {
  # hidden: yes
  required_access_grants: [can_see_products_explore]
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {}
