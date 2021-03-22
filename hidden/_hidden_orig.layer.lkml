include: "/_layers/_base.layer"

view: +distribution_centers {

  dimension: id {
    hidden: yes
  }

  dimension: latitude {
    hidden: yes
  }

  dimension: longitude {
    hidden: yes
  }
}

view: +events {
  view_label: "Website Activity"

  dimension: id {
    hidden: yes
  }

  dimension: uri {
    hidden: yes
  }

  dimension: user_id {
    hidden: yes
  }
}

view: +inventory_items {

  dimension: id {
    hidden: yes
  }

  dimension: product_distribution_center_id {
    hidden: yes
  }

  dimension: product_id {
    hidden: yes
  }

  dimension: product_sku {
    hidden: yes
  }
}

view: +order_items {

  dimension: gross_margin_percent {
    hidden: yes
  }

  dimension: id {
    hidden: yes
  }

  dimension: inventory_item_id {
    hidden: yes
  }

  dimension: profit {
    hidden: yes
  }

  measure: order_sequence {
    hidden: yes
  }

  measure: profit_per_order {
    hidden: yes
  }

}

view: +products {

  dimension: id {
    hidden: yes
  }
  dimension: distribution_center_id {
    hidden: yes
  }
  dimension: sku {
    hidden: yes
  }
}

view: +users {

  dimension: id {
    hidden: yes
  }

  dimension: first_name {
    hidden: yes
  }

  dimension: last_name {
    hidden: yes
  }

  dimension: latitude {
    hidden: yes
  }

  dimension: longitude {
    hidden: yes
  }
}
