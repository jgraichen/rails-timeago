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
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: '7f9bcc2892c7fe446d7dc4ac8ed014abf273b1fb', require: false
  gem 'selenium-webdriver'
  gem 'webrick'
end
