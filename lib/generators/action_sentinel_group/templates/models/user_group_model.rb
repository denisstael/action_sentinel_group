class <%= user_group_model_name %> < ApplicationRecord
  belongs_to :<%= user_model_name.underscore %>
  belongs_to :<%= group_model_name.underscore %>
end
