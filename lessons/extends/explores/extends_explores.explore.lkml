include: "../views/order_items_view_extended.view.lkml"
include: "../../../views/users.view"

explore: view_original {
  from: order_items
  group_label: "Extends"
  label: "1) View Original"
  view_label: "Order Items"
}

# Extending a View
explore: view_extended {
  from: order_items_view_extended
  group_label: "Extends"
  label: "2) View Extended"
  view_label: "Order Items"
  description: "Extends a view (creates another version of it). Logic from original view is retained."
}

# Extending an Explore
explore: explore_extended {
  extends: [view_extended]
  group_label: "Extends"
  label: "3) Explore Extended"
  view_label: "Order Items"
  description: "Extends an explore (creates another version of it). Logic from original explore is retained."
  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${explore_extended.user_id} = ${users.id} ;;
  }
}
