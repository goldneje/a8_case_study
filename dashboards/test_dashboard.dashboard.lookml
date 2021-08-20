- dashboard: brand_drilldown
  title: Brand Drill-down
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Top Product Category by Revenue
    name: Top Product Category by Revenue
    model: case_studies
    explore: order_items
    type: single_value
    fields: [products.category, tgr_revenue_rank_by_category.total_gross_revenue,
      tgr_revenue_rank_by_category.total_gross_revenue_rank, tgr_revenue_rank_by_category.total_gross_revenue_tiebreaker]
    filters: {}
    sorts: [tgr_revenue_rank_by_category.total_gross_revenue desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Top Ranked Category (by Revenue)
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#62bad4",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_null_points: true
    interpolation: linear
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_fields: [tgr_revenue_rank_by_category.total_gross_revenue_tiebreaker, tgr_revenue_rank_by_category.total_gross_revenue]
    listen:
      Created Date: order_items.created_date
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 14
    col: 0
    width: 6
    height: 6
  - title: Number of Items Ordered | Weekly
    name: Number of Items Ordered | Weekly
    model: case_studies
    explore: order_items
    type: looker_line
    fields: [order_items.count, order_items.created_week]
    fill_fields: [order_items.created_week]
    filters: {}
    sorts: [order_items.created_week desc]
    limit: 500
    column_limit: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.count, id: order_items.count,
            name: Order Items}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    series_types:
      order_items.count: area
    series_point_styles: {}
    swap_axes: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 0
    col: 6
    width: 18
    height: 12
  - name: Total Profit
    title: Total Profit
    model: case_studies
    explore: order_items
    type: single_value
    fields: [order_items.profit_total]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 4
    col: 0
    width: 6
    height: 4
  - name: Profit Per Order
    title: Profit Per Order
    model: case_studies
    explore: order_items
    type: single_value
    fields: [profit_per_order.profit_per_order_average]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 8
    col: 0
    width: 6
    height: 4
  - name: Total Gross Revenue
    title: Total Gross Revenue
    model: case_studies
    explore: order_items
    type: single_value
    fields: [order_items.total_gross_revenue]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Total Gross Revenue Ranking | Per Category
    name: Total Gross Revenue Ranking | Per Category
    model: case_studies
    explore: order_items
    type: looker_grid
    fields: [products.category, tgr_revenue_rank_by_category.total_gross_revenue_rank,
      tgr_revenue_rank_by_category.total_gross_revenue, tgr_revenue_rank_by_category.total_gross_revenue_tiebreaker]
    filters: {}
    sorts: [tgr_revenue_rank_by_category.total_gross_revenue_rank]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [tgr_revenue_rank_by_category.total_gross_revenue_tiebreaker]
    column_order: ["$$$_row_numbers_$$$", tgr_revenue_rank_by_category.total_gross_revenue_rank,
      products.category, tgr_revenue_rank_by_category.total_gross_revenue]
    series_column_widths:
      tgr_revenue_rank_by_category.total_gross_revenue_rank: 219
      products.category: 137
      tgr_revenue_rank_by_category.total_gross_revenue: 165
    listen:
      Brand: products.brand
      Category: products.category
      Status: order_items.status
    row: 14
    col: 6
    width: 8
    height: 6
  - name: Top Categories Analysis
    type: text
    title_text: Top Categories Analysis
    subtitle_text: ''
    body_text: ''
    row: 12
    col: 0
    width: 24
    height: 2
  filters:
  - name: Brand
    title: Brand
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: case_studies
    explore: order_items
    listens_to_filters: []
    field: products.brand
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 90 day
    allow_multiple_values: true
    required: true
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: case_studies
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
  - name: Category
    title: Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: popover
      options: []
    model: case_studies
    explore: order_items
    listens_to_filters: []
    field: products.category
  - name: Status
    title: Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    model: case_studies
    explore: order_items
    listens_to_filters: []
    field: order_items.status
