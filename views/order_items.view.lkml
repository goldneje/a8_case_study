view: order_items {
  sql_table_name: `looker-partners.thelook.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  filter: date_filter {
    type: date
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      time,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

# Note that using a value in a link like we see below will make this measure aggregate at the grain of the value in our link.
# In this case, the count will now fan out to the products.brand level. This is generally not what we want, so links that leverage a value should
# be used in dimensions.
  measure: count {
    type: count
    drill_fields: [detail*]
    link: {
      label: "This will go to a new page"
      url: "https://analytics8.looker.com/explore/case_studies/order_items?fields=order_items.count,products.brand&limit=10&query_timezone=America%2FLos_Angeles&vis=%7B%7D&filter_config=%7B%7D&origin=drill-menu"
    }
    link: {
      label: "This will open up the drill modal"
      # Replaced everything from the beginning to the `?` with {{ link }}
      url: "{{ link }}&fields=order_items.count,products.brand&limit=10&query_timezone=America%2FLos_Angeles&vis=%7B%7D&filter_config=%7B%7D&origin=share-expanded"
    }
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
