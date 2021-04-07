include: "/_layers/_base.layer"
include: "/derived_table_layers/event_session_length.layer"

view: +events {

  dimension: days_before_now {
    description: "
    Gives the number of days before the current day,
    used to generate flags for specific period over period
    analysis.
    "
    hidden: yes
    type: duration_day
    sql_start: ${event_session_length.session_end} ;;
    sql_end: CURRENT_DATE() ;;
  }

  dimension: is_last_30_days {
    description: "
    Flag indicating whether a record occurred in the last 30 days or not
    "
    hidden: yes
    type: yesno
    sql: ${days_before_now} < 30 ;;
  }

  dimension: is_between_30_to_60_days {
    hidden: yes
    type: yesno
    sql: ${days_before_now} BETWEEN 30 and 60 ;;
  }

  measure: count_last_30_days {
    type: count_distinct
    filters: [is_last_30_days: "Yes"]
    sql: ${session_id} ;;
  }

  measure: count_30_to_60_days {
    type: count_distinct
    filters: [is_between_30_to_60_days: "Yes"]
    sql: ${session_id} ;;
  }

  measure: percent_change_previous_30_day_period {
    type: number
    sql: (${count_last_30_days} - ${count_30_to_60_days}) / nullif(${count_last_30_days}, 0) ;;
    value_format_name: percent_2
  }
}
