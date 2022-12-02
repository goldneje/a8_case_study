# If necessary, uncomment the line below to include explore_source.

# include: "case_studies.model.lkml"

view: Customer_lifetime {
  derived_table: {
    explore_source: users {
      column: id {}
      column: count { field: order_items.count }
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: count {
    label: "Customer Lifetime Orders"
    description: ""
    type: number
  }
  dimension: count_tier {
    label: "Customer Order Tiers"
    type: tier
    tiers: [1,2,3,6,10]
    style: integer
    sql: ${count} ;;
  }
}
