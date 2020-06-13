#!/usr/bin/env rake
# frozen_string_literal: true

require 'rake/release'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Update jquery-timeago from upstream'
task :update do
  puts 'Clone repository..'
  puts `mkdir ./tmp`
  puts `git clone https://github.com/rmm5t/jquery-timeago.git ./tmp`

  puts 'Patch jquery timeago...'
  puts `cd ./tmp && patch -p1 < ../scripts/jquery.timeago.js.patch`

  print 'Patch locale files ... '
  `rm ./tmp/locales/jquery.timeago.en.js`

  is_mac = RUBY_PLATFORM.downcase.include?('darwin')

  Dir['./tmp/locales/*.js'].each do |file|
    if file =~ /jquery\.timeago\.(.+)\.js$/
      `sed -i#{is_mac ? " ''" : nil} "s/timeago.settings.strings/timeago.settings.strings[\\"#{Regexp.last_match(1)}\\"]/" #{file}`
      print "#{Regexp.last_match(1)} "
    end
  end
  puts

  puts 'Copying asset files...'
  puts `cp ./tmp/jquery.timeago.js ./vendor/assets/javascripts/`
  puts `rm ./vendor/assets/javascripts/locales/*`
  puts `cp ./tmp/locales/*.js ./vendor/assets/javascripts/locales`

  puts 'Generate rails-timeago-all.js...'
  `echo "// Rails timeago bootstrap with all locales" > ./lib/assets/javascripts/rails-timeago-all.js`
  `echo "//= require rails-timeago" >> ./lib/assets/javascripts/rails-timeago-all.js`
  Dir['./vendor/assets/javascripts/locales/*.js'].sort.each do |file|
    `echo "//= require locales/#{File.basename(file)}" >> ./lib/assets/javascripts/rails-timeago-all.js`
  end

  puts 'Clean up...'
  puts `rm -rf ./tmp`
end
