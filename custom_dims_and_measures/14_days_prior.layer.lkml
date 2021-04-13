include: "/_layers/_base.layer"
include: "/custom_dims_and_measures/revenue.layer"

view: +order_items {

  measure: 14_day_rolling_avg {
    type: number
    sql: AVG(${total_gross_revenue}) OVER(ORDER BY ${created_date} ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) ;;
  }
}
