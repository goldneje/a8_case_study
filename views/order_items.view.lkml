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
      week_of_year,
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

  measure: total_gross_revenue {
    type: sum
    sql: ${sale_price} ;;
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

# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: order_items_table_1 {
  derived_table: {
    explore_source: order_items {
      column: total_gross_revenue {}
      column: category { field: products.category }
      column: created_year {}
      column: created_week {}
      column: created_week_of_year {}
      derived_column: total_gross_revenue_1wk_lag {
        sql: LAG(total_gross_revenue, 1) OVER(PARTITION BY category ORDER BY created_year, created_week_of_year ASC) ;;
      }
      bind_all_filters: yes
    }
  }

  dimension: pk3_category_year_week_of_year {
    type: string
    primary_key: yes
    sql: MD5(CONCAT(${category},${created_year},${created_week_of_year})) ;;
  }

  dimension: total_gross_revenue {
    type: number
  }
  dimension: category {}
  dimension: created_year {
    type: date_year
  }
  dimension: created_week {
    type: date_week
  }
  dimension: created_week_of_year {
    type: number
  }
  dimension: total_gross_revenue_1wk_lag {
    type: number
  }


  measure: total_gross_revenue_diff {
    type: average
    sql: ${total_gross_revenue} - ${total_gross_revenue_1wk_lag} ;;
  }

}

# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: order_items_table_2 {
  derived_table: {
    explore_source: order_items {
      column: category { field: order_items_table_1.category }
      column: total_gross_revenue_diff { field: order_items_table_1.total_gross_revenue_diff }
      column: created_week { field: order_items_table_1.created_week }
      column: created_week_of_year { field: order_items_table_1.created_week_of_year }
      column: created_year { field: order_items_table_1.created_year }
      column: total_gross_revenue { field: order_items_table_1.total_gross_revenue }
      column: total_gross_revenue_1wk_lag { field: order_items_table_1.total_gross_revenue_1wk_lag }
    }
  }
  dimension: pk3_category_year_week_of_year {
    type: string
    primary_key: yes
    sql: MD5(CONCAT(${category},${created_year},${created_week_of_year})) ;;
  }

  dimension: category {}
  dimension: total_gross_revenue_diff {
    type: number
  }
  dimension: created_week {
    type: date_week
  }
  dimension: created_week_of_year {
    type: number
  }
  dimension: created_year {
    type: date_year
  }
  dimension: total_gross_revenue {
    type: number
  }
  dimension: total_gross_revenue_1wk_lag {
    type: number
  }
}
