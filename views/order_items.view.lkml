view: order_items {
  sql_table_name: `looker-partners.thelook.order_items`
    ;;
  drill_fields: [id]

# Goal is to create a parameter that switches between count and sum_sale_price
# when we change the parameter value on an explore/look/dashboard
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: sum_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }
# SUM(sale_price)

# Creating a parameter that lets us choose between multiple measure options
# The parameter itself doesn't do anything, we still have to build the dynamic measure below
  parameter: dynamic_measure_selection {
    type: unquoted
    allowed_value: {
      label: "Count" # Front end, what the user sees
      value: "count" # back end, how to reference this in Looker
    }
    allowed_value: {
      label: "Sum Sale Price"
      value: "sum_sale_price"
    }
    # add as many allowed_values as needed for the different measures
    default_value: "count"
  }

# Create the dynamic measure, change the sql: value of this dynamic measure depending on the parameter selection
  measure: dynamic_measure {
    type: number # this is important if we're passing through existing measure values
    label_from_parameter: dynamic_measure_selection # use this to use labels from the parameter
    sql:
    {% if dynamic_measure_selection._parameter_value == 'count' %} ${count}
    {% elsif dynamic_measure_selection._parameter_value == 'sum_sale_price' %} ${sum_sale_price}
    {% else %} ${count}
    {% endif %}
    ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.first_name,
      users.id
    ]
  }
}
