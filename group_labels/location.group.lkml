include: "/_layers/_base.layer"

view: +events {
  dimension: city {
    group_label: " Location"
  }

  dimension: country {
    group_label: " Location"
  }

  dimension: latitude {
    group_label: " Location"
  }

  dimension: longitude {
    group_label: " Location"
  }

  dimension: state {
    group_label: " Location"
  }

  dimension: zip {
    group_label: " Location"
  }
}
view: +users {
  dimension: state {
    group_label: " Location"
  }

  dimension: latitude {
    group_label: " Location"
  }

  dimension: longitude {
    group_label: " Location"
  }

  dimension: country {
    group_label: " Location"
  }

  dimension: city {
    group_label: " Location"
  }

  dimension: zip {
    group_label: " Location"
  }
}
