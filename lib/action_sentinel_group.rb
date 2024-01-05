# frozen_string_literal: true

require "action_sentinel"
require "action_sentinel_group/version"
require "action_sentinel_group/configuration"
require "action_sentinel_group/model"

# The ActionSentinelGroup module is an extension of ActionSentinel gem
# that provides a way to group users and provide group access permissions
module ActionSentinelGroup
  class << self
    # Accessor for the configuration instance
    attr_accessor :configuration

    # Configures the ActionSentinelGroup settings
    #
    # @example:
    #
    #   ActionSentinelGroup.configure do |config|
    #     config.user_model_name = "User"
    #   end
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  configure {}
end

# Include ActionSentinelGroup::Model in ActionSentinel
ActionSentinel.include ActionSentinelGroup::Model
