include: "/_layers/_base.layer"

view: +users {

##########################################################
#                     CUSTOM DIMENSIONS                  #
##########################################################

  dimension: age_cohort {
    description: "Groupings of users by their age. Groupings are 18 and under, 18-24, 25-39, 40-49, 50-64, 65+"
    group_label: "~Demographics"
    type: tier
    tiers: [18, 25, 40, 50, 65]
    sql: ${age} ;;
  }

  dimension: full_name {
    description: "Full name of a user"
    type: string
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
  }

  dimension: location {
    description: "Properly formatted user location, can be used in maps!"
    group_label: "~Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

##########################################################
#                     CUSTOM MEASURES                    #
##########################################################

  measure: age_average {
    description: "The average age of a user"
    label: "Age | Average"
    type: average
    sql: ${age} ;;
  }
}
