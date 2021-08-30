# include: "/models/custom_value_formats"

view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "IDs"
    # hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  filter: date_selection {
    type: date
  }

  dimension: test_subq {
    sql: (SELECT ${created_date} FROM ${order_items.SQL_TABLE_NAME} WHERE {% condition date_selection %} ${created_date} {% endcondition %} LIMIT 1) ;;
  }

  dimension: is_date_selection_mtd {
    type: yesno
    sql: ${created_day_of_month} <= EXTRACT(day FROM (SELECT ${created_date::date} FROM ${order_items.SQL_TABLE_NAME} WHERE {% condition date_selection %} ${created_date} {% endcondition %} LIMIT 1)) ;;
  }

  dimension: date_filter_value {
    type: yesno
    sql: {% condition date_selection %} ${created_date} {% endcondition %} ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
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
    group_label: "IDs"
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
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
    description: "Sale price per item, hidden from end users but used in other measures"
    hidden: yes
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension: sale_price_tiers {
    description: "Breaks sales price up into different tiers to analyze the distribution of sale price"
    type: tier
    tiers: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    style: integer
    sql: ${sale_price} ;;
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
    description:
    "Status is defined per item,
    so one item could be Returned on an order,
    while the rest remain Completed"
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    group_label: "IDs"
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  ########################################################################################################
  #                                              MEASURES                                                #
  ########################################################################################################

  measure: number_of_items {
    type: count
    drill_fields: [detail*]
  }

  measure: items_per_order {
    type: number
    sql: count(${order_id}) OVER(PARTITION BY ${order_id}) ;;
    drill_fields: [detail*]
  }

  measure: total_gross_revenue {
    label: "Gross Revenue | Total"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: test
    filters: [status: "-Returned,-Cancelled"]
    drill_fields: [detail*]
  }

  measure: test {
    type: number
    sql: ${total_gross_revenue} / ${average_sale_price} ;;
  }

  measure: total_gross_revenue_per_order {
    group_label: "Per Order"
    group_item_label: "Total Gross Revenue"
    type: number
    sql: sum(${sale_price}) OVER(PARTITION BY ${order_id}) ;;
  }

  measure: average_sale_price {
    label: "Sale Price | Average"
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
    filters: [status: "-Returned,-Cancelled"]
    drill_fields: [detail*]
  }


  ########################################################################################################
  #                                              DEBUGGING                                               #
  ########################################################################################################

  # # Checking the number of statuses per order
  # measure: status_count {
  #   type: number
  #   sql: count(${status}) ;;
  # }

  # # Used to check what the individual items' statuses are within
  # # an order
  # measure: status_list {
  #   type: string
  #   sql: LISTAGG(${status}, ', ') WITHIN GROUP (ORDER BY ${order_id}) ;;
  # }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      users.last_name,
      users.first_name
    ]
  }

  # ---- Sets of fields for aggregate tables -----
  set: sales_calculations {
    fields: [
      total_gross_revenue
    ]
  }
}
