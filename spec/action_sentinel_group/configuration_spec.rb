# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActionSentinelGroup::Configuration do
  let(:configuration) { described_class.new }

  describe "#initialize" do
    it "sets default values for user_model_name, group_model_name, and user_group_model_name" do
      expect(configuration.user_model_name).to eq("User")
      expect(configuration.group_model_name).to eq("Group")
      expect(configuration.user_group_model_name).to eq("UserGroup")
    end
  end

  describe "#user_model_name=" do
    it "sets and camelizes the user_model_name" do
      configuration.user_model_name = "custom_users"
      expect(configuration.user_model_name).to eq("CustomUser")
    end
  end

  describe "#group_model_name=" do
    it "sets and camelizes the group_model_name" do
      configuration.group_model_name = "custom_groups"
      expect(configuration.group_model_name).to eq("CustomGroup")
    end
  end

  describe "#user_group_model_name=" do
    it "sets and camelizes the user_group_model_name" do
      configuration.user_group_model_name = "custom_user_groups"
      expect(configuration.user_group_model_name).to eq("CustomUserGroup")
    end
  end
end
