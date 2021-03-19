include: "/_layers/_basic.layer"

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

##########################################################
#                     CUSTOM MEASURES                    #
##########################################################


}
