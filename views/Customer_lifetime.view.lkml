# If necessary, uncomment the line below to include explore_source.

# include: "case_studies.model.lkml"

view: Customer_lifetime{
  derived_table: {
    explore_source: users {
      column: id {}
      column: count {}
      column: total_gross_revenue { field: order_items.total_gross_revenue }
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: count {
    description: ""
    type: number
  }
  dimension: total_gross_revenue {
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format: "$#,##0"
    type: number
  }
}
