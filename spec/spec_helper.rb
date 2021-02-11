# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

require 'capybara'
require 'capybara/rspec'

require 'rails-timeago'
require_relative 'support/stub'

Capybara.app = Application.instance
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :webrick

RSpec.configure do |config|
  config.mock_with :rspec

  config.before do
    Time.zone = 'UTC'
    I18n.locale = :en
    Rails::Timeago.reset_default_options
  end
end

# Use UTC timezone for the duration of the tests
Time.zone = 'UTC'
