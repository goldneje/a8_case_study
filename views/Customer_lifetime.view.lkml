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
    label: "User ID"
    description: ""
    primary_key: yes
    type: number
  }
  dimension: count {
    label: "Customer Order Count"
    description: ""
    type: number
  }

  dimension: order_count_tier {
    label: "Customer Lifetime Orders"
    type: tier
    tiers: [1,2,3,6,10]
    style: integer
    sql: ${count} ;;
  }

  dimension: is_repeat_customer {
    label: ""
    type: yesno
    sql: ${count} > 1 ;;
  }

  measure: average_lifetime_orders {
    label: "Average Lifetime Orders"
    type: average
    sql: ${count} ;;
  }

  measure: average_lifetime_revenue {
    label: "Average Lifetime Revenue"
    type: average
    sql: ${total_gross_revenue} ;;
  }

  dimension: total_gross_revenue {
    label: "Total Lifetime Revenue"
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format: "$#,##0"
    type: number
  }

  dimension: lifetime_revenue_tier {
    label: "Customer Lifetime Revenue"
    type: tier
    tiers: [5, 20, 50, 100, 500, 1000]
    style: integer
    sql: ${total_gross_revenue} ;;
  }
}
