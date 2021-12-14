include: "/access_grants"

view: users {
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

# Adding a required access grant on this field will remove it from the field picker
  dimension: age {
    required_access_grants: [can_see_pii]
    type: number
    sql: ${TABLE}."AGE" ;;
  }

# Adding a required access grant on this field will remove it from the field picker
  dimension: age_masked {
    type: number
    sql:
    {% if _user_attributes['first_name'] == 'Carmen' %}
      ${TABLE}."AGE"
    {% else %}
      MD5(${TABLE}."AGE")
    {% endif %} ;;
  }

# But this measure still works, even though the underlying age field is restricted
  measure: avg_age {
    type: average
    sql: ${age} ;;
  }

  dimension: city {
    required_access_grants: [can_see_pii]
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    required_access_grants: [can_see_pii]
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
    required_access_grants: [can_see_pii]
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    required_access_grants: [can_see_pii]
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: last_name {
    required_access_grants: [can_see_pii]
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: latitude {
    required_access_grants: [can_see_pii]
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    required_access_grants: [can_see_pii]
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: state {
    required_access_grants: [can_see_pii]
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: zip {
    required_access_grants: [can_see_pii]
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }
}
