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

    # Can link to a measure field's drill menu. Note this only works for measures and will filter by the field you selected.
    link: {
      label: "Drill to Cancelled Orders Detail"
      # The ._link operator below will only work with measure fields. Otherwise, it will return you to the same explore
      url: "{{ order_items.number_cancelled._link }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }
}
