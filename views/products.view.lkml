view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "IDs"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  measure: avg_cost {
    type: average
    sql: ${cost} ;;
  }

  measure: is_above_avg_cost {
    type: yesno
    sql: ${avg_cost} > 30 ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
    # suggest_dimension: inventory_items.product_category
    # suggest_explore: order_items
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: brand_avg_highlight {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }




  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    group_label: "IDs"
    hidden: yes
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

include: "/models/case_studies.model"

view: avg_cost_per_brand_dt {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: avg_cost { field: products.avg_cost }
    }
  }
  dimension: brand {
    primary_key: yes
  }
  dimension: avg_cost {
    type: number
  }
  measure: avg_cost_per_brand {
    type: average
    sql: ${avg_cost} ;;
  }
}

explore: +order_items {
  join: avg_cost_per_brand_dt {
    relationship: many_to_one
    sql_on: ${products.brand} = ${avg_cost_per_brand_dt.brand} ;;
  }
}
