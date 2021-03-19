# Here, you will include any basic explore refinements to handle
# joins and hiding/unhiding explores. You can also include
# view refinements to define primary keys and hide any
# machine-generated dimensions/measures.

include: "/layers/_base.layer"

##################################################
#       EXPLORE REFINEMENTS AND ADDITIONS        #
##################################################

explore: +events {
  hidden: no
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: +inventory_items {
  hidden: no
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: +order_items {
  hidden: no
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
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: +products {
  hidden: no
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

##################################################
#                 VIEW REFINEMENTS               #
##################################################

view: +events {
  view_label: "Website Activity"

  # ---- Hidden dimensions ----

  dimension: id {
    hidden: yes
  }

  dimension: user_id {
    hidden: yes
  }

  dimension: uri {
    hidden: yes
  }

  # ---- ID Grouping ----

  dimension: id {
    group_label: "~IDs"
  }

  dimension: session_id {
    group_label: "~IDs"
  }

  dimension: user_id {
    group_label: "~IDs"
  }

  # ---- ~Locations Grouping ----

  dimension: state {
    group_label: "~Location"
  }

  dimension: latitude {
    group_label: "~Location"
  }

  dimension: longitude {
    group_label: "~Location"
  }

  dimension: country {
    group_label: "~Location"
  }

  dimension: city {
    group_label: "~Location"
  }

  dimension: zip {
    group_label: "~Location"
  }
}

view: +users {

  # ---- Hidden Dimensions ----

  dimension: id {
    hidden: yes
  }

  dimension: first_name {
    hidden: yes
  }

  dimension: last_name {
    hidden: yes
  }

  # ---- Demographic Grouping ----

  dimension: age {
    group_label: "~Demographics"
  }

  dimension: gender {
    group_label: "~Demographics"
  }

  # ---- Location Grouping ----

  dimension: state {
    group_label: "~Location"
  }

  dimension: latitude {
    group_label: "~Location"
  }

  dimension: longitude {
    group_label: "~Location"
  }

  dimension: country {
    group_label: "~Location"
  }

  dimension: city {
    group_label: "~Location"
  }

  dimension: zip {
    group_label: "~Location"
  }
}

view: +order_items {

  # ---- Hidden Dimensions ----

  dimension: id {
    hidden: yes
  }

  dimension: inventory_item_id {
    hidden: yes
  }

  # ---- ID Grouping ----

  dimension: id {
    group_label: "~IDs"
  }

  dimension: inventory_item_id {
    group_label: "~IDs"
  }

  dimension: order_id {
    group_label: "~IDs"
  }

  dimension: user_id {
    group_label: "~IDs"
  }
}
