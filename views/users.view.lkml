view: users {
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    #hidden:  yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    description: "Users Age"
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension: age_tier {
    description: "Users Age Tier"
    type: tier
    style: integer
    tiers: [15,26,37,52,66]
    sql: ${TABLE}."AGE" ;;
  }

  dimension: city {
    group_label: "Location Information"
    description: "City"
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    group_label: "Location Information"
    description: "Country"
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
      year,
      day_of_month,
      month_num
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

## Flags

  dimension: is_yesterday  {
    group_label: "Calendar Flags"
    description: "Is Yesterday?"
    type:  yesno
   sql: dateadd(day,-1,current_date)=${created_date} ;;
      }

  dimension: is_in_the_last_30_days  {
    group_label: "Calendar Flags"
    description: "Is in the past 30 days"
    type:  yesno
    sql: dateadd(day,-30,current_date)<=${created_date} ;;
  }

  dimension: month_to_date  {
    group_label: "Calendar Flags"
    description: "User Date MTD and Prior MTD's"
    type:  yesno
    sql: ${created_day_of_month}<=date_part(day,current_date()) ;;
  }

  dimension: is_ytd {
    group_label: "Calendar Flags"
    label: "Is YTD"
    description: "YTD in all years Flag"
    type: yesno
    sql: ${created_month_num} < MONTH(current_date())

    OR

    (${created_month_num}  = MONTH(current_date())

    AND

     ${created_day_of_month} <= DAY(current_date()))

    ;;
  }
  dimension: email {
    description: "Email"
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    description: "First Name"
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: gender {
    description: "Gender"
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: last_name {
    description: "First Name"
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

#Concat first and last name

  dimension: latitude {
    group_label: "Location Information"
    description: "Latitude"
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
   group_label: "Location Information"
    description: "Longitude"
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: state {
   group_label: "Location Information"
    description: "State"
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: traffic_source {
    group_label: "Location Information"
    description: "Traffic Source"
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: zip {
    group_label: "Location Information"
    description: "Zip Code"
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    view_label: "Users"
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }
}
