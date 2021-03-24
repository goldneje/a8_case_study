# Note that this layer gets hidden at the explore level.
# Anything added here will not be visible to the business users.
# order_sequence_2 adds new layers and dimensionalizes them for
# use by business users.

include: "/_layers/_base.layer"

# Adding a new measure to order_items
view: +order_items {
  measure: order_sequence {
    description: "
    Shows the sequence that orders occurred per user,
    used for creating flags for whether an order is a users' first, whether
    a user is a return customer, etc.
    "
    type: number
    sql: ROW_NUMBER() OVER(PARTITION BY ${user_id} ORDER BY ${created_date}) ;;
  }
}

# Create a new derived table using this measure
view: order_sequence_1 {
  derived_table: {
    explore_source: order_items {
      column: pk1_order_id {field: order_items.order_id}
      column: order_sequence {}
      column: user_id {}
      column: created_date {}
    }
    datagroup_trigger: case_studies_default_datagroup
  }
  dimension: pk1_order_id {
    primary_key: yes
    type: number
  }
  dimension: created_date {
    type: date
  }
  dimension: order_sequence {
    description: "
    Shows the sequence that orders occurred per user,
    used for creating flags for whether an order is a users' first, whether
    a user is a return customer, etc.
    "
    type: number
  }
  dimension: user_id {
    label: "derived_user_id"
    # hidden: yes
    type: number
  }
}

# Add custom dimesions/measures to the derived table
# order_sequence_1 will be hidden at the explore level, so I don't need to hide these measures
view: +order_sequence_1 {
  measure: is_first_order {
    description: "Yes/No flag showing whether an order is a users' first"
    type: yesno
    sql: ${order_sequence} = 1 ;;
  }

  measure: previous_order_date {
    type: date
    sql: CASE
        WHEN LAG(${user_id}, 1) OVER(ORDER BY ${user_id}, ${order_sequence}) = ${user_id}
          THEN LAG(${created_date}, 1) OVER(ORDER BY ${user_id}, ${order_sequence})
        ELSE NULL
        END ;;
  }

  measure: subsequent_order_date {
    type: date
    sql: CASE
        WHEN LEAD(${user_id}, 1) OVER(ORDER BY ${user_id}, ${order_sequence}) = ${user_id}
          THEN LEAD(${created_date}, 1) OVER(ORDER BY ${user_id}, ${order_sequence})
        ELSE NULL
        END ;;
  }

  measure: has_subsequent_purchase {
    type: yesno
    sql: ${subsequent_order_date} IS NOT NULL ;;
  }
}

# Creating a hidden explore used to generate the next derived table
explore: order_sequence_1 {hidden: yes}
