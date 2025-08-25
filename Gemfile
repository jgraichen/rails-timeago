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
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: '755a4808a85f5b85cdbe68150de89200fabc7369', require: false
  gem 'selenium-webdriver'
  gem 'webrick'
end
