# Here, you will include any basic explore refinements to handle
# joins and hiding/unhiding explores. You can also include
# view refinements to define primary keys, hide any
# machine-generated dimensions/measures, and define
# group labels for dimensions/measures.

include: "/_layers/_base.layer"
include: "/derived_table_layers/profit_per_order.layer"
include: "/derived_table_layers/order_sequence_2.layer"
include: "/pop_support/pop_support"

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
  join: pop_support {
    view_label: "PoP Support - Overrides and Tools" #(Optionally) Update view label for use in this explore here, rather than in pop_support view. You might choose to align this to your POP date's view label.
    relationship:one_to_one #we are intentionally fanning out, so this should stay one_to_one
    sql:{% if pop_support.periods_ago._in_query%}LEFT JOIN pop_support on 1=1{%endif%};;#join and fannout data for each prior_period included **if and only if** lynchpin pivot field (periods_ago) is selected. This safety measure ensures we dont fire any fannout join if the user selected PoP parameters from pop support but didn't actually select a pop pivot field.
  }

  #Update this always filter to your base date field to encourage a filter.  Without any filter, 'future' periods will be shown when POP is used (because, for example: today's data is/will be technically 'last year' for next year)
  always_filter: {filters: [order_items.created_date: "before 0 minutes ago"]}
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

# view: +distribution_centers {}

# view: +events {
#   view_label: "Website Activity"

#   # ---- ID Grouping ----

#   dimension: id {
#     group_label: "~IDs"
#   }

#   dimension: session_id {
#     group_label: "~IDs"
#   }

#   dimension: user_id {
#     group_label: "~IDs"
#   }


#   # ---- ~Locations Grouping ----

#   dimension: city {
#     group_label: "~Location"
#   }

#   dimension: country {
#     group_label: "~Location"
#   }

#   dimension: latitude {
#     group_label: "~Location"
#   }

#   dimension: longitude {
#     group_label: "~Location"
#   }

#   dimension: state {
#     group_label: "~Location"
#   }

#   dimension: zip {
#     group_label: "~Location"
#   }
# }

# view: +inventory_items {

#   # ---- Formatting ----

#   dimension: cost {
#     value_format_name: usd
#   }

#   # ---- Product Attribute Grouping ----

#   dimension: product_brand {
#     group_label: "~Product Attribute"
#   }

#   dimension: product_category {
#     group_label: "~Product Attribute"
#   }

#   dimension: product_department {
#     group_label: "~Product Attribute"
#   }

#   dimension: product_name {
#     group_label: "~Product Attribute"
#   }
# }

# view: +order_items {

#   # ---- Formatting ----

#   dimension: sale_price {
#     value_format_name: usd
#   }

#   # ---- ID Grouping ----

#   dimension: id {
#     group_label: "~IDs"
#   }

#   dimension: inventory_item_id {
#     group_label: "~IDs"
#   }

#   dimension: order_id {
#     group_label: "~IDs"
#   }

#   dimension: user_id {
#     group_label: "~IDs"
#   }

#   # ---- Delivery Duration Grouping ----

#   measure: delivery_duration_avg {
#     group_label: "~Delivery Duration"
#   }

#   measure: delivery_duration_min {
#     group_label: "~Delivery Duration"
#   }

#   measure: delivery_duration_25th_percentile {
#     group_label: "~Delivery Duration"
#   }

#   measure: delivery_duration_median {
#     group_label: "~Delivery Duration"
#   }

#   measure: delivery_duration_75th_percentile {
#     group_label: "~Delivery Duration"
#   }

#   measure: delivery_duration_max {
#     group_label: "~Delivery Duration"
#   }

#   # ---- Gross Revenue Grouping ----

#   measure: total_gross_revenue {
#     group_label: "~Revenue"
#   }

#   # ---- Profit Grouping ----

#   measure: gross_margin_percent_average {
#     group_label: "~Profit"
#   }

#   measure: profit_total {
#     group_label: "~Profit"
#   }
# }

# view: +products {}

# view: +users {

#   # ---- Demographic Grouping ----

#   dimension: age {
#     group_label: "~Demographics"
#   }

#   dimension: gender {
#     group_label: "~Demographics"
#   }

#   # ---- Location Grouping ----

#   dimension: state {
#     group_label: "~Location"
#   }

#   dimension: latitude {
#     group_label: "~Location"
#   }

#   dimension: longitude {
#     group_label: "~Location"
#   }

#   dimension: country {
#     group_label: "~Location"
#   }

#   dimension: city {
#     group_label: "~Location"
#   }

#   dimension: zip {
#     group_label: "~Location"
#   }
# }

# #################################################
# #            DERIVED TABLE REFINEMENTS          #
# #################################################

# view: +profit_per_order {

#   # ---- Profit Group ----

#   measure: profit_per_order_average {
#     group_label: "~Profit per Order"
#   }
#   measure: profit_per_order_total   {
#     group_label: "~Profit per Order"
#   }
# }

# view: +order_sequence_2 {
#   dimension: order_sequence {
#     group_label: "~Order Sequence"
#   }
#   dimension: has_subsequent_purchase {
#     group_label: "~Order Sequence"
#   }
#   dimension: is_first_order {
#     group_label: "~Order Sequence"
#   }
#   dimension: previous_order_date {
#     group_label: "~Order Sequence"
#   }
#   dimension: subsequent_order_date {
#     group_label: "~Order Sequence"
#   }
#   dimension: days_between_orders {
#     group_label: "~Order Sequence"
#   }
#   dimension: is_repeat_purchase {
#     group_label: "~Order Sequence"
#   }
# }
