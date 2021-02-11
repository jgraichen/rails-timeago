#!/usr/bin/env rake
# frozen_string_literal: true

require 'fileutils'
require 'pathname'
require 'shellwords'

require 'rake/release'
require 'rspec/core/rake_task'

CLONE_URL = 'https://github.com/rmm5t/jquery-timeago.git'
PATCH_FILE = File.join(__dir__, 'scripts/jquery.timeago.js.patch')

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Update jquery-timeago from upstream'
task :update do
  def run(*args)
    puts "+ #{args.shelljoin}"
    puts system(*args.map(&:to_s))
  end

  root = Pathname.new(__dir__)
  source = root.join('tmp')
  source.rmtree if source.exist?
  source.mkpath

  puts 'Clone repository...'
  run 'git', 'clone', CLONE_URL, source

  Dir.chdir(source) do
    puts 'Patch jquery-timeago...'
    run "patch -p1 < #{PATCH_FILE}"
  end

  puts 'Patch locale files...'
  source.join('locales/jquery.timeago.en.js').unlink

  source.glob('locales/*.js').sort.each do |file|
    match = /jquery\.timeago\.(.+)\.js$/.match(file.to_s)
    next unless match

    content = file.read
    content = content.gsub('timeago.settings.strings', "timeago.settings.strings[\"#{match[1]}\"]")
    file.write(content)

    print "#{match[1]} "
  end

  puts
  puts 'Copying asset files...'

  # Copy main JS file
  js = root.join('vendor/assets/javascripts')
  FileUtils.cp(source.join('jquery.timeago.js'), js)

  # Cleanup locales
  locales = js.join('locales')
  locales.rmtree
  locales.mkdir
  source.glob('locales/*.js').sort.each do |file|
    FileUtils.cp(file, locales)
  end

  puts 'Generate rails-timeago-all.js...'

  root.join('lib/assets/javascripts/rails-timeago-all.js').open('w') do |fd|
    fd.puts '// Rails timeago bootstrap with all locales'
    fd.puts '//= require rails-timeago'

    locales.glob('*.js').sort.each do |locale_file|
      fd.puts "//= require locales/#{locale_file.basename}"
    end
  end

  puts 'Clean up...'
  source.rmtree
end
