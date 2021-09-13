include: "../../../views/order_items.view"

view: order_items_view_extended {
  extends: [order_items]

  # Add dimensions that will ONLY be part of extended view (not original view)
  dimension: extends_dimension {
  group_label: "Extends Fields"
  type: number
  sql: 1 ;;
 }

}
