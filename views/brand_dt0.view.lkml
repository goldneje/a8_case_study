# If necessary, uncomment the line below to include explore_source.
# include: "case_studies.model.lkml"

view: brand_dt0 {
  derived_table: {
    explore_source: order_items {
      column: calendar_date {field:calendar.cal_date}
      column: number_of_items {field:order_items.number_of_items}
      column: brand { field: products.brand }
      column: number_of_users { field: users.count }
      derived_column: cumulative_num_items {
        sql: SUM(number_of_items) OVER(PARTITION BY brand ORDER BY calendar_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ;;
      }
      derived_column: cumulative_num_users {
        sql: SUM(COALESCE(number_of_users, 0)) OVER (PARTITION BY brand ORDER BY calendar_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ;;
      }
      # bind_filters: {
      #   from_field: products.brand
      #   to_field: products.brand
      # }
      bind_all_filters: yes
    }
  }

  dimension: pk {
    sql: concat(${calendar_date},${brand}) ;;
  }
  dimension: calendar_date {
    type: date
  }
  dimension: number_of_items {
    type: number
  }
  dimension: brand {  }
  dimension: number_of_users {
    type: number
  }
  dimension: cumulative_num_users {
    type: number
  }
  measure: cumulative_num_items {
    type: number
    sql: COALESCE(SUM(${TABLE}.cumulative_num_items), 0) ;;

  }



}
