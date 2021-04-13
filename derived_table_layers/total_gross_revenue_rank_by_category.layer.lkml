# If necessary, uncomment the line below to include explore_source.
include: "/_layers/_basic.layer"

view: +order_items {
  measure: total_gross_revenue_rank {
    hidden: yes
    type: number
    sql: RANK() OVER(PARTITION BY ${products.category} ORDER BY ${total_gross_revenue} DESC) ;;
  }
}

view: +products {
  dimension: brand_category {
    description: "Concatenated field of brand and category for use as primary key in derived table"
    hidden: yes
    sql: CONCAT(${brand}, ${category}) ;;
  }
}

view: tgr_revenue_rank_by_category {
  derived_table: {
    explore_source: order_items {
      column: total_gross_revenue_rank {}
      column: total_gross_revenue {}
      column: category { field: products.category }
      column: brand { field: products.brand }
      column: pk2_brand_category { field: products.brand_category }
    }
  }
  dimension: total_gross_revenue_rank {
    type: number
  }

  dimension: total_gross_revenue {
    type: number
    value_format_name: usd
  }

  dimension: category {
    hidden: yes
  }
  dimension: brand {
    hidden: yes
  }
  dimension: pk2_brand_category {
    primary_key: yes
    hidden: yes
  }
  measure: total_gross_revenue_tiebreaker {
    type: number
    sql: ROW_NUMBER() OVER(PARTITION BY ${total_gross_revenue_rank} ORDER BY ${total_gross_revenue}) ;;

  }
}

explore: +order_items {
  join: tgr_revenue_rank_by_category {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.brand_category} = ${tgr_revenue_rank_by_category.pk2_brand_category} ;;
  }
}
