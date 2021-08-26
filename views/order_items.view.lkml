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
      day_of_month,
      day_of_year,
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

  dimension: is_completed_sale {
    description: "Sales that are not Cancelled or Returned"
    type: yesno
    sql: ${status} in ('Complete', 'Shipped', 'Processing') ;;
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

  measure: average_gross_margin {
    group_label: "Sales Metrics"
    description: "Average difference between Total Gross Revenue and Cost of Goods"
    type: average
    sql: ${sale_price} - ${inventory_items.cost};;
    filters: [is_completed_sale: "Yes"]
    value_format_name: usd
  }

  measure: average_sale_price {
    group_label: "Sales Metrics"
    description: "Average sales price of items sold"
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: average_spend_per_customer {
    group_label: "Sales Metrics"
    description: "Total Sale Price / Total Customers"
    type: number
    sql: ${total_sale_price} / ${count_customers} ;;
    value_format_name: usd
  }

  measure: count {
    label: "Total Number of Items Sold"
    type: count
    drill_fields: [detail*]
  }

  measure: count_customers {
    label: "Total Number of Customers"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: count_customers_return_items{
    label: "Number of Customers Returning Items"
    group_label: "Sales Metrics"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [status: "Returned"]
  }

  measure: count_items_returned {
    label: "Number of Items Returned"
    group_label: "Sales Metrics"
    type: count_distinct
    sql: ${order_id} ;;
    filters: [status: "Returned"]
    drill_fields: [detail*]
  }

  measure: cumulative_total_sales {
    group_label: "Sales Metrics"
    label: "Sales Running Total"
    type: running_total
    sql: ${total_sale_price} ;;
    value_format_name: usd
  }

  measure: customer_return_item_pct {
    label: "% of Customers Returning Items"
    group_label: "Sales Metrics"
    description: "Number of Customers Returning Items / Total Customers"
    type: number
    sql: ${count_customers_return_items} / ${count_customers} ;;
    value_format_name: percent_2
  }

  measure: gross_margin_pct {
    label: "Gross Margin %"
    group_label: "Sales Metrics"
    description: "Total Gross Margin / Total Gross Revenue"
    type: number
    sql: ${total_gross_margin} / NULLIF(${total_gross_revenue}, 0)  ;;
    value_format_name: percent_2
  }

  measure: item_return_rate {
    group_label: "Sales Metrics"
    description: "Number of Items Returned / Total Number of Items Sold"
    type: number
    sql: ${count_items_returned} / ${count} ;;
    value_format_name: percent_2
    drill_fields: [detail*]
  }

  measure: total_gross_margin {
    group_label: "Sales Metrics"
    description: "Difference between Total Gross Revenue and Cost of Goods"
    type: sum
    sql: ${sale_price} - ${inventory_items.cost};;
    filters: [is_completed_sale: "Yes"]
    value_format_name: usd
  }

  measure: total_gross_revenue {
    group_label: "Sales Metrics"
    description: "Total revenue from completed sales - excludes Cancelled and Returned orders"
    type: sum
    sql: ${sale_price} ;;
    filters: [is_completed_sale: "Yes"]
    value_format_name: usd
  }

  measure: total_sale_price {
    group_label: "Sales Metrics"
    description: "Total sales from items sold"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }


  measure: total_revenue_yesterday {
    type: sum
    sql: ${sale_price};;
    filters: [created_date: "yesterday", is_completed_sale: "Yes"]
    value_format_name: usd
  }

  measure: total_new_customers_yesterday {
    type: count_distinct
    sql: ${users.id};;
    filters: [users.created_date: "yesterday"]
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
