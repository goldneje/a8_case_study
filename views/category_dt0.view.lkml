# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: category_dt0 {
  derived_table: {
    explore_source: order_items {
      column: created_date {field:order_items.created_date}
      column: number_of_items {field:order_items.number_of_items}
      column: category { field: products.category }
      column: number_of_users { field: users.count }
      derived_column: cumulative_num_users {
        sql: SUM(number_of_users) OVER(PARTITION BY category ORDER BY created_date) ;;
      }
      derived_column: cumulative_num_items {
        sql: SUM(number_of_items) OVER(PARTITION BY category ORDER BY created_date) ;;
      }
      bind_all_filters: yes
    }
  }

  dimension: created_date {
    type: date
  }
  dimension: number_of_items {
    type: number
  }
  dimension: category {}
  dimension: number_of_users {
    type: number
  }
  dimension: cumulative_num_users {}
  dimension: cumulative_num_items {}
}


# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: utilization_dt {
  derived_table: {
    explore_source: order_items {
      column: c_number_of_items { field: category_dt0.number_of_items }
      column: c_number_of_users { field: category_dt0.number_of_users }
      column: cal_date { field: calendar.cal_date }
      column: b_number_of_items { field: brand_dt0.number_of_items }
      column: b_number_of_users { field: brand_dt0.number_of_users }
      column: brand { field: brand_dt0.brand }
      column: category { field: category_dt0.category }
      bind_all_filters: yes
    }
  }


  dimension: c_number_of_items {
    type: number
  }
  dimension: c_number_of_users {
    type: number
  }
  dimension: cal_date {
    type: date
  }
  dimension: b_number_of_items {
    type: number
  }
  dimension: b_number_of_users {
    type: number
  }
  dimension: brand {}
  dimension: category {}
}
