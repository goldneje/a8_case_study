include: "/_layers/_base.layer"

view: +order_items {

  # This creates a filter-only field that can be selected and used in conjunction
  # with any field that uses the liquid to access the parameter
  parameter: calculation_select {
    description: "Use this filter with the Sale Price Metric Picker"
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "SUM"
    }
    allowed_value: {
      label: "Average Sale Price"
      value: "AVG"
    }
    allowed_value: {
      label: "Minimum Sale Price"
      value: "MIN"
    }
    allowed_value: {
      label: "Maximum Sale Price"
      value: "MAX"
    }
  }


  measure: sale_price_metric_picker {
    description: "
      Use this in conjunction with the calculation_select
      parameter to pick which metric to use
    "
    type: number
    sql: {% parameter calculation_select %}(${sale_price}) ;;
    value_format_name: usd
  }
}
