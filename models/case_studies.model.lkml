connection: "snowlooker"

# include all the views
include: "/_layers/_base.layer"
include: "/_layers/_basic.layer"

include: "/derived_table_layers/order_sequence_1.layer"
include: "/derived_table_layers/order_sequence_2.layer"
include: "/derived_table_layers/profit_per_order.layer"

datagroup: case_studies_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup
