# frozen_string_literal: true

require "action_sentinel_group/permissions"

module ActionSentinelGroup
  #
  # Module to be included in ActionSentinel
  module Model
    # rubocop:disable Naming/PredicateName

    # Includes the ActionSentinelGroup::Permissions module in the calling model class
    # to allow checking permissions for controller actions.
    #
    # @example:
    #
    #   class User < ApplicationRecord
    #     has_group_permissions
    #   end
    #
    # @see ActionSentinelGroup::Permissions
    def has_group_permissions
      include ActionSentinelGroup::Permissions
    end
    # rubocop:enable Naming/PredicateName
  end
end
