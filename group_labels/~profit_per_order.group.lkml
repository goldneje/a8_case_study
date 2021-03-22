include: "/_layers/_base.layer"
include: "/derived_table_layers/profit_per_order.layer"

view: +profit_per_order {
  measure: profit_per_order_average {
    group_label: "~Profit per Order"
  }
  measure: profit_per_order_total   {
    group_label: "~Profit per Order"
  }
}
