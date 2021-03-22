view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.first_name,
      users.id
    ]
  }
}

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

  # ---- Start Boxplot Calculations ----

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

  # ---- End Boxplot Calculations ----

  measure: gross_margin_percent_average {
    label: "Average Gross Margin Percent"
    description: "
    Profit / Sale Price, shows the average percent margin across a grouping
    "
    type: average
    sql: ${gross_margin_percent} ;;
    value_format_name: percent_0
    filters: [status: "-Cancelled, -Returned"]
  }

  measure: profit_total {
    label: "Total Profit"
    description: "
    Item's sale price minus its cost.
    "
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
    filters: [status: "-Cancelled, -Returned"]
  }

  measure: total_gross_revenue {
    description: "
    Total gross revenue of items that are not returned or cancelled.
    Calculated as the sum of the sale price of the item.
    "
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    filters: [status: "-Cancelled, -Returned"]
  }
}
