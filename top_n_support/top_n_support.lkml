include: "/_layers/_basic.layer"
include: "/custom_dims_and_measures/revenue.layer"

view: ndt_top_ranking {
  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: order_items {
      bind_all_filters: yes
      column: brand_name { field: products.brand }
      # column: order_items_count { field: order_items.count}
      column: order_items_sales_price { field: order_items.total_gross_revenue }
      derived_column: ranking {
        sql: rank() over (order by order_items_sales_price desc) ;;
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

  dimension: order_items_sales_price {
    hidden: yes
    type: number
  }

  parameter: top_n {
    type: number
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

}

explore: +order_items {
  join: ndt_top_ranking {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    type: inner
    sql_on: ${products.brand} = ${ndt_top_ranking.brand_name} ;;
    relationship: many_to_one
  }
}
