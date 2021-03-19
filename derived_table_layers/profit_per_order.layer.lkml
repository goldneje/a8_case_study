include: "/_layers/_basic.layer"

view: +order_items {
  measure: profit_per_order {
    type: number
    sql: SUM(${profit_total}) OVER(PARTITION BY ${order_id}) ;;
    value_format_name: usd
  }
}

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
}

explore: +order_items {
  join: profit_per_order {
    view_label: "Order Items"
  }
}
