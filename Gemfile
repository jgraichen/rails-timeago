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
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: '9f3e5cd0e519811a7f615f265fca81a4f4e843b9', require: false
  gem 'selenium-webdriver'
  gem 'webrick'
end
