# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: brand_dt0 {
  derived_table: {
    explore_source: order_items {
      column: created_date {field:order_items.created_date}
      column: number_of_items {field:order_items.number_of_items}
      column: brand { field: products.brand }
      column: number_of_users { field: users.count }
      derived_column: cumulative_num_items {
        sql: SUM(number_of_items) OVER(PARTITION BY brand ORDER BY created_date) ;;
      }
      derived_column: cumulative_num_users {
        sql: SUM(number_of_users) OVER(PARTITION BY brand ORDER BY created_date) ;;
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
  dimension: brand {}
  dimension: number_of_users {
    type: number
  }
  dimension: cumulative_num_users {}
  dimension: cumulative_num_items {}
}
