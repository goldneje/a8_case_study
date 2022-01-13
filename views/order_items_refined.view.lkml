include: "/views/order_items.view"

view: +order_items {

  dimension: is_sale {
    type: yesno
    sql: ${status} not in ('Cancelled', 'Returned')  ;;
  }

  measure: sum_sale_price {
    label: "Gross Sales"
    type: sum
    sql: ${sale_price} ;;
  }

  measure: percent_of_total_sales {
    label: "Percent of Total Sales"
    type: percent_of_total
    sql: ${sum_sale_price} ;;
  }

}
