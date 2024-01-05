# frozen_string_literal: true

module ActionSentinelGroup
  # The Configuration class holds the configuration options for ActionSentinelGroup
  class Configuration
    # The name of the user model (default: "User")
    #
    # @return [String] The name of the user model
    attr_reader :user_model_name

    # The name of the group model (default: "Group")
    #
    # @return [String] The name of the group model
    attr_reader :group_model_name

    # The name of the user group model (default: "UserGroup")
    #
    # @return [String] The name of the user group model
    attr_reader :user_group_model_name

    # Initializes a new Configuration instance with default values.
    def initialize
      @user_model_name = "User"
      @group_model_name = "Group"
      @user_group_model_name = "UserGroup"
    end

    # Sets the name of the user model after camelizing and singularizing it.
    #
    # @param user_model_name [String] The name of the user model
    def user_model_name=(user_model_name)
      @user_model_name = user_model_name.camelize.singularize
    end

    # Sets the name of the group model after camelizing and singularizing it.
    #
    # @param group_model_name [String] The name of the group model
    def group_model_name=(group_model_name)
      @group_model_name = group_model_name.camelize.singularize
    end

    # Sets the name of the user group model after camelizing and singularizing it.
    #
    # @param user_group_model_name [String] The name of the user group model
    def user_group_model_name=(user_group_model_name)
      @user_group_model_name = user_group_model_name.camelize.singularize
    end
  end
end
