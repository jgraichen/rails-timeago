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

    # Read or write global rails-timeago default options. If no options are given
    # the current defaults will be returned.
    #
    # Available options:
    # [:+nojs+]
    #   Add time ago in words as time tag content instead of absolute time.
    #   (default: false)
    #
    # [:+date_only+]
    #   Only print date as tag content instead of full time.
    #   (default: true)
    #
    # [:+format+]
    #   A time format for localize method used to format static time.
    #   (default: :default)
    #
    # [:+limit+]
    #   Set a limit for time ago tags. All dates before given limit will not be converted.
    #   Global limit should be given as a block to reevaluate limit each time timeago_tag is called.
    #   (default: proc { 4.days.ago })
    #
    # [:+force+]
    #   Force time ago tag ignoring limit option.
    #   (default: false)
    #
    # [:+default+]
    #   String that will be returned if time is nil.
    #   (default: '-')
    #
    def self.default_options(opts = nil)
      @defaults ||= {
        :nojs      => false,
        :force     => false,
        :format    => :default,
        :limit     => proc { 4.days.ago },
        :date_only => true,
        :default   => '-'
      }
      if opts
        @defaults.merge! opts.extract!(*@defaults.keys.select{|k| opts.include?(k)})
      else
        @defaults
      end
    end

    def self.locale_path
      File.dirname(__FILE__) + '/../vendor/assets/javascripts/locales/'
    end

    def self.locale_file(locale)
      locale_path + locale_file_name(locale)
    end

    def self.locale_file_name(locale)
      'jquery.timeago.' + locale + '.js'
    end

    def self.has_locale_file(locale)
      File.exist? locale_file(locale)
    end

    # Look up a timeago locale. If no locale is given I18n's
    # default locale will be used. Lookup follows the given
    # order:
    #   1) ll-CC     (language and country)
    #   2) ll        (only language)
    #   3) I18n default locale
    #   4) "en"
    def self.lookup_locale(locale = nil)
      locale = I18n.locale.to_s unless locale

      if locale =~ /^(\w+)(\-(\w+))?$/
        lang = $1.downcase
        if $3
          ctry = $3.upcase
          return "#{lang}-#{ctry}" if has_locale "#{lang}-#{ctry}"
        end
        return lang if has_locale lang
      end

      return I18n.default_locale.to_s if has_locale I18n.default_locale.to_s
      "en"
    end

    def self.has_locale(locale)
      return locales.include? locale if locales.any?
      return has_locale_file locale
    end

    def self.locales
      @locales ||= []
    end

    def self.locales=(*attrs)
      if attrs[0].kind_of?(Array)
        @locales = attrs[0].map(&:to_s)
      else
        @locales = attrs.map(&:to_s)
      end
    end
  end
end
