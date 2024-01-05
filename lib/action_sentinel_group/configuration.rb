# frozen_string_literal: true

module ActionSentinelGroup
  class Configuration
    attr_reader :user_model_name, :group_model_name, :user_group_model_name

    def initialize
      @user_model_name = "User"
      @group_model_name = "Group"
      @user_group_model_name = "UserGroup"
    end

    def user_model_name=(user_model_name)
      @user_model_name = user_model_name.camelize.singularize
    end

    def group_model_name=(group_model_name)
      @group_model_name = group_model_name.camelize.singularize
    end

    def user_group_model_name=(user_group_model_name)
      @user_group_model_name = user_group_model_name.camelize.singularize
    end
  end
end
