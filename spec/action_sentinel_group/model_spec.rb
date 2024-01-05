# frozen_string_literal: true

require "spec_helper"
require "support/active_record"

RSpec.describe ActionSentinelGroup::Model do
  describe "#has_group_permissions" do
    it "includes ActionSentinelGroup::Permissions in the calling model class" do
      expect(User.included_modules).to include(ActionSentinelGroup::Permissions)
    end
  end
end
