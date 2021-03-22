include: "/_layers/_base.layer"

view: +order_items {

  measure: gross_margin_percent_average {
    group_label: "~Profit"
  }

  measure: profit_total {
    group_label: "~Profit"
  }
}
