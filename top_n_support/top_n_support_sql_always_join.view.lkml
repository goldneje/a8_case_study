include: "/_layers/_basic.layer"
include: "/custom_dims_and_measures/revenue.layer"
include: "/custom_dims_and_measures/profit.layer"

view: ndt_top_ranking {
  derived_table: {
    #   # parameter value specifies which of the rankings from the inner table to use
    #   explore_source: order_items {
    #     bind_all_filters: yes
    #     column: brand_name { field: products.brand }
    #     column: category { field: products.category }
    #     column: order_items_count { field: order_items.count }
    #     column: order_items_gross_margin_average { field: order_items.gross_margin_percent_average}
    #     column: order_items_profit { field: order_items.profit_total}
    #     column: order_items_total_revenue { field: order_items.total_gross_revenue }
    #     derived_column: ranking {
    #       sql: rank() over (partition by brand_name order by order_items_total_revenue desc) ;;
    #     }
    #     derived_column: total_amount {
    #       sql: sum(order_items_total_revenue) over(partition by brand_name) ;;
    #     }
    #   }
    sql:
      SELECT as2061e2fc0c5.*,
             rank() over (partition by brand_name order by order_items_total_revenue desc)  AS ranking,
      sum(order_items_total_revenue) over(partition by brand_name)  AS total_amount
      FROM (SELECT
          products."BRAND"  AS brand_name,
          products."CATEGORY"  AS category,
          COUNT(*) AS order_items_count,
          AVG(CASE WHEN (order_items."STATUS"  NOT IN ('Cancelled', 'Returned') OR (order_items."STATUS") IS NULL) THEN ( ((order_items."SALE_PRICE") - (products."COST")) / (order_items."SALE_PRICE")  )  ELSE NULL END) AS order_items_gross_margin_average,
          COALESCE(SUM(CASE WHEN (order_items."STATUS"  NOT IN ('Cancelled', 'Returned') OR (order_items."STATUS") IS NULL) THEN ( (order_items."SALE_PRICE") - (products."COST")  )  ELSE NULL END), 0) AS order_items_profit,
          COALESCE(SUM(CASE WHEN (order_items."STATUS"  NOT IN ('Cancelled', 'Returned') OR (order_items."STATUS") IS NULL) THEN ( order_items."SALE_PRICE"  )  ELSE NULL END), 0) AS order_items_total_revenue
      FROM "PUBLIC"."ORDER_ITEMS"
             AS order_items
      LEFT JOIN "PUBLIC"."INVENTORY_ITEMS"
           AS inventory_items ON (order_items."INVENTORY_ITEM_ID") = (inventory_items."ID")
      LEFT JOIN "PUBLIC"."PRODUCTS"
             AS products ON (inventory_items."PRODUCT_ID") = (products."ID")
      GROUP BY
          1,
          2) as2061e2fc0c5
       ;;
  }

  dimension: pk2_brand_category {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${brand_name}||${category} ;;
  }

  dimension: brand_name {
    # primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: total_amount {}

  dimension: category {
    hidden: yes
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
    value_format_name: percent_1
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

  # dimension: brand_name_top_brands {
  #   view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
  #   label: "Brands (Top {% if top_n._is_filtered %}{% parameter top_n %}{% else %}N{% endif %})"
  #   order_by_field: brand_rank_top_brands
  #   type: string
  #   sql:
  #     CASE
  #       WHEN ${ranking}<={% parameter top_n %} THEN ${brand_name}
  #       ELSE 'Other'
  #     END
  #   ;;
  # }

  # dimension: brand_rank_top_brands {
  #   view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
  #   label: "Rank"
  #   type: string
  #   sql:
  #     CASE
  #       WHEN ${ranking}<={% parameter top_n %}
  #         THEN
  #           CASE
  #             WHEN ${ranking}<10 THEN  0 || cast(${ranking} as varchar)
  #             ELSE to_char(${ranking})
  #           END
  #       ELSE 'Other'
  #     END
  #   ;;
  # }

  dimension: category_name_top_categories {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    label: "Categories (Top {% if top_n._is_filtered %}{% parameter top_n %}{% else %}N{% endif %})"
    order_by_field: category_rank_top_categories
    type: string
    sql:
      CASE
        WHEN ${ranking}<=1 THEN ${category}
        ELSE NULL
      END
    ;;
  }

  dimension: category_rank_top_categories {
    view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
    label: "Category Rank"
    type: string
    sql:
      CASE
        WHEN ${ranking}<=1
          THEN
          -- Format the rank so that it orders properly
            CASE
              WHEN ${ranking}<10 THEN  0 || cast(${ranking} as varchar)
              ELSE to_char(${ranking})
            END
        ELSE NULL
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
    type: average
    sql:
      {% if rank_by._parameter_value == 'order_items_total_revenue' %} ${order_items_total_revenue}
      {% elsif rank_by._parameter_value == 'order_items_count' %} ${order_items_count}
      {% elsif rank_by._parameter_value == 'order_items_profit' %} ${order_items_profit}
      {% else %} ${order_items_gross_margin_average}
      {% endif %}
    ;;

      html:
      {% if rank_by._parameter_value == 'order_items_total_revenue' %} {{order_items.total_gross_revenue._rendered_value}}
      {% elsif rank_by._parameter_value == 'order_items_count' %} {{order_items.count._rendered_value}}
      {% elsif rank_by._parameter_value == 'order_items_profit' %} {{order_items.profit_total._rendered_value}}
      {% else %} {{order_items.gross_margin_percent_average._rendered_value}}
      {% endif %} ;;
    }

    measure: dynamic_percent_of_total {
      type: average
      sql:
      {% if rank_by._parameter_value == 'order_items_total_revenue' %} ${order_items_total_revenue} / NULLIF(${total_amount}, 0)
      {% elsif rank_by._parameter_value == 'order_items_count' %} ${order_items_count} / NULLIF(${total_amount}, 0)
      {% elsif rank_by._parameter_value == 'order_items_profit' %} ${order_items_profit} / NULLIF(${total_amount}, 0)
      {% else %} ${order_items_gross_margin_average} / NULLIF(${total_amount}, 0)
      {% endif %}
    ;;

        value_format_name: percent_1

        # html:
        # {% if rank_by._parameter_value == 'order_items_total_revenue' %} {{order_items.total_gross_revenue | divided_by: ndt_top_ranking.total_amount}}
        # {% elsif rank_by._parameter_value == 'order_items_count' %} {{order_items.count | divided_by: ndt_top_ranking.total_amount}}
        # {% elsif rank_by._parameter_value == 'order_items_profit' %} {{order_items.profit_total | divided_by: ndt_top_ranking.total_amount}}
        # {% else %} {{order_items.gross_margin_percent_average | divided_by: ndt_top_ranking.total_amount}}
        # {% endif %} ;;
      }

    }

    explore: +order_items {
      always_join: [ndt_top_ranking]
      join: ndt_top_ranking {
        view_label: "@{top_n_ranking_view_name}" # Constant defined in manifest.lkml file
        type: inner
        # sql: INNER JOIN ndt_top_ranking on ${products.brand} = ndt_top_ranking.brand_name AND ${products.category} = ndt_top_ranking.category ;;
        sql_on: ${products.brand}||${products.category} = ${ndt_top_ranking.pk2_brand_category} ;;
        relationship: many_to_one
        sql_where: ${ndt_top_ranking.category_name_top_categories} IS NOT NULL ;;
      }
    }
