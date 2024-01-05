class <%= group_model_name %> < ApplicationRecord
  has_many :<%= user_group_model_name.underscore.pluralize %>
  has_many :<%= user_model_name.underscore.pluralize %>, through: :<%= user_group_model_name.underscore.pluralize %>
end
