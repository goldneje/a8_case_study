view: dt_total_sales_by_order {
  # This DT is filtered so it will only include
  # "Completed, Shipped, or Processing" orders.
  # An order with a status of Cancelled or Returned
  # will not count toward any revenue calculations

  derived_table: {
    explore_source: order_items {
      column: id {}
      column: order_id {}
      column: status {}
      column: items_per_order {}
      column: total_gross_revenue {}
      # Need this derived column to aggregate over later
      derived_column: total_gross_revenue_per_order {
        sql: sum(total_gross_revenue) OVER(PARTITION BY order_id) ;;
      }
      derived_column: rank {
        sql: rank() OVER(ORDER BY total_gross_revenue) ;;
      }
      filters: [
        order_items.status: "-Cancelled,-Returned"
      ]
    }
    sql_trigger_value: CURRENT_DATE ;;
  }

  dimension: id {
    group_label: "IDs"
    primary_key: yes
    hidden: yes
    type: number
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
    type: number
  }

  dimension: items_per_order {
    hidden: yes
    label: "Per Order | Number of Items"
  }

  dimension: has_more_than_one_item_in_order {
    type: yesno
    sql: ${items_per_order} > 1 ;;
  }

  dimension: total_gross_revenue {
    hidden: yes
    label: "Per Order | Total Gross Revenue"
    value_format: "$#,##0.00"
    type: number
  }

  dimension: total_gross_revenue_per_order {
    hidden: yes
    label: "Per Order | Total Gross Revenue"
    value_format: "$#,##0.00"
    type: number
  }

  dimension: rank {
    type: number
  }

  measure: per_order_average_gross_revenue {
    label: "Per Order | Average Gross Revenue"
    type: average
    value_format_name: usd
    sql: ${total_gross_revenue_per_order} ;;
  }

  measure: per_order_average_number_of_items {
    label: "Per Order | Average Number of Items"
    type: average
    sql: ${items_per_order} ;;
  }

#################################################################
#                        DEBUGGING                              #
#################################################################
  # # This can help ensure that the count of items between
  # # the derived table and the original table is the same
  # measure: number_of_items {
  #   type: count
  #   drill_fields: [order_id, order_items.status]
  # }
}
