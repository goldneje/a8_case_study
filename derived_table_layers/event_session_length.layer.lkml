include: "/_layers/_base.layer"

# Creating new measures to be used in derived table
view: +events {

  dimension: browse_product_id {
    type: number
    sql:
      CASE
        WHEN ${event_type} = 'Product' THEN right(${uri},length(${uri}) - 9)
      END ;;
  }

  dimension: is_browse_event {
    hidden: yes
    type: yesno
    sql: ${event_type} IN ('Category', 'Brand') ;;
  }

  dimension: is_purchase_event {
    hidden: yes
    type: yesno
    sql: ${event_type} = 'Purchase' ;;
  }

  dimension: is_cart_event {
    hidden: yes
    type: yesno
    sql: ${event_type} = 'Cart' ;;
  }

  dimension: is_product_event {
    hidden: yes
    type: yesno
    sql: ${event_type} = 'Product' ;;
  }

  dimension: is_cancel_event {
    hidden: yes
    type: yesno
    sql: ${event_type} = 'Cancel' ;;
  }

  measure: number_of_browse_events {
    type: sum
    #  boolean yesno column as int to be summed
    sql: ${is_browse_event}::int ;;
    # filters: [is_browse_event: "Yes"]
  }

  measure: number_of_purchase_events {
    type: sum
    # Casting boolean yesno column as int to be summed
    sql: ${is_purchase_event}::int ;;
    # filters: [is_purchase_event: "Yes"]
  }

  measure: number_of_cart_events {
    type: sum
    sql: ${is_cart_event}::int ;;
    # filters: [is_cart_event: "Yes"]
  }

  measure: number_of_cancel_events {
    type: sum
    sql: ${is_cancel_event}::int ;;
    # filters: [is_cancel_event: "Yes"]
  }

  measure: session_start {
    description: "The beginning of a user's website session"
    hidden: yes
    type: date_raw
    sql: MIN(${created_raw}) ;;
  }

  measure: session_end {
    description: "The end of a user's website session"
    hidden: yes
    type: date_raw
    sql: MAX(${created_raw}) ;;
  }

  measure: landing_event_id {
    description: "
    The first event id, use with session_id to get the bounce event id
    Not meant for business users, should be used to derive other fields.
    "
    type: min
    sql: ${pk1_event_id} ;;
  }

  measure: bounce_event_id {
    description: "
    The last event id, use with session_id to get the bounce event id
    Not meant for business users, should be used to derive other fields.
    "
    type: max
    sql: ${pk1_event_id} ;;
  }
}

# Create the derived table
view: event_session_length {
  derived_table: {
    explore_source: events {
      column: pk1_session_id {field: events.session_id}
      column: session_start {field: events.session_start}
      column: session_end {field: events.session_end}
    }
  }
  dimension: pk1_session_id {
    primary_key: yes
    hidden: yes
  }

  dimension: session_start {
    hidden: yes
    description: "The beginning of a user's website session"
    label: "Session Start"
    type: date_raw
  }

  dimension: session_end {
    hidden: yes
    description: "The end of a user's website session"
    label: "Session End"
    type: date_raw
  }

  dimension_group: session_length {
    hidden: yes
    type: duration
    intervals: [
      hour,
      minute,
      second
    ]
    sql_start: ${session_start} ;;
    sql_end: ${session_end} ;;
  }

  measure: average_minutes_session_length_by_event_type {
    description: "
    Gives the average session length in minutes,
    use this with the Event Picker parameter to
    switch between Purchase and Canceled event types.
    Use with no parameter to average across all event types
    "
    label: "Average Minutes per Session"
    type: average
    sql: ${minutes_session_length};;
    filters: [events.event_type: "Cancel, Purchase"]
    value_format_name: decimal_2
  }
}

explore: +events {
  join: event_session_length {
    view_label: "Website Activity"
    type: left_outer
    sql_on: ${event_session_length.pk1_session_id} = ${events.session_id} ;;
    relationship: many_to_one
  }
}
