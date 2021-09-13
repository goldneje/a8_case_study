include: "../../../views/order_items.view"

view: order_items_view_extended {
  extends: [order_items]

 dimension: extends_dimension {
  group_label: "Extends Fields"
   type: number
  sql: 1 ;;
 }

}
