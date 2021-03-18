explore: distribution_centers {}
view: distribution_centers {
  sql_table_name: "PUBLIC"."DISTRIBUTION_CENTERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }
}

explore: etl_jobs {}
view: etl_jobs {
  sql_table_name: "PUBLIC"."ETL_JOBS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: completed {
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
    sql: ${TABLE}."COMPLETED_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
view: events {
  sql_table_name: "PUBLIC"."EVENTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}."BROWSER" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension_group: created {
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

  dimension: event_type {
    type: string
    sql: ${TABLE}."EVENT_TYPE" ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}."IP_ADDRESS" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}."OS" ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}."SEQUENCE_NUMBER" ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}."SESSION_ID" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}."URI" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id]
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
view: inventory_items {
  sql_table_name: "PUBLIC"."INVENTORY_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension_group: created {
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
    type: string
    sql: ${TABLE}."PRODUCT_BRAND" ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}."PRODUCT_DEPARTMENT" ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}."PRODUCT_DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}."PRODUCT_RETAIL_PRICE" ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}."PRODUCT_SKU" ;;
  }

  dimension_group: sold {
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
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }}
view: order_items {
    sql_table_name: "PUBLIC"."ORDER_ITEMS"
      ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}."ID" ;;
    }

    dimension_group: created {
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

    dimension_group: delivered {
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
      sql: ${TABLE}."DELIVERED_AT" ;;
    }

    dimension: inventory_item_id {
      type: number
      # hidden: yes
      sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
    }

    dimension: order_id {
      type: number
      sql: ${TABLE}."ORDER_ID" ;;
    }

    dimension_group: returned {
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
      sql: ${TABLE}."RETURNED_AT" ;;
    }

    dimension: sale_price {
      type: number
      sql: ${TABLE}."SALE_PRICE" ;;
    }

    dimension_group: shipped {
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
      sql: ${TABLE}."SHIPPED_AT" ;;
    }

    dimension: status {
      type: string
      sql: ${TABLE}."STATUS" ;;
    }

    dimension: user_id {
      type: number
      # hidden: yes
      sql: ${TABLE}."USER_ID" ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    # ----- Sets of fields for drilling ------
    set: detail {
      fields: [
        id,
        inventory_items.product_name,
        inventory_items.id,
        users.last_name,
        users.first_name,
        users.id
      ]
    }
  }

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
view: products {
    sql_table_name: "PUBLIC"."PRODUCTS"
      ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}."ID" ;;
    }

    dimension: brand {
      type: string
      sql: ${TABLE}."BRAND" ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}."CATEGORY" ;;
    }

    dimension: cost {
      type: number
      sql: ${TABLE}."COST" ;;
    }

    dimension: department {
      type: string
      sql: ${TABLE}."DEPARTMENT" ;;
    }

    dimension: distribution_center_id {
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

explore: users {}
view: users {
    sql_table_name: "PUBLIC"."USERS"
      ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}."ID" ;;
    }

    dimension: age {
      type: number
      sql: ${TABLE}."AGE" ;;
    }

    dimension: city {
      type: string
      sql: ${TABLE}."CITY" ;;
    }

    dimension: country {
      type: string
      map_layer_name: countries
      sql: ${TABLE}."COUNTRY" ;;
    }

    dimension_group: created {
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

    dimension: email {
      type: string
      sql: ${TABLE}."EMAIL" ;;
    }

    dimension: first_name {
      type: string
      sql: ${TABLE}."FIRST_NAME" ;;
    }

    dimension: gender {
      type: string
      sql: ${TABLE}."GENDER" ;;
    }

    dimension: last_name {
      type: string
      sql: ${TABLE}."LAST_NAME" ;;
    }

    dimension: latitude {
      type: number
      sql: ${TABLE}."LATITUDE" ;;
    }

    dimension: longitude {
      type: number
      sql: ${TABLE}."LONGITUDE" ;;
    }

    dimension: state {
      type: string
      sql: ${TABLE}."STATE" ;;
    }

    dimension: traffic_source {
      type: string
      sql: ${TABLE}."TRAFFIC_SOURCE" ;;
    }

    dimension: zip {
      type: zipcode
      sql: ${TABLE}."ZIP" ;;
    }

    measure: count {
      type: count
      drill_fields: [id, last_name, first_name, events.count, order_items.count]
    }
  }
