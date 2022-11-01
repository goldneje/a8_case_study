view: order_items {
  sql_table_name: `looker-partners.thelook.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
    sql: ${TABLE}.created_at ;;
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sales_price {
    label: "Total Sales Price"
    description: "Total sales from items sold"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: average_sales_price {
    label: "Average Sales Price"
    description: "Average sale price of items sold"
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: cumulative_total_sales {
    label: "Cumulative Total Sales"
    description: "Cumulative total sales from items sole (also known as running total"
    type: running_total
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: total_gross_revenue {
    label: "Total Gross Revenue"
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "-Cancelled, -Returned"]
    value_format_name: usd_0
  }

  measure: total_gross_margin_amount {
    label: "Total Gross Margin Amount"
    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
    type: sum
    #sql: ${total_gross_revenue} - ${inventory_items.total_cost} ;;
    sql: ${sale_price} - ${inventory_items.cost} ;;
    filters: [status: "-Cancelled, -Returned"]
    value_format_name: usd_0
  }

  measure: average_gross_amount {
    label: "Average Gross Amount"
    description: "Average difference between the total revenue from completed sales and the cost of the goods that were sold"
    type: average
    sql: ${sale_price} - ${inventory_items.cost} ;;
    filters: [status: "-Cancelled, -Returned"]
    value_format_name: usd_0
  }

  measure: gross_margin_percent {
    label: "Gross Margin Percent"
    description: "Total Gross Margin Amount / Total Gross Revenue"
    type: number
    sql: 1.0*${total_gross_margin_amount} / NULLIF(${total_gross_revenue},0) ;;
    value_format_name: percent_1
  }

  measure: number_of_items_returned {
    label: "Number of items returned"
    description: "Number of items that were returned by dissatisfied customers"
    type: count
    drill_fields: [detail*]
    filters: [status: "Returned"]
  }

  measure: item_return_rate {
    label: "Item Return Rate"
    description: "Number of Items Returned / total number of items sold"
    type: number
    sql: ${number_of_items_returned} / NULLIF(${count},0) ;;
    value_format_name: percent_1
  }

  measure: number_of_customers_returning_items {
    label: "Number of Customers Returning Items"
    description: "Number of users who have returned an item at some point"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [order_items.status: "Returned"]
  }

  measure: percent_of_users_with_returns {
    label: "Percent of users with returns"
    description: "Number of Customer Returning Items / total number of customers"
    type: number
    sql: ${number_of_customers_returning_items} / NULLIF(${users.count}, 0) ;;
    value_format_name: percent_1
  }

  measure: average_spend_per_customer {
    label: "Average spent per customer"
    description: "Total Sale Price / total number of customers"
    type: number
    sql: ${order_items.total_sales_price} / NULLIF(${users.count}, 0) ;;
    value_format_name: percent_1
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
