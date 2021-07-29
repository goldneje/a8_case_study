- dashboard: summary
  title: Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Total Revenue Yesterday
    name: Total Revenue Yesterday
    model: data_analyst_bootcamp
    explore: order_items
    type: single_value
    fields: [order_items.total_gross_revenue]
    filters:
      order_items.created_date: yesterday
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#4276BE"
    single_value_title: Total Revenue Yesterday
    conditional_formatting: [{type: greater than, value: !!null '', background_color: '',
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen:
      State: users.state
    row: 0
    col: 0
    width: 6
    height: 4
  - title: New Customers Yesterday
    name: New Customers Yesterday
    model: data_analyst_bootcamp
    explore: order_items
    type: single_value
    fields: [users.count]
    filters:
      users.created_date: yesterday
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#4276BE"
    defaults_version: 1
    listen:
      State: users.state
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Average Spend per Customer - Past 30 Days
    name: Average Spend per Customer - Past 30 Days
    model: data_analyst_bootcamp
    explore: order_items
    type: single_value
    fields: [order_items.average_spend_per_user]
    filters:
      order_items.created_date: 30 days
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#4276BE"
    defaults_version: 1
    listen:
      State: users.state
    row: 0
    col: 18
    width: 6
    height: 4
  - title: Gross Margin % - Past 30 Days
    name: Gross Margin % - Past 30 Days
    model: data_analyst_bootcamp
    explore: order_items
    type: single_value
    fields: [order_items.gross_margin_pct]
    filters:
      order_items.created_date: 30 days
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#4276BE"
    defaults_version: 1
    listen:
      State: users.state
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Gross Revenue per Year - Last 4 Years
    name: Gross Revenue per Year - Last 4 Years
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_area
    fields: [order_items.total_gross_revenue, order_items.created_year]
    fill_fields: [order_items.created_year]
    filters:
      order_items.created_date: 4 years
    sorts: [order_items.created_year desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}], showLabels: true,
        showValues: true, valueFormat: '$0,,"M"', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    hide_legend: true
    series_types: {}
    series_colors:
      order_items.total_gross_revenue: "#3EB0D5"
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
    custom_color: "#4276BE"
    defaults_version: 1
    ordering: none
    show_null_labels: false
    value_labels: legend
    label_type: labPer
    listen:
      State: users.state
    row: 8
    col: 0
    width: 6
    height: 5
  - title: New Customers | Month over Month
    name: New Customers | Month over Month
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_column
    fields: [users.created_month, users.count_CMTD]
    filters:
      users.created_month: 2 months
    sorts: [users.created_month desc]
    limit: 500
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
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    y_axes: [{label: Number of Customers, orientation: left, series: [{axisId: users.count_CMTD,
            id: users.count_CMTD, name: Number of Customers CMTD}], showLabels: true,
        showValues: true, valueFormat: '', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    hide_legend: false
    series_types: {}
    series_colors:
      order_items.total_gross_revenue: "#3EB0D5"
      order_items.total_gross_margin_amount: "#FFD95F"
    series_point_styles:
      order_items.total_gross_revenue: auto
      order_items.total_gross_margin_amount: auto
    reference_lines: []
    trend_lines: []
    show_dropoff: true
    custom_color_enabled: true
    custom_color: "#4276BE"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    swap_axes: false
    show_null_points: false
    interpolation: linear
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen:
      State: users.state
    row: 4
    col: 0
    width: 6
    height: 4
  - title: Revenue and Profit - Past 12 Months
    name: Revenue and Profit - Past 12 Months
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_line
    fields: [order_items.total_gross_revenue, order_items.total_gross_margin_amount,
      order_items.created_month]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 months
    sorts: [order_items.created_month desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}, {axisId: order_items.total_gross_margin_amount,
            id: order_items.total_gross_margin_amount, name: Total Gross Margin Amount}],
        showLabels: true, showValues: true, valueFormat: '', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    hide_legend: false
    series_types:
      order_items.total_gross_revenue: column
      order_items.total_gross_margin_amount: scatter
    series_colors:
      order_items.total_gross_revenue: "#3EB0D5"
      order_items.total_gross_margin_amount: "#FFD95F"
    series_point_styles:
      order_items.total_gross_revenue: auto
      order_items.total_gross_margin_amount: auto
    swap_axes: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4276BE"
    defaults_version: 1
    ordering: none
    show_null_labels: false
    value_labels: legend
    label_type: labPer
    listen:
      State: users.state
    row: 4
    col: 6
    width: 18
    height: 9
  - title: Revenue by Age Group and Gender | Last 12 Months
    name: Revenue by Age Group and Gender | Last 12 Months
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_column
    fields: [order_items.total_gross_revenue, users.age_tier, users.gender]
    pivots: [users.gender]
    fill_fields: [users.age_tier]
    filters:
      order_items.created_date: 12 months
    sorts: [users.age_tier, users.gender]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: Female - order_items.total_gross_revenue,
            id: Female - order_items.total_gross_revenue, name: Female}, {axisId: Male
              - order_items.total_gross_revenue, id: Male - order_items.total_gross_revenue,
            name: Male}], showLabels: true, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Age
    defaults_version: 1
    listen:
      State: users.state
    row: 24
    col: 0
    width: 8
    height: 6
  - title: Total Gross Revenue by New and Long-Term Customers | Past 90 Days
    name: Total Gross Revenue by New and Long-Term Customers | Past 90 Days
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_line
    fields: [order_items.created_date, users.new_customer_label, order_items.total_gross_revenue]
    pivots: [users.new_customer_label]
    fill_fields: [order_items.created_date, users.new_customer_label]
    filters:
      order_items.created_date: 90 days
    sorts: [order_items.created_date desc, users.new_customer_label]
    limit: 200
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
    show_null_points: true
    interpolation: linear
    x_axis_label: Order Date
    series_types: {}
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      State: users.state
    row: 24
    col: 8
    width: 16
    height: 6
  - title: Average Spend per Customer by Traffic Source | Past 12 Months
    name: Average Spend per Customer by Traffic Source | Past 12 Months
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_column
    fields: [order_items.average_spend_per_user, users.traffic_source, users.new_customer_label]
    pivots: [users.new_customer_label]
    fill_fields: [users.new_customer_label]
    filters:
      order_items.created_date: 12 months
    sorts: [order_items.average_spend_per_user desc 0, users.new_customer_label]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: asc
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: New Customer - 0 - order_items.average_spend_per_user,
            id: New Customer - 0 - order_items.average_spend_per_user, name: New Customer},
          {axisId: Long-term Customer - 1 - order_items.average_spend_per_user, id: Long-term
              Customer - 1 - order_items.average_spend_per_user, name: Long-term Customer}],
        showLabels: true, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    defaults_version: 1
    listen:
      State: users.state
    row: 15
    col: 16
    width: 8
    height: 9
  - title: Heatmap by Total Gross Margin Amount
    name: Heatmap by Total Gross Margin Amount
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_map
    fields: [order_items.total_gross_margin_amount, users.location]
    filters:
      users.location_bin_level: '7'
      users.location: inside box from 66.51326044311188, -225.00000000000003 to 0,
        45
    sorts: [order_items.total_gross_margin_amount desc]
    limit: 5000
    map_plot_mode: automagic_heatmap
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: true
    reverse_map_value_colors: false
    map_latitude: 45.1510532655634
    map_longitude: -70.75195312500001
    map_zoom: 3
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
    listen:
      State: users.state
    row: 15
    col: 0
    width: 16
    height: 9
  - title: Top 10 Brands by Gross Margin % with % of Total Gross Revenue
    name: Top 10 Brands by Gross Margin % with % of Total Gross Revenue
    model: data_analyst_bootcamp
    explore: order_items
    type: looker_column
    fields: [order_items.gross_margin_pct, products.brand, order_items.pct_of_total_gross_revenue]
    filters:
      order_items.gross_margin_pct: ">0"
    sorts: [order_items.gross_margin_pct desc]
    limit: 10
    total: true
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.gross_margin_pct,
            id: order_items.gross_margin_pct, name: Gross Margin %}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: "% of Total Gross Rev.", orientation: right, series: [
          {axisId: order_items.pct_of_total_gross_revenue, id: order_items.pct_of_total_gross_revenue,
            name: Percent of Total Gross Revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    series_types: {}
    show_dropoff: false
    defaults_version: 1
    listen:
      State: users.state
    row: 32
    col: 0
    width: 8
    height: 6
  - name: Customers
    type: text
    title_text: Customers
    subtitle_text: ''
    body_text: ''
    row: 13
    col: 0
    width: 24
    height: 2
  - name: Top Brands
    type: text
    title_text: Top Brands
    subtitle_text: ''
    body_text: ''
    row: 30
    col: 0
    width: 24
    height: 2
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: data_analyst_bootcamp
    explore: order_items
    listens_to_filters: []
    field: users.state
