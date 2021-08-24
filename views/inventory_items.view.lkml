view: inventory_items {
  sql_table_name: "PUBLIC"."INVENTORY_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden:  yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: cost {
    view_label: "Inventory"
    hidden:  yes
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension_group: created {
    view_label: "Inventory"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: product_brand {
    view_label: "Inventory"
    type: string
    sql: ${TABLE}."PRODUCT_BRAND" ;;
  }

  dimension: product_category {
    view_label: "Inventory"
    type: string
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: product_department {
    view_label: "Inventory"
    type: string
    sql: ${TABLE}."PRODUCT_DEPARTMENT" ;;
  }

  dimension: product_distribution_center_id {
    view_label: "Inventory"
    type: number
    sql: ${TABLE}."PRODUCT_DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: product_id {
    view_label: "Inventory"
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  dimension: product_name {
    view_label: "Inventory"
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }

  dimension: product_retail_price {
    view_label: "Inventory"
    type: number
    sql: ${TABLE}."PRODUCT_RETAIL_PRICE" ;;
  }

  dimension: product_sku {
    view_label: "Inventory"
    type: string
    sql: ${TABLE}."PRODUCT_SKU" ;;
  }

  dimension_group: sold {
    view_label: "Inventory"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOLD_AT" ;;
  }

  measure: count {
    view_label: "Inventory"
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }

  measure: cost_of_goods_sold{
    view_label: "Inventory"
    type: sum
    value_format_name: usd
    sql: ${TABLE}."COST" ;;
  }
}
