include: "/_layers/_basic.layer"

view: total_profit_dt {
  derived_table: {
    explore_source: order_items {
      column: profit_per_category { field: order_items.profit_total }
      column: category { field: products.category }

      # This will return total profit across all categories by running a window function
      derived_column: total_profit {
        sql: SUM(profit_per_category) OVER() ;;
      }

      # This will only carry through the filters that you tell it to, you can have as many from
      bind_filters: {
        from_field: order_items.created_date
        to_field: order_items.created_date
      }

      bind_filters: {
        from_field: products.category
        to_field: products.category
      }
    }
  }

  dimension: profit_per_category {
    label: "Order Items Total Profit"
    description: "
    Item's sale price minus its cost.
    "
    value_format: "$#,##0.00"
    type: number
  }
  dimension: category {}
  dimension: total_profit {
    type: number
    value_format: "$#,##0.00"
  }

  measure: percent_of_total {
    type: number
    sql: SUM(profit_per_category) / SUM(total_profit) ;;
    value_format_name: percent_1
  }
}

explore: +order_items {
  join: total_profit_dt {
    sql_on: ${products.category} = ${total_profit_dt.category} ;;
    relationship: many_to_one
    type: left_outer
    fields: [total_profit_dt.total_profit, total_profit_dt.percent_of_total]
  }
}
