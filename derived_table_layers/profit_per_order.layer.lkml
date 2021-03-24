include: "/_layers/_base.layer"

# Adding profit_per_order to order items because it
# will be used in this derived table.
view: +order_items {
  measure: profit_per_order {
    type: number
    sql: SUM(${order_items.profit_total}) OVER(PARTITION BY ${order_id}) ;; # Need to fully scope profit_total to avoid errors, defined in profit.layer
    value_format_name: usd
  }
}


# Generating the derived table using our newly-made measure
view: profit_per_order {
  derived_table: {
    explore_source: order_items {
      column: pk1_order_item_id {}
      column: order_id {}
      column: profit_per_order {}
    }
  }

  dimension: pk1_order_item_id {
    hidden: yes
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
}


# Joining back my new calculations to the order items explore
explore: +order_items {
  join: profit_per_order {
    view_label: "Order Items"
    sql_on: ${order_items.pk1_order_item_id} = ${profit_per_order.pk1_order_item_id} ;;
    relationship: one_to_one
  }
}
