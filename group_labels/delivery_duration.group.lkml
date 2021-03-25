include: "/_layers/_base.layer"

view: +order_items {
  measure: delivery_duration_avg {
    group_label: " Delivery Duration"
  }

  measure: delivery_duration_min {
    group_label: " Delivery Duration"
  }

  measure: delivery_duration_25th_percentile {
    group_label: " Delivery Duration"
  }

  measure: delivery_duration_median {
    group_label: " Delivery Duration"
  }

  measure: delivery_duration_75th_percentile {
    group_label: " Delivery Duration"
  }

  measure: delivery_duration_max {
    group_label: " Delivery Duration"
  }
}
