include: "/views/*.view"


view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    hidden:  yes
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: current {
    view_label: "Orders"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_month,
      day_of_year,
      month_num,
      year
    ]
    sql: current_date() ;;
  }

  dimension_group: created {
    view_label: "Orders"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_month,
      day_of_year,
      month_num,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    view_label: "Orders"
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
    view_label: "Orders"
    type: number
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    view_label: "Orders"
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    view_label: "Orders"
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
    hidden: yes
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
    view_label: "Orders"
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
    view_label: "Orders"
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    view_label: "Orders"
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

## Flags

  dimension: is_yesterday  {
    view_label: "Orders"
    group_label: "Calendar Flags"
    description: "Is Yesterday?"
    type:  yesno
    sql: dateadd(day,-1,current_date)=${created_date} ;;
  }

  dimension: is_in_the_last_30_days  {
    view_label: "Orders"
    group_label: "Calendar Flags"
    description: "Is in the past 30 days"
    type:  yesno
    sql: dateadd(day,-30,current_date)<=${created_date} ;;
  }

  dimension: month_to_date  {
    view_label: "Orders"
    group_label: "Calendar Flags"
    description: "User Date MTD and Prior MTD's"
    type:  yesno
    sql: ${created_day_of_month}<=date_part(day,current_date()) ;;
  }

  dimension: is_completed_sale {
    view_label: "Orders"
    description: "Completed Flag"
    type: yesno
    sql: ${status} IN ('Complete', 'Processing', 'Shipped');;
  }

  dimension: is_ytd {
    view_label: "Orders"
    group_label: "Calendar Flags"
    label: "Is YTD"
    description: "YTD in all years Flag"
    type: yesno
    sql: ${created_month_num} < MONTH(current_date())

    OR

    (${created_month_num}  = MONTH(current_date())

    AND

     ${created_day_of_month} <= DAY(current_date()))

    ;;
  }

#EXTRACT('day', GETDATE()) sql: ${created_day_of_month}<=date_part(day,current_date()) ;

#dimension:  {}

  measure: count {
    view_label: "Orders"
    type: count
    drill_fields: [detail*]
  }

  measure: user_count {
    view_label: "Orders"
    description: "Total Number Of Users"
    type: count_distinct
      sql: ${TABLE}."USER_ID" ;;
  }

  measure: total_sale_price {
     view_label: "Orders"
    description: "Total Revenue"
    type: sum
    value_format_name: usd
    filters: [is_completed_sale: "yes"]
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  measure: total_margin_amount {
    view_label: "Orders"
    description: "Margin"
    type: sum
    value_format_name: usd
    filters: [is_completed_sale: "yes"]
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }

  measure: total_margin_percentage {
    view_label: "Orders"
    description: "Margin"
    type: number
    value_format_name: percent_2
    sql: ${total_margin_amount} / NULLIF(${total_sale_price}, 0) ;;
  }

  measure: average_spend_per_users {
     view_label: "Orders"
    description: "Average Spend Per Customer"
    type: number
    value_format_name: usd
    sql: ${total_sale_price} / ${user_count} ;;
  }

  # measure: total_sale_price {
  #   type: number
  #   sql: ${TABLE}."SALE_PRICE" ;;
  # }

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
