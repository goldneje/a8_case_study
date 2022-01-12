connection: "snowlooker"

# include all the views
include: "/views/**/*.view"

# include LookML dashboards
include: "/dashboards/*.dashboard"

datagroup: case_studies_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: case_studies_default_datagroup

explore: distribution_centers {}

explore: etl_jobs {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# This is the first explore in our merged query, we'll want to join it to users so we can get more detail on the user. Let's say we want to pull in the user's
# first and last name along with the number of orders placed in the last day. Right now, we can't do that through either explore alone.

explore: order_items {}

explore: users {}
