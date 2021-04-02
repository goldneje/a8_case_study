include: "/_layers/_base.layer"

view: +products {

  parameter: category_selector {
    description: "
      Use this parameter with 'Dynamic Category Count'
      to change which category is counted via the filter box
    "
    type: string
    suggest_dimension: category
  }

  measure: category_to_count {
    label: "Count of {% parameter category_selector %} Category"
    type: sum
    sql:
      CASE
        WHEN ${category} = {% parameter category_selector %}
        THEN 1
        ELSE 0
      END
    ;;
  }

  parameter: brand_parameter {
    type: string
    suggest_dimension: brand
  }

  dimension: is_current_brand_parameter {
    type: yesno
    sql: {% parameter brand_parameter %} = ${brand} ;;
  }

}
