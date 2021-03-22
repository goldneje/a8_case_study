include: "/derived_table_layers/*"

# Here we will include all hidden fields within derived tables
# in order to see which dimensions/measures are hidden at a glance

view: +order_sequence_2 {
  dimension: order_id {
    hidden: yes
  }

  dimension: created_date {
    hidden: yes
  }

  dimension: user_id {
    hidden: yes
  }

  dimension: order_sequence {
    hidden: yes
  }

  measure: number_of_orders {
    hidden: yes
  }
}

view: +profit_per_order {
  dimension: id {
    hidden: yes
  }

  dimension: order_id {
    hidden: yes
  }

  dimension: profit_per_order {
    hidden: yes
  }
}

# Creating a hidden explore used to generate the next derived table
explore: +order_sequence_1 {hidden: yes}
