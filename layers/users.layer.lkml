include: "/layers/_base.layer"

view: +users {

  dimension: age_cohort {
    group_label: "~Demographics"
    type: tier
    tiers: [18, 25, 40, 50, 65]
    sql: ${age} ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
  }

##########################################################
#                      MEASURES                          #
##########################################################

  measure: age_average {
    label: "Age | Average"
    type: average
    sql: ${age} ;;
  }
}
