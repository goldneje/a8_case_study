include: "/_layers/_base.layer"

view: +events {
  view_label: "Website Activity"

  # ---- ID Grouping ----

  dimension: id {
    group_label: "~IDs"
  }

  dimension: session_id {
    group_label: "~IDs"
  }

  dimension: user_id {
    group_label: "~IDs"
  }
}

view: +order_items {
  dimension: id {
    group_label: "~IDs"
  }

  dimension: inventory_item_id {
    group_label: "~IDs"
  }

  dimension: order_id {
    group_label: "~IDs"
  }

  dimension: user_id {
    group_label: "~IDs"
  }
}
