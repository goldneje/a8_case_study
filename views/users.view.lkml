view: users {
  sql_table_name: `looker-partners.thelook.users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [15, 26, 36, 51, 66]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: is_new_customer {
    type: yesno
    sql: ((( users.created_at  ) >= ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'America/Los_Angeles'), 'America/Los_Angeles'), INTERVAL -89 DAY), 'America/Los_Angeles'))) AND ( users.created_at  ) < ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'America/Los_Angeles'), 'America/Los_Angeles'), INTERVAL -89 DAY), 'America/Los_Angeles'), 'America/Los_Angeles'), INTERVAL 90 DAY), 'America/Los_Angeles'))))) ;;

  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
    #drill_fields: [product.category, product.brand]
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    drill_fields: [age_tier, gender]
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

}
