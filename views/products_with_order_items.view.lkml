include: "/views/products.view.lkml"

view: products_with_order_items {
  extends: [products]

  dimension: sale_price {
    type: number
    sql: ${order_items.sale_price} ;;
  }
}
