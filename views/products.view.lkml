view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  measure: json_list_test {
    type: list
    list_field: brand
    # sql: ${brand} ;;
  }

  dimension: brand_no_html {
    type: string
    sql: '{delivery_date: [2021-08-21], shipped_date: [2021-08-13], tracking_ids: [23432432, 34343424, 513513]}' ;;
  }

  dimension: brand {
    type: string
    sql:
    '{delivery_date: [2021-08-21], shipped_date: [2021-08-13], tracking_ids: [23432432, 34343424, 513513]}' ;;
    html:
    {% comment %} Gotta clean up the json string first {% endcomment %}
    {% assign json_level_1 = value | replace: '"', '' | replace: '], ', '|' | replace: ': [', '|' | replace: '{', '' | replace: ']}', '' | split: '|' %}

    {% comment %} Creating the table with a border, match width to the size of the screen {% endcomment %}
    <table border="5" style="width:100%">

      {% comment %} Create the headers for the table {% endcomment %}
      {% for json_item in json_level_1 %}
        {% comment %} I don't think we'll need the size, but if we need to create each row, this will be useful {% endcomment %}
        {% assign num_columns = json_level_1 | size | divided_by: 2 %}
        {% assign index_value_is_odd = forloop.index | modulo: 2 %}
        {% if index_value_is_odd == 1 %}
          <th style:"padding-top:2px, padding-bottom:2px"><center>{{json_item}}</center></th>
        {% endif %}
      {% endfor %}

      {% comment %} Create the data row for the table {% endcomment %}
      <tr>
      {% for json_item in json_level_1 %}
        {% assign index_value_is_even = forloop.index | modulo: 2 | plus: 1 %}
        {% if index_value_is_even == 1%}
          <td style:"padding-top:2px, padding-bottom:2px"><center>{{json_item}}</center></td>
        {% endif %}
      {% endfor %}
      </tr>

    </table>
    ;;
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
