# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name, null: false
  end

  create_table :groups do |t|
    t.string :name, null: false

    t.timestamps
  end

  create_table :user_groups do |t|
    t.references :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    t.references :group, null: false, type: :uuid, foreign_key: { on_delete: :cascade }

    t.timestamps
  end

  add_index :user_groups, %i[user_id group_id], unique: true

  create_table :access_permissions do |t|
    t.string :controller_path, null: false
    t.string :actions, null: false
    t.references :group, null: false
  end

  add_index :access_permissions, %i[controller_path group_id], unique: true
end
