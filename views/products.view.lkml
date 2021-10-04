view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  # dimension: metric_value {
  #   type: number
  #   sql: {% parameter metric %} ;;
  # }

  # parameter: metric {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Sale Price"
  #     value: "order_items.sale_price"
  #   }
  #   allowed_value: {
  #     label: "Cost"
  #     value: "products.cost"
  #   }
  # }

  # parameter: aggregate {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Sum"
  #     value: "SUM"
  #   }
  #   allowed_value: {
  #     label: "Average"
  #     value: "AVG"
  #   }
  # }

  # parameter: date_breakdown_selection {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Day"
  #     value: "day"
  #   }
  #   allowed_value: {
  #     label: "Month"
  #     value: "month"
  #   }
  #   allowed_value: {
  #     label: "Year"
  #     value: "year"
  #   }
  #   default_value: "day"
  # }

  # measure: dynamic_measure {
  #   label_from_parameter: metric
  #   type: number
  #   sql: {% parameter aggregate %}( {% parameter metric %} ) ;;
  # }

  # dimension: parameter_if_statement {
  #   type: date
  #   sql:
  #     {% if products.date_breakdown_selection._parameter_value == 'day' %}
  #       ${order_items.created_date}
  #     {% elsif products.date_breakdown_selection._parameter_value == 'month' %}
  #       ${order_items.created_month}
  #     {% else %}
  #       ${order_items.created_year}
  #     {% endif %}
  #   ;;
  # }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }
}
