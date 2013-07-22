require 'simplecov'
SimpleCov.start()

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara
require 'capybara/rails'
Capybara.default_driver = :rack_test
Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)

  def assert_string(exp, act, failure_message=nil)
    msg = message(msg) {
      diff(exp, act) unless exp == act
    }
    assert(exp == act, msg)
  end
end
