# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

ENV["RAILS_ENV"] = 'test'
require_relative "dummy/config/environment"

require 'rspec/rails'

# prevent Test::Unit's AutoRunner from executing during RSpec's rake task see https://github.com/rspec/rspec-rails/issues/1171
Test::Unit.run = true if defined?(Test::Unit) && Test::Unit.respond_to?(:run=)

require 'assert_difference'
require 'sqlite3'

require 'haml'

# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

Capybara.default_selector  = :css

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.include AssertDifference
  config.use_transactional_fixtures = true
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!

  # Silence deprecation warnings
  config.expect_with(:rspec) { |c| c.syntax = :should }
end


class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

