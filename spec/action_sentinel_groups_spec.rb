# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActionSentinelGroup do
  describe ".configure" do
    it "yields the configuration object for customization" do
      ActionSentinelGroup.configure do |config|
        expect(config).to be_a(ActionSentinelGroup::Configuration)
      end
    end

    it "allows setting and retrieving configuration options" do
      ActionSentinelGroup.configure do |config|
        config.user_model_name = "Member"
        config.group_model_name = "Gang"
        config.user_group_model_name = "MemberGang"
      end

      expect(ActionSentinelGroup.configuration.user_model_name).to eq("Member")
      expect(ActionSentinelGroup.configuration.group_model_name).to eq("Gang")
      expect(ActionSentinelGroup.configuration.user_group_model_name).to eq("MemberGang")
    end
  end

  describe "ActionSentinel inclusion" do
    it "includes ActionSentinelGroup::Model in ActionSentinel" do
      expect(ActionSentinel.included_modules).to include(ActionSentinelGroup::Model)
    end
  end
end
