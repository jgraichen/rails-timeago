# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'

require File.dirname(__FILE__) + '/../lib/rails-timeago.rb'
require File.dirname(__FILE__) + '/support/stub.rb'

Capybara.app = Application.instance
Capybara.javascript_driver = :poltergeist
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
