include: "../../../views/users.view"

view: users_refined {
  extends: [users]
}

view: +users_refined {

  # override original dimension definitions
  dimension: first_name {
    sql: INITCAP(${TABLE}."FIRST_NAME") ;;
  }

  dimension: last_name {
    sql: INITCAP(${TABLE}."LAST_NAME") ;;
  }

}
