view: order_items {
  sql_table_name: `looker-partners.thelook.order_items`
    ;;
  drill_fields: [id]

  # parameter: arr_mrr_switch {
  #   type: unquoted
  #   allowed_value: {
  #     label: "ARR"
  #     value: "ARR"
  #   }
  #   allowed_value: {
  #     label: "MRR"
  #     value: "MRR"
  #   }
  #   default_value: "No_Value_Selected"
  # }

  # dimension: mrr_dim {
  #   type: number
  #   sql: ${TABLE}.mrr_dim ;;
  # }

  # measure: mrr {
  #   type: sum
  #   sql: ${mrr_dim} ;;
  # }

  # measure: arr {
  #   type: sum
  #   sql: ${mrr_dim} * 12 ;;
  # }

  # measure: dynamic_mrr_or_arr {
  #   label: "{% assign param_value = order_items.arr_mrr_switch._parameter_value %}{% if param_value == 'No_Value_Selected' %}Dynamic MRR/ARR{% else %}{{ param_value }}{% endif %}"
  #   type: number
  #   sql:
  #   {% assign param_value = order_items.arr_mrr_switch._parameter_value %}
  #   {% if param_value == 'ARR'%}
  #     ${arr}
  #   {% elsif param_value == 'MRR' %}
  #     ${mrr}
  #   {% else %}
  #     'Error, please use the arr_mrr_switch'
  #   {% endif %}
  #   ;;
  # }

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

  measure: count {
    type: count
    drill_fields: [detail*]
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
