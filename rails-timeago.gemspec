# frozen_string_literal: true

require_relative 'lib/rails-timeago/version'

Gem::Specification.new do |spec|
  spec.name    = 'rails-timeago'
  spec.version = Rails::Timeago::VERSION
  spec.authors = ['Jan Graichen']
  spec.email   = ['jgraichen@altimos.de']

  spec.summary     = 'jQuery Timeago helper for Rails 3'
  spec.description = 'A Rails Helper to create time tags usable for jQuery Timeago plugin'
  spec.homepage    = 'https://github.com/jgraichen/rails-timeago'
  spec.license     = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jgraichen/rails-timeago'
  spec.metadata['changelog_uri']   = 'https://github.com/jgraichen/rails-timeago/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select do |f|
      f.match %r{\A
        ((?:lib|vendor)/)|
        ((?:CHANGELOG.md|README.md|LICENSE|.*\.gemspec)\z)
      }x
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', '>= 3.1'
  spec.add_dependency 'activesupport', '>= 3.1'
end
