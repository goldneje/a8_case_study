connection: "snowlooker"

# include all the views
include: "/_layers/_base.layer"
include: "/_layers/_basic.layer"

include: "/custom_dims_and_measures/14_days_prior.layer"
include: "/custom_dims_and_measures/30_day_periods.layer"
include: "/custom_dims_and_measures/delivery_duration.layer"
include: "/custom_dims_and_measures/location.layer"
include: "/custom_dims_and_measures/pop_order_items.layer"
include: "/custom_dims_and_measures/profit.layer"
include: "/custom_dims_and_measures/revenue.layer"
include: "/custom_dims_and_measures/user_age_and_name.layer"

include: "/derived_table_layers/event_session_length.layer"
include: "/derived_table_layers/order_sequence_1.layer"
include: "/derived_table_layers/order_sequence_2.layer"
include: "/derived_table_layers/profit_per_order.layer"
include: "/derived_table_layers/total_gross_revenue_rank_by_category.layer"

include: "/group_labels/delivery_duration.group"
include: "/group_labels/demographics.group"
include: "/group_labels/ids.group"
include: "/group_labels/location.group"
include: "/group_labels/order_sequence.group"
include: "/group_labels/product_attribute.group"
include: "/group_labels/profit.group"
include: "/group_labels/profit_per_order.group"
include: "/group_labels/revenue.group"

include: "/parameters_and_filters/calculation_selector.layer"
include: "/parameters_and_filters/category_filter.layer"

include: "/lookml_dashboards/lookml_test.dashboard"

include: "/pop_support/pop_support"

include: "/top_n_support/top_n_support"

# include LookML dashboards
include: "/dashboards/*.dashboard"

datagroup: case_studies_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup
