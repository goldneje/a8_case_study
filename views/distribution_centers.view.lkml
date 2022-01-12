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
    link: {
      label: "Drill to Cancelled Orders Detail"
      url: "{{ order_items.number_cancelled._link }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }
}
