

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

  dimension: funnel_step {
    group_label: " Funnel View"
    type: string
    case: {
      when: {
        sql: ${event_type} IN ('Home', 'Register') ;;
        label: "(1) Land"
      }
      when: {
        sql: ${event_type} IN ('Category', 'Brand') ;;
        label: "(2) Browse Inventory"
      }
      when: {
        sql: ${event_type} = 'Product' ;;
        label: "(3) View Product"
      }
      when: {
        sql: ${event_type} = 'Cart' ;;
        label: "(4) Add Item to Cart"
      }
      when: {
        sql: ${event_type} = 'Purchase' ;;
        label: "(5) Purchase"
      }
    }
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

  dimension: is_landing_event {
    hidden: yes
    type: yesno
    sql: ${event_type} IN ('Home', 'Register') ;;
  }

  measure: number_of_sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: number_of_browse_events {
    type: sum
    #  Casting boolean yesno column as int to be summed
    sql: ${is_browse_event}::int ;;
  }

  measure: number_of_purchase_events {
    type: sum
    # Casting boolean yesno column as int to be summed
    sql: ${is_purchase_event}::int ;;
  }

  measure: number_of_cart_events {
    type: sum
    sql: ${is_cart_event}::int ;;
  }

  measure: number_of_landing_events {
    type: sum
    sql: ${is_landing_event}::int ;;
  }

  measure: number_of_cancel_events {
    type: sum
    sql: ${is_cancel_event}::int ;;
  }

  measure: number_of_product_events {
    type: sum
    sql: ${is_product_event}::int ;;
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
      column: session_start {}
      column: session_end {}
      column: number_of_browse_events {}
      column: number_of_purchase_events {}
      column: number_of_product_events {}
      column: number_of_cart_events {}
      column: number_of_cancel_events {}
      column: number_of_landing_events {}
      column: landing_event_id {}
      column: bounce_event_id {}
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

  dimension: number_of_browse_events {
    hidden: yes
    type: number
  }

  dimension: number_of_purchase_events {
    hidden: yes
    type: number
  }

  dimension: number_of_cart_events {
    hidden: yes
    type: number
  }

  dimension: number_of_cancel_events {
    hidden: yes
    type: number
  }

  dimension: number_of_product_events {
    hidden: yes
    type: number
  }

  dimension: number_of_landing_events {
    hidden: yes
    type: number
  }

  dimension: landing_event_id {}

  dimension: bounce_event_id {}

  dimension: furthest_funnel_step {
    group_label: " Funnel View"
    type: string
    case: {
      when: {
        sql: ${number_of_purchase_events} > 0 ;;
        label: "(5) Purchase"
      }
      when: {
        sql: ${number_of_cart_events} > 0 ;;
        label: "(4) Add Item to Cart"
      }
      when: {
        sql: ${number_of_product_events} > 0 ;;
        label: "(3) View Product"
      }
      when: {
        sql: ${number_of_browse_events} > 0 ;;
        label: "(2) Browse Inventory"
      }
      when: {
        sql: ${number_of_landing_events} > 0 ;;
        label: "(1) Land"
      }
    }
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

  measure: average_seconds_per_session {
    description: "
    Gives the average session length in minutes
    "
    label: "Average Seconds per Session"
    type: average
    sql: ${seconds_session_length};;
    value_format_name: decimal_2
  }
}

explore: +events {
  join: event_session_length {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_session_length.pk1_session_id} = ${events.session_id} ;;
    relationship: many_to_one
  }
}
