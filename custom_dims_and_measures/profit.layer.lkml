include: "/_layers/_base.layer"

view: +order_items {
##########################################################
#                     CUSTOM DIMENSIONS                  #
##########################################################

  dimension: gross_margin_percent {
    description: "
    Item's percent margin relative to cost
    "
    type: number
    sql: ${profit} / ${sale_price} ;;
    value_format_name: percent_1
  }

  dimension: profit {
    description: "
    Item's sale price minus its cost.
    "
    type: number
    sql: ${sale_price} - ${products.cost} ;;
    value_format_name: usd
  }

  parameter: rank_parameter {
    type: number
  }

##########################################################
#                     CUSTOM MEASURES                    #
##########################################################

  measure: gross_margin_percent_average {
    label: "Average Gross Margin Percent"
    description: "
    Profit / Sale Price, shows the average percent margin across a grouping
    "
    type: average
    sql: ${gross_margin_percent} ;;
    value_format_name: percent_0
    filters: [status: "-Cancelled, -Returned"]
  }

  measure: profit_total {
    label: "Total Profit"
    description: "
    Item's sale price minus its cost.
    "
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
    filters: [status: "-Cancelled, -Returned"]
  }

  measure: profit_running_total {
    type: running_total
    sql: ${profit_total} ;;
    direction: "column"
    value_format_name: usd
  }
}
