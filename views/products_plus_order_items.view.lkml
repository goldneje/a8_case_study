include: "/views/products.view"

view: products_plus_order_items {
  extends: [products]

  dimension: sale_price {
    type: number
    sql: ${order_items.sale_price} ;;
  }

  dimension: margin {
    type: number
    sql: ${sale_price} - ${cost} ;;
  }

  measure: sum_margin {
    type: sum
    sql: ${margin} ;;
  }

  dimension: margin_percent {
    type: number
    sql: ${margin} / ${sale_price} ;;
  }

  measure: avg_margin_percent {
    type: average
    sql: ${margin_percent} ;;
  }

}
