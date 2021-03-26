# This layer includes all location transformations

include: "/_layers/_base.layer"

view: +distribution_centers {

##########################################################
#                     CUSTOM DIMENSIONS                  #
##########################################################

  dimension: location {
    group_label: "~Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
}

view: +users {

##########################################################
#                     CUSTOM DIMENSIONS                  #
##########################################################

  dimension: location {
    description: "Properly formatted user location, can be used in maps!"
    group_label: "~Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
}
