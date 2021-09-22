include: "/views/products.view.lkml"

view: products_with_order_items {
  # We're creating an extended version of the products view, which produces a copy.
  # In this extended view, we add the sale_price dimension from the order_items view.
  # Since that means we'll always need to join to order items, it makes sense to turn this
  # into its own view, separate from the original products view, to keep from any sneaky
  # errors working their way in
  extends: [products]

  dimension: sale_price {
    type: number
    sql: ${order_items.sale_price} ;;
  }
}
