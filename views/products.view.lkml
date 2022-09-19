include: "/views/order_items.view"

view: products {
  sql_table_name: `looker-partners.thelook.products`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
}

view: products_plus_order_items_plus_distribution_centers {
  extends: [products]

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Brand Look ({{ products.brand._value }})"
      url: "https://analytics8.looker.com/looks/191?f[products.brand]={{ value | url_encode }}
      &f[order_items.created_date]={{ _filters['order_items.created_date'] | url_encode }}
      &f[distribution_centers.name]={{ _filters['distribution_centers.name'] | url_encode }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }

}
