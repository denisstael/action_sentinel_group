# frozen_string_literal: true

require "spec_helper"
require "support/active_record"

RSpec.describe ActionSentinelGroup::Permissions do
  let(:user) { User.create(name: "User") }
  let(:group) { Group.create(name: "Group") }

  before { UserGroup.create(user_id: user.id, group_id: group.id) }

  describe "#has_permission_to?" do
    context "when the user group does not have the specified permission" do
      it "returns false" do
        expect(user.has_permission_to?("create", "users")).to eq(false)
      end
    end

    context "when the user group has the specified permission" do
      it "returns true" do
        group.add_permissions_to("create", "users")
        expect(user.has_permission_to?("create", "users")).to eq(true)
      end
    end
  end
end
