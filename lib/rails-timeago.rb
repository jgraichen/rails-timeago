# frozen_string_literal: true

require 'rails-timeago/version'
require 'rails-timeago/helper'

module Rails
  module Timeago
    if defined?(::Rails::Engine)
      class Engine < ::Rails::Engine # :nodoc:
        initializer 'rails-timeago', group: :all do |_app|
          ActiveSupport.on_load(:action_controller) do
            include Rails::Timeago::Helper
          end

          ActiveSupport.on_load(:action_view) do
            include Rails::Timeago::Helper
          end
        end
      end
    end

    # Read or write global rails-timeago default options. If no options are
    # given the current defaults will be returned.
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
    #   Set a limit for time ago tags. All dates before given limit will not
    #   be converted. Global limit should be given as a block to reevaluate
    #   limit each time timeago_tag is called.
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
      @defaults ||= option_hash
      if opts
        @defaults.merge! \
          opts.extract!(*@defaults.keys.select {|k| opts.include?(k) })
      else
        @defaults
      end
    end

    # Reset options to default values
    def self.reset_default_options
      @defaults = option_hash
    end

    def self.option_hash
      {
        nojs: false,
        force: false,
        format: :default,
        limit: proc { 4.days.ago },
        date_only: true,
        default: '-',
        title: proc {|time, options| I18n.l time, format: options[:format] }
      }
    end
  end
end
