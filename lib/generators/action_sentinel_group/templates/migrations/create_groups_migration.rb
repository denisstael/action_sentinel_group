class Create<%= groups_table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= group_model_name.underscore.pluralize %><%= primary_key_type %> do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
