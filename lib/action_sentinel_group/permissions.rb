# frozen_string_literal: true

module ActionSentinelGroup
  # Provides methods for check access permissions of a user model related to groups.
  #
  # This module is designed to be included in user models that need to check access permissions.
  # It introduces methods for checking permissions associated with a specific controller and actions.
  #
  # @example Including Permissions in a Model
  #   class User < ApplicationRecord
  #     include ActionSentinelGroup::Permissions
  #   end
  #
  #   user = User.new
  #   user.has_permission_to?('create', 'users')
  #
  module Permissions
    # rubocop:disable Metrics/AbcSize, Naming/PredicateName

    # Checks if the user has permission to perform a specific action on a controller.
    #
    # @param action [String] The action to check permission for.
    # @param controller_path [String] The path of the controller to check permission for.
    # @return [Boolean] Returns true if the user has permission, otherwise false.
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
    # rubocop:enable Metrics/AbcSize, Naming/PredicateName

    private

    # Returns the name of the user table.
    #
    # @return [String] The user table name.
    def user_table_name
      ActionSentinelGroup.configuration.user_model_name.underscore.pluralize
    end

    # Returns the name of the group table.
    #
    # @return [String] The group table name.
    def group_table_name
      ActionSentinelGroup.configuration.group_model_name.underscore.pluralize
    end

    # Returns the name of the user groups table.
    #
    # @return [String] The user groups table name.
    def user_groups_table_name
      ActionSentinelGroup.configuration.user_group_model_name.underscore.pluralize
    end
  end
end
