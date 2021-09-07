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

  dimension: date_selection_single_value {
    type: date_raw
    sql: (SELECT ${created_date::date} FROM ${order_items.SQL_TABLE_NAME} WHERE {% condition date_selection %} ${created_date} {% endcondition %} ORDER BY ${created_date} DESC LIMIT 1) ;;
  }

  dimension: is_date_selection_mtd {
    type: yesno
    sql: ${created_day_of_month} <= EXTRACT(day FROM ${date_selection_single_value}) ;;
  }

  dimension: is_current_month_in_current_year {
    type: yesno
    sql: ${created_month} = TO_CHAR(${date_selection_single_value}, 'YYYY-MM') ;;
  }

  dimension: is_current_month_num {
    type: yesno
    sql: ${created_month_num} = MONTH(${date_selection_single_value}) ;;
  }

  dimension: is_previous_month {
    type: yesno
    sql: ${created_month} = TO_CHAR(DATEADD(month, -1, DATE_TRUNC(month, ${date_selection_single_value})), 'YYYY-MM') ;;
  }

  dimension: is_current_year {
    type: yesno
    sql: ${created_year} = TO_CHAR(${date_selection_single_value}, 'YYYY') ;;
  }

  dimension: is_previous_year {
    type: yesno
    sql: ${created_year} = TO_CHAR(DATEADD(year, -1, DATE_TRUNC(year, ${date_selection_single_value})), 'YYYY') ;;
  }

  dimension: is_current_month_in_previous_year {
    type: yesno
    sql: ${is_previous_year} AND ${is_current_month_num} ;;
  }

  dimension: is_within_date_selection_filter {
    type: yesno
    sql: {% condition date_selection %} ${created_date} {% endcondition %} ;;
  }

  dimension: is_weekday {
    type: yesno
    sql: ${created_day_of_week_index} in (0,1,2,3,4) ;;
  }

  dimension: most_recent_weekday {
    type: date
    hidden: yes
    sql: case
            when dayname(${date_selection_single_value} -1) in ('Mon','Tue', 'Wed','Thu','Fri') then ${date_selection_single_value} - 1
            when  dayname(${date_selection_single_value} -1) = 'Sat' then ${date_selection_single_value} - 2
            when  dayname(${date_selection_single_value} -1) = 'Sun'  then ${date_selection_single_value} - 3
          end ;;
  }

  dimension: is_most_recent_weekday {
    type: yesno
    sql: ${created_date} <= ${most_recent_weekday} ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
      day_of_week_index,
      week,
      month,
      month_num,
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

  measure: number_of_items_cmtd {
    type: count
    label: "Number of Items CMTD"
    filters: [is_current_month_in_current_year: "Yes", is_date_selection_mtd: "Yes"]
  }

  measure: number_of_items_lmtd {
    type: count
    label: "Number of Items LMTD"
    filters: [is_previous_month: "Yes", is_date_selection_mtd: "Yes"]
  }

  measure: number_of_items_ly_cm {
    type: count
    label: "Number of Items Last Year This Month"
    filters: [is_current_month_in_previous_year: "Yes"]
  }

  # measure: num_weekdays_passed {
  #   type: count_distinct
  #   sql: ${created_date} ;;
  #   filters: [is_current_month_in_current_year: "Yes", is_weekday: "Yes"]
  # }

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

view: weekdays {
  derived_table: {
    explore_source: order_items {
      column: created_date {}
      column: created_month {}
      derived_column: num_weekdays_passed {
        sql: COUNT(created_date) OVER (PARTITION BY created_month ORDER BY created_date) ;;
      }
      derived_column: num_weekdays_total {
        sql: COUNT(created_date) OVER (PARTITION BY created_month) ;;
      }
      filters: [order_items.is_weekday: "Yes"]
      # bind_filters: {
      #   from_field: order_items.date_selection
      #   to_field: order_items.created_date
      # }
    }
  }
  dimension: created_date {
    hidden: yes
    type: date
    primary_key: yes
  }
  dimension: num_weekdays_passed {
    type: number
  }
  dimension: num_weekdays_total {
    type: number
  }
}

# explore: +order_items {
#   join: weekdays {
#     sql_on: ${weekdays.created_date} = ${order_items.created_date} ;;
#     fields: [num_weekdays_passed, num_weekdays_total]
#   }
# }
