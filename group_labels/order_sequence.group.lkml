include: "/_layers/_base.layer"
include: "/derived_table_layers/order_sequence_2.layer"

view: +order_sequence_2 {
  dimension: order_sequence {
    group_label: " Order Sequence"
  }
  dimension: has_subsequent_purchase {
    group_label: " Order Sequence"
  }
  dimension: is_first_order {
    group_label: " Order Sequence"
  }
  dimension: previous_order_date {
    group_label: " Order Sequence"
  }
  dimension: subsequent_order_date {
    group_label: " Order Sequence"
  }
  dimension: days_between_orders {
    group_label: " Order Sequence"
  }
  dimension: is_repeat_purchase {
    group_label: " Order Sequence"
  }
}
