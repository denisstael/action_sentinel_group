# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"

module ActionSentinelGroup
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("templates", __dir__)

    argument :user_model_name, type: :string, desc: "Name of the model that is being used as user"
    argument :group_model_name, type: :string, desc: "Name of the model that will represent a group of users"

    class_option :uuid, type: :boolean, default: false, desc: "Use UUID type as primary/foreign key"

    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end

    def generate
      model_file = File.join("app", "models", "#{user_model_name.underscore.singularize}.rb")

      if File.exist?(model_file) || revoke_process?
        create_models
        create_migrations
        inject_group_association_into_user_model(model_file)
        create_initializer
        invoke_action_sentinel_generator
      else
        logger.error("The file #{model_file} does not appear to exist")
      end
    end

    private

    def logger
      Logger.new($stdout)
    end

    def revoke_process?
      behavior == :revoke
    end

    def create_models
      template "models/group_model.rb", "app/models/#{group_model_name.underscore}.rb"
      template "models/user_group_model.rb", "app/models/#{user_group_model_name.underscore}.rb"
    end

    def create_migrations
      migration_template "migrations/create_groups_migration.rb", "db/migrate/create_#{groups_table_name}.rb"
      migration_template "migrations/create_user_groups_migration.rb", "db/migrate/create_#{user_group_table_name}.rb"
    end

    def inject_group_association_into_user_model(model_file)
      if File.exist?(model_file)
        inject_into_class(model_file, user_model_name) do
          "\thas_group_permissions\n" \
          "\thas_many :#{user_group_table_name}\n" \
          "\thas_many :#{group_model_name.pluralize.underscore}, through: :#{user_group_table_name}\n"
        end
      else
        logger.info("The file #{model_file} does not appear to exist")
      end
    end

    def create_initializer
      template "initializer/action_sentinel_group.rb", "config/initializers/action_sentinel_group.rb"
    end

    def invoke_action_sentinel_generator
      invoke "action_sentinel:access_permission", [group_model_name, options]
    end

    def user_group_model_name
      "#{user_model_name}#{group_model_name}"
    end

    def user_group_table_name
      "#{user_model_name.underscore}_#{group_model_name.underscore.pluralize}"
    end

    def groups_table_name
      group_model_name.underscore.pluralize.to_s
    end

    def migration_version
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end

    def primary_key_type
      options.uuid? ? ", id: :uuid" : ""
    end

    def foreign_key_type
      options.uuid? ? ", type: :uuid" : ""
    end
  end
end
