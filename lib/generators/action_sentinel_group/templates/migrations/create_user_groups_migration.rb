class Create<%= user_group_table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= user_group_table_name %><%= primary_key_type %> do |t|
      t.references :<%= user_model_name.underscore %>, null: false<%= foreign_key_type %>, foreign_key: { on_delete: :cascade }
      t.references :<%= group_model_name.underscore %>, null: false<%= foreign_key_type %>, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :<%= user_group_table_name %>, %i[<%= user_model_name.underscore %>_id <%= group_model_name.underscore %>_id], unique: true
  end
end
