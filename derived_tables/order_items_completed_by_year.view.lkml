  view: order_items_completed_by_year {
   derived_table: {
    #datagroup_trigger: case_studies_default_datagroup - cannot use bind all filters if persisting
        explore_source: order_items {
        bind_all_filters: yes
        column: id {}
        column: created_year {}
        column: count {}
        filters: {
          field: order_items.status
          value: "Complete"
          }
      }
    }

    dimension: id {
      type: number
      primary_key: yes
    }
    dimension: created_year {
      type: date_year
    }

    dimension: count {
      type: number
      hidden:  yes
    }
    measure: count_of_completed_orders {
      type: count
    }
  }
