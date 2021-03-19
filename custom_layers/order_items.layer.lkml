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

  dimension: profit {
    description: "
    Item's sale price minus its cost.
    "
    type: number
    sql: ${sale_price} - ${products.cost} ;;
    value_format_name: usd
  }

  dimension: gross_margin_percent {
    description: "
    Item's percent margin relative to cost
    "
    type: number
    sql: ${profit} / ${sale_price} ;;
    value_format_name: percent_1
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

  measure: total_profit {
    description: "
    Item's sale price minus its cost.
    "
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
  }

  measure: average_gross_margin_percent {
    description: "
    Profit / Sale Price, shows the average percent margin across a grouping
    "
    type: average
    sql: ${gross_margin_percent} ;;
    value_format_name: percent_0
  }
}
