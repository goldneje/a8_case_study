# If necessary, uncomment the line below to include explore_source.

# include: "case_studies.model.lkml"

view: updated_user_order_dates {
  derived_table: {
    explore_source: user_order_dates {
      column: minimum_date {}
      column: maximim_date {}
      column: id {}
      column: days_since_last_order {}
    }
  }
  dimension: minimum_date {
    label: "User first order date"
    description: "The first created order date"
  }
  dimension: maximim_date {
    label: "User latest order date"
    description: "The latest created order date"
  }
  dimension: id {
    label: "User ID"
    description: ""
    type: number
  }
  dimension: days_since_last_order {
    description: "The days since a user's last order"
    type: number
  }
  dimension: is_active {
    label: "Is Active"
    description: "Has the customer been active in the last 90 days"
    type: yesno
    sql: ${days_since_last_order} < 91 ;;
  }
  measure: avg_days_since_last_order {
    type: average
    sql: ${days_since_last_order} ;;
  }
}
