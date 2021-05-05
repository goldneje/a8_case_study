include: "/_layers/_basic.layer"
include: "/custom_dims_and_measures/revenue.layer"
include: "/custom_dims_and_measures/profit.layer"

view: ndt_top_ranking {
  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: order_items {
      bind_all_filters: yes
      column: brand_name { field: products.brand }
      column: order_items_count { field: order_items.count }
      column: order_items_gross_margin_average { field: order_items.gross_margin_percent_average}
      column: order_items_profit { field: order_items.profit_total}
      column: order_items_total_revenue { field: order_items.total_gross_revenue }
      derived_column: ranking {
        sql: rank() over (order by {% parameter rank_by %} desc) ;;
      }
    }
  }

  dimension: brand_name {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: ranking {
    hidden: yes
    type: string
    sql: ${TABLE}.ranking ;;
  }

  dimension: order_items_count {
    hidden: yes
    type: number
  }

  dimension: order_items_gross_margin_average {
    hidden: yes
    type: number
    value_format_name: percent_2
  }

  dimension: order_items_profit {
    hidden: yes
    type: number
    value_format_name: usd
  }

  dimension: order_items_total_revenue {
    hidden: yes
    type: number
    value_format_name: usd
  }

  dimension: brand_name_top_brands {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    label: "Brands (Top {% if top_n._is_filtered %}{% parameter top_n %}{% else %}N{% endif %})"
    order_by_field: brand_rank_top_brands
    type: string
    sql:
      CASE
        WHEN ${ranking}<={% parameter top_n %} THEN ${brand_name}
        ELSE 'Other'
      END
    ;;
  }

  dimension: brand_rank_top_brands {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    label: "Rank"
    type: string
    sql:
      CASE
        WHEN ${ranking}<={% parameter top_n %}
          THEN
            CASE
              WHEN ${ranking}<10 THEN  0 || cast(${ranking} as varchar)
              ELSE to_char(${ranking})
            END
        ELSE 'Other'
      END
    ;;
  }

  # measure: total_gross_revenue {
  #   type: sum
  #   sql: ${order_items_total_revenue} ;;
  #   value_format_name: usd
  # }

  parameter: top_n {
    type: number
  }

  parameter: rank_by {
    label: "Select Measure to Rank By"
    type: unquoted

    allowed_value: {
      label: "Total Gross Revenue"
      value: "order_items_total_revenue"
    }

    allowed_value: {
      label: "Total Items Sold"
      value: "order_items_count"
    }

    allowed_value: {
      label: "Total Profit"
      value: "order_items_profit"
    }

    allowed_value: {
      label: "Average Gross Margin Percentage"
      value: "order_items_gross_margin_average"
    }

    default_value: "order_items_total_revenue"
  }

  measure: dynamic_measure {
    description: "Use this along with the 'Rank by (Drop down selection)' filter to see the amounts for each rank"
    type: number
    sql:
      {% if rank_by._parameter_value == 'order_items_total_revenue' %} ${order_items.total_gross_revenue}
      {% elsif rank_by._parameter_value == 'order_items_count' %} ${order_items.count}
      {% elsif rank_by._parameter_value == 'order_items_profit' %} ${order_items.profit_total}
      {% else %} ${order_items.gross_margin_percent_average}
      {% endif %}
    ;;

    html:
      {% if rank_by._parameter_value == 'order_items_total_revenue' %} {{order_items.total_gross_revenue._rendered_value}}
      {% elsif rank_by._parameter_value == 'order_items_count' %} {{order_items.count._rendered_value}}
      {% elsif rank_by._parameter_value == 'order_items_profit' %} {{order_items.profit_total._rendered_value}}
      {% else %} {{order_items.gross_margin_percent_average._rendered_value}}
      {% endif %} ;;
  }
}

explore: +order_items {
  join: ndt_top_ranking {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    type: inner
    sql_on: ${products.brand} = ${ndt_top_ranking.brand_name} ;;
    relationship: many_to_one
  }
}
