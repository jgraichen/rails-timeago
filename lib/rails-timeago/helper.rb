module Rails
  module Timeago
    module Helper
      # Create a time tag usable for jQuery timeago plugin.
      #
      #   timeago_tag Time.zone.now
      #   => "<time datetime="2012-03-10T12:07:07+01:00" title="Sat, 10 Mar 2012 12:07:07 +0100" data-time-ago="2012-03-10T12:07:07+01:00">2012-03-10</time>"
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
      #   (default: 4.days.ago)
      #
      # [:+force+]
      #   Force time ago tag ignoring limit option.
      #   (default: false)
      #
      # [:+default+]
      #   String that will be returned if time is nil.
      #   (default: '-')
      #
      # All other options will be given as options to tag helper.
      #
      def timeago_tag(time, html_options = {})
        time_options = Rails::Timeago.default_options

        time_options = time_options.merge html_options.extract!(*time_options.keys.select{|k| html_options.include?(k)})
        return time_options[:default] if time.nil?

        html_options.merge! :title => I18n.l(time, :format => time_options[:format])
        time_options[:limit] = time_options[:limit].call if time_options[:limit].is_a?(Proc)

        if time_options[:force] or time_options[:limit].nil? or time_options[:limit] < time
          html_options.merge!('data-time-ago' => time.iso8601)
        end
        time_tag time, timeago_tag_content(time, time_options), html_options
      end

      def timeago_tag_content(time, time_options = {}) # :nodoc:
        time = time.to_date            if time_options[:date_only]
        return time_ago_in_words(time) if time_options[:nojs]

        I18n.l time, :format => time_options[:format]
      end

      # Return a JavaScript tag to include jQuery timeago
      # locale file for current locale.
      def timeago_script_tag
        if ::Rails::Timeago.has_locale_file(I18n.locale) and I18n.locale != :en
          return javascript_include_tag 'locales/' + ::Rails::Timeago.locale_file_name(I18n.locale)
        end
        ''
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
  end
end
