# If necessary, uncomment the line below to include explore_source.

# include: "case_studies.model.lkml"

view: user_order_dates {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: minimum_date {}
      column: maximim_date {}
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: minimum_date {
    label: "Order Items First Date"
    description: "The first created order date"
    type: string
  }
  dimension: maximim_date {
    label: "Order Items Latest Date"
    description: "The latest created order date"
    type: string
  }
  measure: days_since_last_order {
  type: number
  sql: date_diff(current_date, ${maximim_date}, DAY) ;;
  }
}
