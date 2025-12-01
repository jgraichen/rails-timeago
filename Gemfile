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
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: '4ba5d2899894ff6a0d01d09b78a816767212067c', require: false
  gem 'selenium-webdriver'
  gem 'webrick'
end
