# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rails-timeago.gemspec
gemspec

group :development do
  gem 'rake'
  gem 'rake-release'
end

group :test do
  gem 'capybara', '~> 3.35'
  gem 'rspec', '~> 3.5'
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: 'v7', require: false
  gem 'selenium-webdriver', '~> 4.0'
  gem 'webrick'
end
