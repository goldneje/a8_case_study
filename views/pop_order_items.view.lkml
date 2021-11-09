
## EDIT ME, CHANGE THE INCLUDE STATEMENT TO POINT AT THE VIEW FILE YOU WANT TO PERFORM PoP ON
include: "/views/order_items.view"

## EDIT ME, CHANGE 'order_items' TO THE VIEW YOU WANT TO PERFORM PoP ON
view: +order_items {

  filter: current_date_range {
    type: date
    view_label: " PoP"
    label: "1. Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
  }

  parameter: compare_to {
    view_label: " PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "2. Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }


## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##

  dimension: days_in_period {
    hidden:  yes
    view_label: " PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: DATEDIFF(DAY, {% date_start current_date_range %}, {% date_end current_date_range %}) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: " PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
        {% if compare_to._parameter_value == "Period" %}
        DATEADD(DAY, -${days_in_period}, {% date_start current_date_range %})
        {% else %}
        DATEADD({% parameter compare_to %}, -1, {% date_start current_date_range %})
        {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: " PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
        {% if compare_to._parameter_value == "Period" %}
        DATEADD(DAY, -1, {% date_start current_date_range %})
        {% else %}
        DATEADD({% parameter compare_to %}, -1, DATEADD(DAY, -1, {% date_end current_date_range %}))
        {% endif %};;
  }


## EDIT ME, UPDATE ${created_date} TO YOUR DATE FIELD
  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
    {% if current_date_range._is_filtered %}
        CASE
        WHEN {% condition current_date_range %} ${created_date} {% endcondition %}
        THEN DATEDIFF(DAY, {% date_start current_date_range %}, ${created_date}) + 1
        WHEN ${created_date} between ${period_2_start} and ${period_2_end}
        THEN DATEDIFF(DAY, ${period_2_start}, ${created_date}) + 1
        END
    {% else %} NULL
    {% endif %}
    ;;
  }

## EDIT ME, UPDATE ${created_date} TO YOUR DATE FIELD
  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${created_date} {% endcondition %}
            THEN 1
            WHEN ${created_date} between ${period_2_start} and ${period_2_end}
            THEN 2
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }

  filter: is_current_period_to_date {
    type: yesno
    view_label: " PoP"
    label: "3. Is Current Period To Date (Yes/No)"
    description: "Use this to filter only up to the max day of the date range filter (excludes last day in filter). Must be used with the compare_to parameter."
    sql:
    {% if compare_to._parameter_value == 'Week' %}
      ${date_in_period_day_of_week_index} < EXTRACT(dow FROM CURRENT_DATE)
    {% elsif compare_to._parameter_value == 'Month' %}
      ${date_in_period_day_of_month} < EXTRACT(day FROM CURRENT_DATE)
    {% elsif compare_to._parameter_value == 'Quarter' %}
      ${date_in_period_month_of_quarter} < ${current_month_of_quarter}
    {% elsif compare_to._parameter_value == 'Year' %}
      ${date_in_period_day_of_year} < EXTRACT(year FROM CURRENT_DATE)
    {% else %}
      1=1
    {% endif %}
    ;;
  }

  dimension: current_month_of_quarter {
    hidden: yes
    type: number
    sql:
      case
        when EXTRACT(MONTH FROM CURRENT_DATE) IN (1,4,7,10) THEN 1
        when EXTRACT(MONTH FROM CURRENT_DATE) IN (2,5,8,11) THEN 2
        else 3
      end ;;
  }

## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: DATEADD(DAY, ${day_in_period} - 1, {% date_start current_date_range %}) ;;
    view_label: " PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      month_name,
      month_num,
      year]
  }

  dimension: date_in_period_month_of_quarter {
    view_label: " PoP"
    group_label: "Current Period Date"
    type: number
    group_item_label: "Month of Quarter"

    sql:
      case
        when ${date_in_period_month_num} IN (1,4,7,10) THEN 1
        when ${date_in_period_month_num} IN (2,5,8,11) THEN 2
        else 3
      end
    ;;
  }

## EDIT ME, UPDATE ${created_date} TO YOUR DATE FIELD
  dimension: period {
    view_label: " PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    order_by_field: order_for_period
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${created_date} {% endcondition %}
            THEN 'This {% parameter compare_to %}'
            WHEN ${created_date} between ${period_2_start} and ${period_2_end}
            THEN 'Last {% parameter compare_to %}'
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }


## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

## EDIT ME, UPDATE ${created_date} TO YOUR DATE FIELD
  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${created_date} {% endcondition %} THEN 'this'
            WHEN ${created_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
        {% else %} NULL {% endif %} ;;
  }

## EDIT ME, UPDATE ${sale_price} TO A NUMBER YOU WANT TO SUM
  measure: example_filtered_measure_last_period {
    label: "Last {% parameter compare_to %} Total Sales"
    description: "Using the PoP above to create a filtered measure"
    type: sum
    sql: ${sale_price} ;;
    filters: [period_filtered_measures: "last"]
  }

## EDIT ME, UPDATE ${sale_price} TO A NUMBER YOU WANT TO SUM
  measure: example_filtered_measure_this_period {
    label: "This {% parameter compare_to %} Total Sales"
    description: "Using the PoP above to create a filtered measure"
    type: sum
    sql: ${sale_price} ;;
    filters: [period_filtered_measures: "this"]
  }
}