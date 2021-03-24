include: "/_layers/_base.layer"

view: +order_items {
  measure: total_gross_revenue {

    description: "
    Total gross revenue of items that are not returned or cancelled.
    Calculated as the sum of the sale price of the item.
    "

    type: sum

    sql: ${sale_price} ;;

    value_format_name: usd

    filters: [status: "-Cancelled, -Returned"]

  }
}
