include: "/views/order_items.view"

view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
    # link: {
    #   label: "Brand Look ({{ value }})"
    #   url: "https://analytics8.looker.com/looks/191?f[products.brand]={{ filterable_value }}
    #   &f[order_items.created_date]={{ _filters['order_items.created_date'] | url_encode }}
    #   &f[distribution_centers.name]={{ _filters['distribution_centers.name'] | url_encode }}"
    # }
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }
}

view: products_plus_order_items {
  extends: [products]
  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
    link: {
      label: "Brand Look ({{ products.brand._value }})"
      url: "https://analytics8.looker.com/looks/191?f[products.brand]={{ products.brand._value }}
      &f[order_items.created_date]={{ _filters['order_items.created_date'] | url_encode }}
      &f[distribution_centers.name]={{ _filters['distribution_centers.name'] | url_encode }}"
    }
  }
}
