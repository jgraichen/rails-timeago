require "rails-timeago/version"
require "rails-timeago/helper"

module Rails
  module Timeago
    if defined?(::Rails::Engine)
      class Engine < ::Rails::Engine # :nodoc:
        initializer 'rails-timeago' do |app|
          ActiveSupport.on_load(:action_controller) do
            include Rails::Timeago::Helper
          end

          ActiveSupport.on_load(:action_view) do
            include Rails::Timeago::Helper
          end

          if app.config.assets.locales
            app.config.assets.precompile +=
              app.config.assets.locales.map do |locale|
                if ::Rails::Timeago.has_locale_file locale
                  'locales/jquery.timeago.' + locale.to_s + '.js'
                end
              end
          elsif ::Rails::Timeago.locales.nil?
            app.config.assets.precompile +=
              Dir[Rails::Timeago.locale_path + '*.js'].map do |f|
                'locales/' + File.basename(f)
              end
          else
            app.config.assets.precompile +=
              ::Rails::Timeago.locales.map do |locale|
                if ::Rails::Timeago.has_locale_file locale
                  'locales/jquery.timeago.' + locale.to_s + '.js'
                end
              end
          end
        end
      end
    end

    def self.locale_path
      File.dirname(__FILE__) + '/../vendor/assets/javascripts/locales/'
    end

    def self.locale_file(locale)
      locale_path + locale_file_name(locale)
    end

    def self.locale_file_name(locale)
      # TODO: It should actually first check if the full locale name (e.g: nl-NL) exists, if it doesn't, then it should check shortname (e.g nl)
      locale = locale.to_s.downcase
      locale =~ /(\w+)\-(\w+)/
      locale = $1 unless $1.blank?
      'jquery.timeago.' + locale + '.js'
    end

    def self.has_locale_file(locale)
      File.exist? locale_file(locale)
    end

    def self.locales
      @locales
    end

    def self.locales=(*attrs)
      if attrs[0].kind_of?(Array)
        @locales = attrs[0].map(&:to_sym)
      else
        @locales = attrs.map(&:to_sym)
      end
    end
  end
end
