include: "/_layers/_basic.layer"
include: "/derived_table_layers/order_sequence_1.layer"

# Add custom dimesions/measures to the derived table
# order_sequence_1 is hidden at the explore level, so I don't need to hide these measures
view: +order_sequence_1 {
  measure: is_first_order {
    description: "Yes/No flag showing whether an order is a users' first"
    type: yesno
    sql: ${order_sequence} = 1 ;;
  }

  measure: previous_order_date {
    type: date
    sql: CASE
        WHEN LAG(${user_id}, 1) OVER(ORDER BY ${user_id}, ${order_sequence}) = ${user_id}
          THEN LAG(${created_date}, 1) OVER(ORDER BY ${user_id}, ${order_sequence})
        ELSE NULL
        END ;;
  }

  measure: subsequent_order_date {
    type: date
    sql: CASE
        WHEN LEAD(${user_id}, 1) OVER(ORDER BY ${user_id}, ${order_sequence}) = ${user_id}
          THEN LEAD(${created_date}, 1) OVER(ORDER BY ${user_id}, ${order_sequence})
        ELSE NULL
        END ;;
  }

  measure: has_subsequent_purchase {
    type: yesno
    sql: ${subsequent_order_date} IS NOT NULL ;;
  }
}

# ---- Generate a new derived table to dimensionalize the measures in the first ----
view: order_sequence_2 {
  derived_table: {
    explore_source: order_sequence_1 {
      column: created_date {}
      column: order_id {}
      column: order_sequence {}
      column: user_id {}
      column: has_subsequent_purchase {}
      column: is_first_order {}
      column: previous_order_date {}
      column: subsequent_order_date {}
    }
  }
  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
  }

  dimension: created_date {
    hidden: yes
    type: date
  }


  dimension: order_sequence {
    description: "Sequence number showing the order that a customer's purchases took place."
    type: number
  }

  dimension: user_id {
    hidden: yes
    type: number
  }

  dimension: has_subsequent_purchase {
    label: "Has Subsequent Purchase (Yes / No)"
    type: number
  }

  dimension: is_first_order {
    label: "Is First Order (Yes / No)"
    type: number
  }

  dimension: previous_order_date {
    type: date
  }

  dimension: subsequent_order_date {
    type: date
  }
}

# ---- Adding new fields to order_sequence_2
view: +order_sequence_2 {
  dimension: days_between_orders {
    description: "
    Difference between current order date and previous order date (if it exists)
    "
    type: duration_day
    sql_start: ${previous_order_date} ;;
    sql_end: ${created_date} ;;
    value_format_name: decimal_1
  }

  dimension: is_repeat_purchase {
    type: yesno
    sql: ${days_between_orders} < 60 ;;
  }
}

# Join back to order_items
explore: +order_items {
  join: order_sequence_2 {
    view_label: "Order Items"
    type: left_outer
    sql_on: ${order_items.order_id} = ${order_sequence_2.order_id} ;;
    relationship: one_to_one
  }
}
