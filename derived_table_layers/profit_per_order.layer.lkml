include: "/_layers/_basic.layer"

# Adding profit_per_order to order items because it
# will be used in this derived table.
view: +order_items {
  measure: profit_per_order {
    type: number
    sql: SUM(${profit_total}) OVER(PARTITION BY ${order_id}) ;;
    value_format_name: usd
  }
}


# Generating the derived table using our newly-made measure
view: profit_per_order {
  derived_table: {
    explore_source: order_items {
      column: id {}
      column: order_id {}
      column: profit_per_order {}
    }
  }

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: order_id {
    type: number
  }

  dimension: profit_per_order {
    value_format: "$#,##0.00"
    type: number
  }

  measure: profit_per_order_average {
    group_item_label: "Average"
    type: average
    sql: ${profit_per_order} ;;
    value_format_name: usd
  }

  measure: profit_per_order_total {
    group_item_label: "Total"
    type: sum
    sql: ${profit_per_order} ;;
    value_format_name: usd
  }
}


# Joining back my new calculations to the order items explore
explore: +order_items {
  join: profit_per_order {
    view_label: "Order Items"
    sql_on: ${order_items.id} = ${profit_per_order.id} ;;
    relationship: one_to_one
  }
}
