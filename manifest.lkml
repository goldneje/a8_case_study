project_name: "case_studies"

constant: top_n_ranking_view_name {
  value: " TOTT | Top N Ranking"
}

constant: pop_support_view_name {
  value: " Period over Period Tools"
}

# _field._name = products.brand
# label: Brand Name
# _field._label = Products Brand Name

# To get rid of the multi-word view name error, just get the view name and remove it from the label.
constant: link_to_dashboard {
  value: "

      {%comment%} First, we need to get the see how long the view name is, because we don't want to include it in the filter {%endcomment%}

      {% assign view_name = _view._name %}

      {% if view_name contains '_' %}

        {% assign view_name = view_name | split: '_' %}

        {% assign view_name_word_count = view_name.size %}

      {% else %}

        {% assign view_name_word_count = 1 %}

      {% endif %}

      {%comment%} Let's create an array out of the field label, which will always be at least 2 words: [View_name] [Field_name] {%endcomment%}

      {% assign filterable_label = _field._label | split: ' ' %}

      {%comment%} Next, we'll create a variable that tells us the number of words in the array.
      Later, we'll use join, which throws errors if it is passed an array of length 1 {%endcomment%}

      {% assign filterable_label_size = filterable_label.size %}

      {%comment%} We're going to remove the view_name because we don't need it anymore, so the
      filterable_label_size needs to be at least 3 items long {%endcomment%}

      {% if filterable_label_size > 2 %}

      https://analytics8.looker.com/dashboards-next/54?{{filterable_label | slice: view_name_word_count, filterable_label_size | join: ' ' | url_encode }}={{ filterable_value | url_encode }}&Created%20Date=90%20day

      {%comment%} The filterable_label_size is 2, so we only need to return the string right after the view_name using an index. {%endcomment%}
      {% else %}

      https://analytics8.looker.com/dashboards-next/54?{{filterable_label[view_name_word_count] | url_encode }}={{ filterable_value | url_encode }}&Created%20Date=90%20day

      {% endif %}
      "
}
