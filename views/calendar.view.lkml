view: calendar {
  derived_table: {
    sql: WITH CTE_MY_DATE AS (
    SELECT DATEADD(DAY, SEQ4(), '2000-01-01') AS MY_DATE
      FROM TABLE(GENERATOR(ROWCOUNT=>10000))  -- Number of days after reference date in previous line
  )
  SELECT MY_DATE as cal_date
        ,YEAR(MY_DATE) as year
        ,MONTH(MY_DATE) as month
        ,DAY(MY_DATE) as day
    FROM CTE_MY_DATE ;;
  }

  dimension_group: cal {
    type: time
    timeframes: [
      raw,
      date,
      month,
      year,
      quarter
    ]
    sql: ${TABLE}.cal_date ;;
  }

}

explore: calendar {}
