# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rails-timeago.gemspec
gemspec

group :development do
  gem 'rake'
  gem 'rake-release'
end

group :test do
  gem 'capybara'
  gem 'rackup'
  gem 'rspec', '~> 3.12'
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: 'b3f233dd0dd06518154dd8c0e5912ed6b03b2338', require: false
  gem 'selenium-webdriver'
  gem 'webrick'
end
