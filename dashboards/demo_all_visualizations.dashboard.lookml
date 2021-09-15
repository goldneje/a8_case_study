- dashboard: dashboard_showing_all_visualizations
  title: Dashboard Showing All Visualizations
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Column
    name: Column
    model: e_commerce
    explore: order_items
    type: looker_column
    fields: [users.age_tier, order_items.created_month, order_items.count]
    pivots: [users.age_tier]
    fill_fields: [order_items.created_month]
    filters:
      users.age_tier: "-Below 0,-0 to 9,-Undefined"
      order_items.created_month: 36 months
    sorts: [users.age_tier 0, order_items.created_month]
    limit: 500
    column_limit: 50
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: []
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 25
    col: 0
    width: 16
    height: 7
  - title: Bar
    name: Bar
    model: e_commerce
    explore: order_items
    type: looker_bar
    fields: [order_items.created_date, order_items.count]
    fill_fields: [order_items.created_date]
    filters:
      order_items.created_date: 8 days ago for 7 days
    sorts: [order_items.created_date]
    limit: 500
    column_limit: 50
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: []
    series_types: {}
    series_colors:
      order_items.count: "#170658"
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 25
    col: 16
    width: 8
    height: 7
  - title: Scatter
    name: Scatter
    model: e_commerce
    explore: order_items
    type: looker_scatter
    fields: [order_items.created_date, users.gender, order_items.count]
    pivots: [users.gender]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date, users.gender]
    limit: 500
    column_limit: 50
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    show_null_points: true
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: []
    series_types: {}
    series_colors:
      users.gender___null - order_items.count: "#EA8A2F"
      Male - order_items.count: "#D978A1"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 68
    col: 0
    width: 11
    height: 8
  - title: Line
    name: Line
    model: e_commerce
    explore: order_items
    type: looker_line
    fields: [order_items.created_date, order_items.price_range, order_items.count]
    pivots: [order_items.price_range]
    fill_fields: [order_items.created_date, order_items.price_range]
    filters:
      order_items.created_date: 8 days ago for 7 days
    sorts: [order_items.created_date, order_items.price_range]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: [{label: Order Items Count, maxValue: !!null '', minValue: !!null '',
        orientation: left, showLabels: true, showValues: true, tickDensity: default,
        tickDensityCustom: 5, type: linear, unpinAxis: false, valueFormat: !!null '',
        series: [{id: Inexpensive, name: Inexpensive, axisId: order_items.count6},
          {id: Normal, name: Normal, axisId: order_items.count6}, {id: Expensive,
            name: Expensive, axisId: order_items.count6}]}]
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 54
    col: 15
    width: 9
    height: 5
  - title: Area
    name: Area
    model: e_commerce
    explore: order_items
    type: looker_area
    fields: [order_items.created_month, users.age_tier, order_items.count]
    pivots: [users.age_tier]
    fill_fields: [order_items.created_month, users.age_tier]
    filters:
      users.created_month: 4 months ago for 4 months
      order_items.created_month: 4 months ago for 4 months
    sorts: [order_items.created_month, users.age_tier]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: true
    show_silhouette: false
    totals_color: black
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: false, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: 2017-07,
            name: 2017-07, axisId: order_items.count6}, {id: 2017-08, name: 2017-08,
            axisId: order_items.count6}, {id: 2017-09, name: 2017-09, axisId: order_items.count6},
          {id: 2017-10, name: 2017-10, axisId: order_items.count6}]}]
    x_axis_label: Order Count by Age Tier
    hide_legend: true
    series_types: {}
    series_colors: {}
    ordering: none
    show_null_labels: false
    focus_on_hover: true
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 48
    col: 15
    width: 9
    height: 6
  - title: Pie
    name: Pie
    model: e_commerce
    explore: order_items
    type: looker_pie
    fields: [products.brand, order_items.count]
    filters:
      products.brand: "-Carhartt,-Dockers"
      order_items.created_date: 8 days ago for 7 days
    sorts: [products.brand]
    limit: 5
    column_limit: 50
    value_labels: labels
    label_type: labPer
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    series_colors: {}
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 11
    col: 16
    width: 8
    height: 7
  - title: Interactive Map
    name: Interactive Map
    model: e_commerce
    explore: order_items
    type: looker_map
    fields: [distribution_centers.location, users.gender, order_items.count]
    pivots: [users.gender]
    filters:
      users.gender: "-NULL"
    sorts: [users.gender, distribution_centers.location]
    limit: 500
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: traffic_day
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_marker_color: ["#8643b0", "#fdd8a0"]
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: circle
    interpolation: linear
    series_types: {}
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 32
    col: 8
    width: 16
    height: 8
  - title: Single Value with Comparison
    name: Single Value with Comparison
    model: e_commerce
    explore: order_items
    type: single_value
    fields: [distribution_centers.location]
    filters:
      order_items.created_date: 8 days ago for 7 days
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: weekly_goal, label: Weekly Goal, expression: '500',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: number}]
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    map_marker_radius_min:
    map_marker_color: [purple]
    single_value_title: Single Value
    hidden_fields: [distribution_centers.location]
    comparison_label: Comparison Feature
    y_axes: []
    row: 11
    col: 8
    width: 8
    height: 7
  - title: Funnel
    name: Funnel
    model: e_commerce
    explore: order_items
    type: looker_funnel
    fields: [distribution_centers.location, distribution_centers.name, order_items.count]
    filters:
      distribution_centers.name: "-Port Authority of New York/New Jersey NY/NJ"
      order_items.created_date: 8 days ago for 7 days
    sorts: [order_items.count desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: right
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    barColors: ["#64518A", "#EA8A2F"]
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: b20fe57d-cb13-420f-815b-60e907a43148
      options:
        steps: 5
        reverse: true
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    map_marker_radius_min:
    map_marker_color: [purple]
    single_value_title: Order Items
    hidden_fields: [distribution_centers.location]
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 32
    col: 0
    width: 8
    height: 8
  - title: Timeline
    name: Timeline
    model: e_commerce
    explore: order_items
    type: looker_timeline
    fields: [order_items.returned_date, order_items.created_date, order_items.delivered_date,
      products.count]
    filters:
      order_items.returned_date: NOT NULL
      order_items.created_date: 8 days ago for 7 days
    sorts: [order_items.created_date]
    limit: 500
    column_limit: 50
    groupBars: false
    labelSize: 9pt
    showLegend: true
    barColors: ["#EA8A2F", "#64518A"]
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: inline
    percentType: total
    percentPosition: right
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    map_marker_radius_min:
    map_marker_color: [purple]
    single_value_title: Order Items
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 40
    col: 0
    width: 14
    height: 8
  - title: Donut Multiples
    name: Donut Multiples
    model: e_commerce
    explore: order_items
    type: looker_donut_multiples
    fields: [users.state, order_items.status, order_items.count]
    pivots: [order_items.status]
    filters:
      users.state: Texas,California,New York
      order_items.created_date: 7 days
    sorts: [order_items.status, users.state]
    limit: 500
    column_limit: 50
    show_value_labels: false
    font_size: 12
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    map: san_francisco_peninsula_zips
    map_projection: albers
    show_view_names: true
    quantize_colors: false
    barColors: ['palette: Default']
    groupBars: false
    labelSize: 10pt
    showLegend: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: inline
    percentType: total
    percentPosition: right
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    map_marker_radius_min:
    map_marker_color: [purple]
    single_value_title: Order Items
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 59
    col: 0
    width: 12
    height: 9
  - title: Table with Conditional Formatting
    name: Table with Conditional Formatting
    model: e_commerce
    explore: order_items
    type: table
    fields: [order_items.created_date, distribution_centers.name, order_items.count]
    pivots: [order_items.created_date]
    fill_fields: [order_items.created_date]
    filters:
      users.state: Texas,California,Michigan,Nevada
      order_items.created_date: 6 days ago for 5 days
    sorts: [order_items.created_date, distribution_centers.name]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    series_labels:
      distribution_centers.name: Distribution Centers
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Custom, colors: ["#64518A", white,
            "#F2B431"]}, bold: false, italic: false, strikethrough: false, color_application: {
          collection_id: legacy, custom: {id: 372ac779-2a58-6a32-d30f-6b9c7489691b,
            label: Custom, type: continuous, stops: [{color: "#8643b0", offset: 0},
              {color: white, offset: 50}, {color: "#fdd8a0", offset: 100}]}, options: {
            steps: 11, stepped: true}}, fields: !!null ''}]
    conditional_formatting_ignored_fields: []
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_cell_visualizations:
      order_items.count:
        is_active: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    show_value_labels: false
    font_size: 12
    map: san_francisco_peninsula_zips
    map_projection: albers
    quantize_colors: false
    barColors: ['palette: Default']
    groupBars: false
    labelSize: 10pt
    showLegend: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: inline
    percentType: total
    percentPosition: right
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    map_marker_radius_min:
    map_marker_color: [purple]
    single_value_title: Order Items
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 3
    col: 12
    width: 12
    height: 8
  - title: Mixed Chart
    name: Mixed Chart
    model: e_commerce
    explore: order_items
    type: looker_column
    fields: [inventory_items.sold_date, products.count, users.count, orders.count,
      order_items.count]
    fill_fields: [inventory_items.sold_date]
    filters:
      inventory_items.sold_date: 8 days ago for 7 days
    sorts: [inventory_items.sold_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: false
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
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: []
    series_types:
      inventory_items.count: area
      orders.count: area
      products.count: scatter
      order_items.count: line
    series_colors:
      users.count: "#170658"
      order_items.count: "#FDA08A"
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 40
    col: 14
    width: 10
    height: 8
  - name: Text Tile
    type: text
    title_text: Text Tile
    subtitle_text: Sub-Header
    body_text: "Basic text with a [link](http://www.looker.com) \n\n**bold** _italics_\
      \  `code`\n\n> Short quote\n\n>This is a very long line that will still be quoted\
      \ properly when it wraps. I will keep writing to make sure this is long enough\
      \ to actually wrap for everyone.\n\n------\n\n- bulleted list\n\n1. numbered\
      \ list\n\n![image](https://looker.com/favicon.ico)\n\n| Tables        | Are\
      \           | Supported  |\n| ------------- | ------------- | ----- |\n| Using\
      \      | Markdown    | syntax |\n| **bold**        | _italics_  | `code`   |"
    row: 11
    col: 0
    width: 8
    height: 14
  - title: Box Plot
    name: Box Plot
    model: e_commerce
    explore: order_items
    type: looker_boxplot
    fields: [order_items.least_expensive_item, order_items.most_expensive_item, order_items.average_sale_price,
      products.category]
    filters:
      products.category: Shorts,Blazers & Jackets,Underwear,Clothing Sets,Outerwear
        & Coats,Pants & Capris,Jeans,Active
    sorts: [order_items.least_expensive_item desc]
    limit: 500
    dynamic_fields: [{table_calculation: min, label: Min, expression: "${order_items.least_expensive_item}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: 25th_percentile, label: 25th percentile,
        expression: "(${order_items.average_sale_price}- ${order_items.least_expensive_item})\
          \ /4", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: median, label: Median, expression: "${order_items.average_sale_price}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: 75th_percentile, label: 75th percentile,
        expression: "(${order_items.most_expensive_item} - ${order_items.average_sale_price})\
          \ /4", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: max, label: Max, expression: "${order_items.most_expensive_item}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
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
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: []
    series_types: {}
    hidden_fields: [order_items.average_sale_price, order_items.most_expensive_item,
      order_items.least_expensive_item]
    defaults_version: 1
    listen: {}
    row: 48
    col: 0
    width: 15
    height: 11
  - title: Trellis
    name: Trellis
    model: e_commerce
    explore: order_items
    type: looker_column
    fields: [order_items.average_sale_price, products.category, order_items.created_date]
    pivots: [products.category]
    fill_fields: [order_items.created_date]
    filters:
      products.category: Blazers & Jackets,Outerwear & Coats,Jeans,Active
      order_items.created_date: 14 days
    sorts: [order_items.average_sale_price desc 0, products.category]
    limit: 500
    query_timezone: America/Los_Angeles
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
    trellis: pivot
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
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
    y_axes: []
    series_types: {}
    series_colors: {}
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 3
    col: 0
    width: 12
    height: 8
  - title: Waterfall
    name: Waterfall
    model: e_commerce
    explore: order_items
    type: looker_waterfall
    fields: [order_items.status, order_items.total_sale_price]
    sorts: [order_items.total_sale_price desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: change_in_sales, label: Change in Sales,
        expression: 'if(${order_items.status} = "Cancelled" OR ${order_items.status}
          = "Returned",${order_items.total_sale_price}*-10, if(${order_items.status}
          = "Shipped" OR ${order_items.status} = "Processing",${order_items.total_sale_price}*100,
          ${order_items.total_sale_price}))', value_format: !!null '', value_format_name: usd,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    up_color: "#170658"
    down_color: "#C762AD"
    total_color: "#683AAE"
    show_value_labels: true
    show_x_axis_ticks: true
    show_x_axis_label: true
    x_axis_scale: auto
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: f582184b-9f56-4e5b-b1ab-e9777faa4df9
      options:
        steps: 5
        reverse: true
    label_color: [white]
    x_axis_gridlines: false
    show_view_names: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    label_density: 25
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [order_items.total_sale_price]
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 18
    col: 8
    width: 16
    height: 7
  - title: Word Cloud
    name: Word Cloud
    model: e_commerce
    explore: order_items
    type: looker_wordcloud
    fields: [products.category, order_items.total_sale_price]
    sorts: [order_items.total_sale_price desc]
    limit: 500
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    series_types: {}
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    listen: {}
    row: 59
    col: 12
    width: 12
    height: 9
  - name: Want to learn more about which visualization to use?
    type: text
    title_text: Want to learn more about which visualization to use?
    subtitle_text: ''
    body_text: Check out our course on [Designing Great Dashboards](https://training.looker.com/designing-great-dashboards).
      A complete list of visualization types can be found in our [Documentation](https://docs.looker.com/exploring-data/visualizing-query-results/visualization-types).
      Happy Lookering!
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Regions Map
    name: Regions Map
    model: e_commerce
    explore: order_items
    type: looker_geo_choropleth
    fields: [users.state, users.count]
    sorts: [users.count desc]
    limit: 500
    column_limit: 50
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: ["#fdd8a0", "#8643b0"]
    empty_color: ''
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    hidden_fields: []
    y_axes: []
    row: 68
    col: 11
    width: 13
    height: 8
  - title: Calendar Heatmap
    name: Calendar Heatmap
    model: e_commerce
    explore: order_items
    type: marketplace_viz_calendar_heatmap::calendar_heatmap-marketplace
    fields: [order_items.created_date, order_items.count]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date desc]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    series_types: {}
    defaults_version: 0
    y_axes: []
    listen: {}
    row: 76
    col: 0
    width: 8
    height: 6
  - title: Astor Diagram
    name: Astor Diagram
    model: e_commerce
    explore: order_items
    type: marketplace_viz_aster_plot::aster_plot-marketplace
    fields: [order_items.count, order_items.total_sale_price, distribution_centers.name]
    sorts: [order_items.count desc]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    legend: 'off'
    label_value: 'on'
    center_value: avg
    color_range: ["#9E0041", "#C32F4B", "#E1514B", "#F47245", "#FB9F59", "#FEC574",
      "#FAE38C", "#EAF195", "#C7E89E", "#9CD6A4", "#6CC4A4", "#4D9DB4", "#4776B4",
      "#5E4EA1"]
    inner_circle_color: "#ffffff"
    text_color: "#000000"
    font_size: 28
    threshold: 0.2
    label_size: 10
    chart_size: 100%
    series_types: {}
    defaults_version: 0
    y_axes: []
    row: 76
    col: 8
    width: 8
    height: 6
  - title: Table w/ Bars
    name: Table w/ Bars
    model: e_commerce
    explore: order_items
    type: looker_grid
    fields: [order_items.created_month, users.gender, order_items.count]
    pivots: [users.gender]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_month: 12 months
      users.gender: "-NULL"
    sorts: [order_items.created_month desc, users.gender]
    limit: 500
    column_limit: 50
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
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 76
    col: 16
    width: 8
    height: 6
