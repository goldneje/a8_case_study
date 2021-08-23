view: dt_2 {
  derived_table: {
    explore_source: order_items {
      column: has_more_than_one_item_in_order { field: dt_total_sales_by_order.has_more_than_one_item_in_order }
      column: per_order_average_gross_revenue { field: dt_total_sales_by_order.per_order_average_gross_revenue }
      filters: {
        field: order_items.created_date
        value: "90 days"
      }
    }
  }
  dimension: has_more_than_one_item_in_order {
    primary_key: yes
    label: "Per Order Derived Table Has More Than One Item In Order (Yes / No)"
    type: yesno
  }
  dimension: per_order_average_gross_revenue {
    label: "Per Order Derived Table Per Order | Average Gross Revenue"
    value_format: "$#,##0.00"
    type: number
  }
}
