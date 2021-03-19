connection: "snowlooker"

# include all the views
include: "/_layers/_base.layer"
include: "/_layers/_basic.layer"
include: "/custom_layers/users.layer"

datagroup: case_studies_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup
