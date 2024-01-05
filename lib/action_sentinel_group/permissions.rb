# frozen_string_literal: true

module ActionSentinelGroup
  module Permissions
    def has_permission_to?(action, controller_path)
      query = AccessPermission
              .joins(group_table_name.singularize.to_sym => user_groups_table_name.to_sym)
              .where(user_groups_table_name.to_sym => { "#{user_table_name.singularize}_id".to_sym => id })
              .where(controller_path: controller_path)

      query = if %w[sqlite sqlite3].include? self.class.connection.adapter_name.downcase
                query.where("actions LIKE ?", "%#{action}%")
              else
                query.where(':action = ANY("access_permissions"."actions")', action: action)
              end

      query.exists?
    end

    private

    def user_table_name
      ActionSentinelGroup.configuration.user_model_name.underscore.pluralize
    end

    def group_table_name
      ActionSentinelGroup.configuration.group_model_name.underscore.pluralize
    end

    def user_groups_table_name
      ActionSentinelGroup.configuration.user_group_model_name.underscore.pluralize
    end
  end
end
