connection: "snowlooker"

# include all the views
include: "/_layers/_base.layer"
include: "/_layers/_basic.layer"

include: "/calculations/delivery_duration.layer"
include: "/calculations/pop_order_items.layer"
include: "/calculations/profit.layer"
include: "/calculations/revenue.layer"

include: "/derived_table_layers/order_sequence_1.layer"
include: "/derived_table_layers/order_sequence_2.layer"
include: "/derived_table_layers/profit_per_order.layer"

include: "/group_labels/~delivery_duration.group"
include: "/group_labels/~demographics.group"
include: "/group_labels/~ids.group"
include: "/group_labels/~location.group"
include: "/group_labels/~order_sequence.group"
include: "/group_labels/~product_attribute.group"
include: "/group_labels/~profit.group"
include: "/group_labels/~profit_per_order.group"
include: "/group_labels/~revenue.group"

include: "/hidden/_hidden_orig.layer"
include: "/hidden/_hidden_derived.layer"

include: "/parameters_and_filters/calculation_selector.layer"
include: "/parameters_and_filters/category_filter.layer"

include: "/pop_support/pop_support"

datagroup: case_studies_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup
