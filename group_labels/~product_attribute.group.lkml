include: "/_layers/_base.layer"

view: +inventory_items {
  dimension: product_brand {
    group_label: "~Product Attribute"
  }

  dimension: product_category {
    group_label: "~Product Attribute"
  }

  dimension: product_department {
    group_label: "~Product Attribute"
  }

  dimension: product_name {
    group_label: "~Product Attribute"
  }
}
