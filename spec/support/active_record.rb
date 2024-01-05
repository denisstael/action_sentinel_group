# frozen_string_literal: true

require "active_record"
require "action_sentinel_group"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.extend ActionSentinel

load "#{File.dirname(__FILE__)}/schema.rb"

class User < ActiveRecord::Base
  has_group_permissions

  has_many :user_groups
  has_many :groups, through: :user_groups
end

class Group < ActiveRecord::Base
  action_permissible

  has_many :user_groups
  has_many :users, through: :user_groups
end

class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end

class AccessPermission < ActiveRecord::Base
  belongs_to :group

  validates :controller_path, uniqueness: { scope: :group_id }

  # The lines below are to sqlite database only
  serialize :actions

  after_initialize do |access_permission|
    access_permission.actions = [] if access_permission.actions.nil?
  end
end
