include: "/views/order_items.view.lkml"
include: "/views/pop_parameters.view.lkml"
include: "/models/case_studies.model.lkml"

view: +order_items {

### replace any reference to order_items by the view of your choosing
### We're assuming here that the date dimension we want to leverage in the PoP is order_items.created_date labeled as "Orders Date"
  dimension_group: created {
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      month_name,
      month_num,
      year,
      hour_of_day,
      quarter,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year
    ]
  }

  dimension: created_month_of_quarter_advanced {
    label: "Orders Month of Quarter"
    group_label: "Orders Dates"
    group_item_label: "Month of Quarter"
    type: number
    sql:
      case
        when ${order_items.created_month_num} IN (1,4,7,10) THEN 1
        when ${order_items.created_month_num} IN (2,5,8,11) THEN 2
        else 3
      end
    ;;
  }

  dimension: is_to_date_advanced {
    hidden: yes
    type: yesno
    sql:
      {% if parameters.select_timeframe_advanced._parameter_value == 'ytd' %}true
      {% else %}
        {% if parameters.apply_to_date_filter_advanced._parameter_value == 'true' %}
          {% if parameters.select_timeframe_advanced._parameter_value == 'week' %}
            ${order_items.created_day_of_week_index} <= ${parameters.current_timestamp_advanced_day_of_week_index}
          {% elsif parameters.select_timeframe_advanced._parameter_value == 'day' %}
            ${order_items.created_hour_of_day} <= ${parameters.current_timestamp_advanced_hour_of_day}
          {% elsif parameters.select_dynamic_timeframe_advanced._parameter_value == 'quarter' %}
            ${order_items.created_month_of_quarter_advanced} <= ${parameters.current_timestamp_month_of_quarter_advanced}
          {% elsif parameters.select_timeframe_advanced._parameter_value == 'year' %}
            ${order_items.created_day_of_year} <= ${parameters.current_timestamp_advanced_day_of_year}
          {% else %}
            ${order_items.created_day_of_month} <= ${parameters.current_timestamp_advanced_day_of_month}
          {% endif %}
        {% else %} true
        {% endif %}
      {% endif %}
    ;;
  }

  dimension: selected_dynamic_timeframe_advanced  {
    label_from_parameter: parameters.select_timeframe_advanced
    type: string
    hidden: yes
    sql:
      {% if parameters.select_timeframe_advanced._parameter_value == 'day' %}
        ${order_items.created_date}
      {% elsif parameters.select_timeframe_advanced._parameter_value == 'week' %}
        ${order_items.created_week}
      {% elsif parameters.select_timeframe_advanced._parameter_value == 'year' %}
        ${order_items.created_year}
      {% elsif parameters.select_timeframe_advanced._parameter_value == 'quarter' %}
        ${order_items.created_quarter}
      {% elsif parameters.select_timeframe_advanced._parameter_value == 'ytd' %}
        CONCAT('YTD (',${order_items.created_year},'-',${parameters.selected_reference_date_default_today_advanced_month_num},'-',${parameters.selected_reference_date_default_today_advanced_day_of_month},')')
      {% else %}
        ${order_items.created_month}
      {% endif %}
    ;;
  }

  dimension: selected_dynamic_day_of_advanced  {
    label: "{%
    if parameters.select_timeframe_advanced._is_filtered and parameters.select_timeframe_advanced._parameter_value == 'month' %}Day of Month{%
    elsif parameters.select_timeframe_advanced._is_filtered and parameters.select_timeframe_advanced._parameter_value == 'week' %}Day of Week{%
    elsif parameters.select_timeframe_advanced._is_filtered and parameters.select_timeframe_advanced._parameter_value == 'day' %}Hour of Day{%
    elsif parameters.select_timeframe_advanced._is_filtered and parameters.select_timeframe_advanced._parameter_value == 'year' %}Months{%
    elsif parameters.select_timeframe_advanced._is_filtered and parameters.select_timeframe_advanced._parameter_value == 'ytd' %}Day of Year{%
    else %}Selected Dynamic Timeframe Granularity{%
    endif %}"
    order_by_field: order_items.selected_dynamic_day_of_sort_advanced
    type: string
    sql:
    {% if parameters.select_timeframe_advanced._parameter_value == 'day' %}
      ${order_items.created_hour_of_day}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'week' %}
      ${order_items.created_day_of_week}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'year' %}
      ${order_items.created_month_name}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'quarter' %}
      ${order_items.created_month_of_quarter_advanced}
      {% elsif parameters.select_timeframe_advanced._parameter_value == 'ytd' %}
      ${order_items.created_day_of_year}
    {% else %}
      ${order_items.created_day_of_month}
    {% endif %}
    ;;
  }

  dimension: selected_dynamic_day_of_sort_advanced  {
    hidden: yes
    label_from_parameter: parameters.select_timeframe_advanced
    type: number
    sql:
    {% if parameters.select_timeframe_advanced._parameter_value == 'day' %}
      ${order_items.created_hour_of_day}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'week' %}
      ${order_items.created_day_of_week_index}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'year' %}
      ${order_items.created_month_num}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'quarter' %}
      ${order_items.created_month_of_quarter_advanced}
    {% elsif parameters.select_timeframe_advanced._parameter_value == 'ytd' %}
      ${order_items.created_day_of_year}
    {% else %}
      ${order_items.created_day_of_month}
    {% endif %}
    ;;
  }
}

############################################################################################################
################################################# SNOWFLAKE ################################################
############################################################################################################

### replace any reference to order_items.created_[...] by the view/dimensions of your choosing
### We're assuming here that the date dimension we want to leverage in the PoP is order_items.created_date labeled as "Orders Date"

view: +order_items {

  #####  CURRENT/REFERENCE [Timeframe] VS PREVIOUS [Timeframe]

  dimension: current_vs_previous_period_snowflake_advanced {
    label: "Current vs Previous Period"
    description: "Use this dimension along with \"Select Timeframe\", \"Select Reference Date\", \"To Date\" and \"Select Comparison\" filters"
    type: string
    sql:
      {% if parameters.select_timeframe_advanced._parameter_value == "ytd" %}
        case
          when ${order_items.created_date} BETWEEN date_trunc(year, ${parameters.selected_reference_date_default_today_advanced_raw}) and ${parameters.selected_reference_date_default_today_advanced_date}
            then ${selected_dynamic_timeframe_advanced}
          when ${order_items.created_date} BETWEEN date_trunc(year, dateadd(year, -1,${parameters.selected_reference_date_default_today_advanced_raw})) and dateadd(year, -1, ${parameters.selected_reference_date_default_today_advanced_date})
            then ${selected_dynamic_timeframe_advanced}
          else null
        end
      {% else %}
        {% if parameters.select_comparison._parameter_value == "year" %}
          case
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, ${parameters.selected_reference_date_default_today_advanced_raw})
              then ${selected_dynamic_timeframe_advanced}
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, dateadd(year, -1, ${parameters.selected_reference_date_default_today_advanced_raw}))
              then ${selected_dynamic_timeframe_advanced}
          end
        {% elsif parameters.select_comparison._parameter_value == "period" %}
          case
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, ${parameters.selected_reference_date_default_today_advanced_raw})
              then ${selected_dynamic_timeframe_advanced}
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, dateadd({% parameter parameters.select_timeframe_advanced %}, -1, ${parameters.selected_reference_date_default_today_advanced_raw}))
              then ${selected_dynamic_timeframe_advanced}
          end
        {% endif %}
      {% endif %}
      ;;
  }


  dimension: current_vs_previous_period_hidden_snowflake_advanced {
    label: "Current vs Previous Period (Hidden - for measure only)"
    hidden: yes
    description: "Hide this measure so that it doesn't appear in the field picket and use it to filter measures (since the values are static)"
    type: string
    sql:
      {% if parameters.select_timeframe_advanced._parameter_value == "ytd" %}
        case
          when ${order_items.created_raw} BETWEEN date_trunc(year, ${parameters.selected_reference_date_default_today_advanced_raw}) and ${parameters.selected_reference_date_default_today_advanced_raw}
            then 'reference'
          when ${order_items.created_raw} BETWEEN date_trunc(year, dateadd(year, -1, ${parameters.selected_reference_date_default_today_advanced_raw})) and dateadd(year, -1, ${parameters.selected_reference_date_default_today_advanced_date})
            then 'comparison'
          else null
        end
      {% else %}
        {% if parameters.select_comparison._parameter_value == "year" %}
          case
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, ${parameters.selected_reference_date_default_today_advanced_raw})
              then 'reference'
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, dateadd(year, -1, ${parameters.selected_reference_date_default_today_advanced_raw}))
              then 'comparison'
          end
        {% elsif parameters.select_comparison._parameter_value == "period" %}
          case
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, ${parameters.selected_reference_date_default_today_advanced_raw})
              then 'reference'
            when date_trunc({% parameter parameters.select_timeframe_advanced %}, ${order_items.created_raw}) = date_trunc({% parameter parameters.select_timeframe_advanced %}, dateadd({% parameter parameters.select_timeframe_advanced %}, -1, ${parameters.selected_reference_date_default_today_advanced_raw}))
              then 'comparison'
          end
        {% endif %}
      {% endif %}
    ;;
  }
}

############################################################################################################
################################################# BIGQUERY #################################################
############################################################################################################

### replace any reference to order_items.created_[...] by the view/dimensions of your choosing
### We're assuming here that the date dimension we want to leverage in the PoP is order_items.created_date labeled as "Orders Date"

# view: +order_items {

# #####  CURRENT/REFERENCE [Timeframe] VS PREVIOUS [Timeframe] with dynamic labels and default to today

#   dimension: current_vs_previous_period_bigquery_advanced {
#     label: "Current vs Previous Period"
#     hidden: yes
#     description: "Use this dimension alongside \"Select Timeframe\" and \"Select Comparison Type\" Filters to compare a specific timeframe (month, quarter, year) and the corresponding one of the previous year"
#     type: string
#     sql:
#       {% if parameters.select_timeframe_advanced._parameter_value == "ytd" %}
#         CASE
#           WHEN ${order_items.created_date} BETWEEN DATE_TRUNC(DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, YEAR), MONTH) AND DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, DAY)
#             THEN ${selected_dynamic_timeframe_advanced}
#           WHEN ${order_items.created_date} BETWEEN DATE_TRUNC(DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), YEAR), MONTH) AND DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), MONTH)
#             THEN ${selected_dynamic_timeframe_advanced}
#           ELSE NULL
#         END
#       {% else %}
#         {% if parameters.select_comparison._parameter_value == "year" %}
#           CASE
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, {% parameter parameters.select_timeframe_advanced %})
#               THEN ${selected_dynamic_timeframe_advanced}
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), {% parameter parameters.select_timeframe_advanced %})
#               THEN ${selected_dynamic_timeframe_advanced}
#             ELSE NULL
#           END
#         {% elsif parameters.select_comparison._parameter_value == "period" %}
#           CASE
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, {% parameter parameters.select_timeframe_advanced %})
#               THEN ${selected_dynamic_timeframe_advanced}
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 {% parameter parameters.select_timeframe_advanced %}), {% parameter parameters.select_timeframe_advanced %})
#               THEN ${selected_dynamic_timeframe_advanced}
#             ELSE NULL
#           END
#         {% endif %}
#       {% endif %}
#     ;;
#   }

#   dimension: current_vs_previous_period_hidden_bigquery_advanced {
#     label: "Current vs Previous Period (Hidden - for measure only)"
#     hidden: yes
#     description: "Hide this measure so that it doesn't appear in the field picket and use it to filter measures (since the values are static)"
#     type: string
#     sql:
#       {% if parameters.select_timeframe_advanced._parameter_value == "ytd" %}
#         CASE
#           WHEN ${order_items.created_date} BETWEEN DATE_TRUNC(DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, YEAR), MONTH) AND DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, DAY)
#             THEN 'reference'
#           WHEN ${order_items.created_date} BETWEEN DATE_TRUNC(DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), YEAR), MONTH) AND DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), MONTH)
#             THEN 'comparison'
#           ELSE NULL
#         END
#       {% else %}
#         {% if parameters.select_comparison._parameter_value == "year" %}
#           CASE
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, {% parameter parameters.select_timeframe_advanced %})
#               THEN 'reference'
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 YEAR), {% parameter parameters.select_timeframe_advanced %})
#               THEN 'comparison'
#             ELSE NULL
#           END
#         {% elsif parameters.select_comparison._parameter_value == "period" %}
#           CASE
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, {% parameter parameters.select_timeframe_advanced %})
#               THEN 'reference'
#             WHEN DATE_TRUNC(${order_items.created_raw},  {% parameter parameters.select_timeframe_advanced %}) = DATE_TRUNC(DATE_SUB(${parameters.selected_reference_date_default_today_advanced_bigquery_raw}, INTERVAL 1 {% parameter parameters.select_timeframe_advanced %}), {% parameter parameters.select_timeframe_advanced %})
#               THEN 'comparison'
#             ELSE NULL
#           END
#         {% endif %}
#       {% endif %}
#     ;;
#   }
# }

############################################################################################################
################################################# SNOWFLAKE ################################################
############################################################################################################

### replace any reference to order_items by the explore of your choosing
### We're assuming here that the explore we we want to leverage in the PoP is order_items.

explore: +order_items {
  sql_always_where:
    1=1
    {% if order_items.current_vs_previous_period_snowflake_advanced._in_query %}and ${order_items.current_vs_previous_period_snowflake_advanced} is not null{% endif %}
    {% if parameters.apply_to_date_filter_advanced._is_filtered %}and ${order_items.is_to_date_advanced}{% endif %} ;;
}

############################################################################################################
################################################# BIGQUERY #################################################
############################################################################################################

### replace any reference to order_items by the explore of your choosing
### We're assuming here that the explore we we want to leverage in the PoP is order_items.

# explore: +order_items {
#   sql_always_where:
#     1=1
#     {% if order_items.current_vs_previous_period_bigquery_advanced._in_query %}AND ${order_items.current_vs_previous_period_bigquery_advanced} IS NOT NULL{% endif %}
#     {% if parameters.apply_to_date_filter_advanced._is_filtered %}AND ${order_items.is_to_date_advanced}{% endif %} ;;
# }
