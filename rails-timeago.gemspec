# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require File.expand_path('../lib/rails-timeago/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Jan Graichen']
  gem.email         = ['jan.graichen@altimos.de']
  gem.description   = 'jQuery Timeago helper for Rails 3'
  gem.summary       = 'A Rails Helper to create time tags usable for jQuery Timeago plugin'
  gem.homepage      = 'https://github.com/jgraichen/rails-timeago'
  gem.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gem.files        = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(features|scripts|spec|test)/}) }
  end
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.name          = 'rails-timeago'
  gem.require_paths = ['lib']
  gem.version       = Rails::Timeago::VERSION

  gem.add_dependency 'activesupport', '>= 3.1'
  gem.add_dependency 'actionpack', '>= 3.1'
end
