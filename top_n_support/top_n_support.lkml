include: "/_layers/_basic.layer"
include: "/custom_dims_and_measures/revenue.layer"

view: ndt_top_ranking {
  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: order_items {
      bind_all_filters: yes
      column: brand_name { field: products.brand }
      column: order_items_count { field: order_items.count}
      column: order_items_sales_price { field: order_items.total_gross_revenue }
      derived_column: ranking {
        sql: rank() over (order by order_items.total_sale_price desc) ;;
      }
    }
  }

  dimension: brand_name {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: brand_rank {
    hidden: yes
    type: string
    sql: ${TABLE}.ranking ;;
  }

  parameter: top_n {
    description: "Use this parameter to set the number of results to return"
    type: number
  }

  parameter: top_n_calculation {

    description: "Type of calculation to use to derive the top n"

    type: unquoted

    allowed_value: {

      label: "Total"

      value: "SUM"
    }

    allowed_value: {

      label: "Average"

      value: "AVG"

    }

    allowed_value: {

      label: "Maximum"

      value: "MAX"

    }

    allowed_value: {

      label: "Minimum"

      value: "MIN"

    }

  }
}
