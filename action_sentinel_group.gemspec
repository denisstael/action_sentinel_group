# frozen_string_literal: true

require_relative "lib/action_sentinel_group/version"

Gem::Specification.new do |spec|
  spec.name = "action_sentinel_group"
  spec.version = ActionSentinelGroup::VERSION
  spec.authors = ["Denis Stael"]
  spec.email = ["denissantistael@gmail.com"]

  spec.summary = "Control of group access permissions to controller actions using ActionSentinel."
  spec.description = <<-EOF
    Group access authorization control, based on controllers actions access permissions using ActionSentinel.
  EOF

  spec.homepage = "https://github.com/denisstael/action_sentinel_group"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/denisstael/action_sentinel_group"
  spec.metadata["changelog_uri"] = "https://github.com/denisstael/action_sentinel_group/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "action_sentinel", "~> 0.3.0"

  spec.add_development_dependency "activerecord", "~> 5.2"
  spec.add_development_dependency "railties", "~> 5.2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "sqlite3", "~> 1.4.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
