# frozen_string_literal: true

# Use this initializer to configure ActionSentinelGroup based on your models.
#
# It is very important that the configured models are the same as those used as
# User, Group and their relationship. Otherwise the gem may not work correctly.
ActionSentinelGroup.configure do |config|
  # Name of the model that is being used as User.
  # The default value is "User".
  config.user_model_name = "<%= user_model_name.camelize.singularize %>"

  # Name of the model that will be used as Group.
  # The default value is "Group".
  config.group_model_name = "<%= group_model_name.camelize.singularize %>"

  # Name of the model that forms the relationship between the User and Group model.
  # The default value is "UserGroup".
  config.user_group_model_name = "<%= user_group_model_name.camelize.singularize %>"
end
