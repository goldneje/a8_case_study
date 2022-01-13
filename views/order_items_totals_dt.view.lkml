# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: order_items_totals_dt {
  derived_table: {
    explore_source: order_items {
      column: sum_sale_price {}
      bind_all_filters: yes
    }
  }
  dimension: sum_sale_price {
    label: "Order Items Gross Sales"
    type: number
  }
}
