include: "/views/users.view"

# In this first example, we're creating a can_see_pii access grant.
# This would typically live in a model file so all views have access to it, but we're putting it here for demo purposes.
access_grant: can_see_pii {
  user_attribute: email
  # Yes, actually do what this variable tells you to do! Example: eheidbreder@analytics8.com
  allowed_values: ["REPLACE_ME_WITH_YOUR_ANALYTICS8_EMAIL"]
}

# This is a refinement, long story short, we can use a refinement to edit views
view: users_with_access_grants {
  extends: [users]
  dimension: first_name {
    required_access_grants: [can_see_pii]
  }
  dimension: last_name {
    required_access_grants: [can_see_pii]
  }
  dimension: full_name {
    sql: ${first_name} || ' ' || ${last_name} ;;
    required_access_grants: [can_see_pii]
  }
}

# Go to this explore by copying and pasting the link: https://analytics8.looker.com/explore/case_studies/users?qid=E8sPcDCRzJQpZf7hmI4C7J
  # Can you see all the columns? You should be able to! If not, your email in the 'allowed_values' parameter might be spelled wrong (check capitalization)

# Go back to line 8 and change the 'allowed_values' parameter to an email other than your own

# Refresh the explore from above
  # Can you see all the columns now? You shouldn't see any fields, because your email doesn't match the allowed_values.

########################## THE DANGEROUS THING ABOUT USING ACCESS GRANTS ##########################
# Keep the 'allowed_values' parameter as is, so it doesn't match your email.
# DO THIS -> Comment out line 22: the required_access_grants: [can_see_pii] line within the `full_name` dimension
  # What do you expect to happen here? Will you be able to see full_name even though first_name and last_name have a required access grant?
  # Refresh the explore and see what happens. Don't scroll down until you do it :), but then scroll down to line 80









































# SPOILER ALERT #
# Although first_name and last_name have `required_access_grants` assigned, you can still see the values inside of `full_name`.
# This is expected behavior. So the key takeaway here is: a required_access_grant only applies to the specific field it is attached to.

# The way to hide sensitive information across multiple fields is to use some liquid in the SQL of a field.
# Uncomment this code block and refresh the explore to see it in action.
# You should see that `full_name` now has replaced every First Name value with 'REDACTED', unless your first name is Dr. Worm.
# view: +users_with_access_grants {
#   dimension: first_name {
#     # The first 3 lines assign values to variables to make more complicated liquid easier to read.
#     # Note that _user_attributes["a_user_attribute_label"] (in line 93) will return the current user's value for that user_attribute
#     sql:
#     {% assign user_attribute_to_check = "first_name" %}
#     {% assign user_value = _user_attributes[user_attribute_to_check] %}
#     {% assign allowed_user_value = "Dr. Worm" %}
#     {% if user_value == allowed_user_value %}
#       ${TABLE}.first_name
#     {% else %}
#       'REDACTED'
#     {% endif %} ;;
#   }
# }
