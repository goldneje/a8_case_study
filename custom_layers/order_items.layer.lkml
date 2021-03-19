include: "/_layers/_basic.layer"

view: +order_items {

##########################################################
#                     CUSTOM DIMENSIONS                  #
##########################################################

  dimension_group: creation_to_delivery {
    description: "Length of time from item create date to item delivered date"
    type: duration
    sql_start: ${created_raw} ;;
    sql_end: ${delivered_raw} ;;
  }

##########################################################
#                     CUSTOM MEASURES                    #
##########################################################

  measure: delivery_duration_avg {
    group_item_label: "Average"
    description: "Average length of time in days from item create date to item delivered date."
    type: average
    sql: ${days_creation_to_delivery} ;;
  }

  # Boxplot Calculations
  measure: delivery_duration_min {
    group_item_label: "Minimum"
    type: min
    sql: ${days_creation_to_delivery} ;;
  }

  measure: delivery_duration_25th_percentile {
    group_item_label: "25th percentile"
    type: percentile
    percentile: 25
    sql: ${days_creation_to_delivery} ;;
  }

  measure: delivery_duration_median {
    group_item_label: "Median"
    type: median
    sql: ${days_creation_to_delivery} ;;
  }

  measure: delivery_duration_75th_percentile {
    group_item_label: "75th percentile"
    type: percentile
    percentile: 75
    sql: ${days_creation_to_delivery} ;;
  }

  measure: delivery_duration_max {
    group_item_label: "Maximum"
    type: max
    sql: ${days_creation_to_delivery} ;;
  }

  measure: total_gross_revenue {
    description: "
    Total gross revenue of items that are not returned or cancelled.
    Calculated as the sum of the sale price of the item.
    "
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }
}
