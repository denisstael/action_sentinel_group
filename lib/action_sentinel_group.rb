# frozen_string_literal: true

require "action_sentinel_group/version"
require "action_sentinel_group/configuration"
require "action_sentinel_group/model"

module ActionSentinelGroup
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  configure {}
end

ActionSentinel.include ActionSentinelGroup::Model
