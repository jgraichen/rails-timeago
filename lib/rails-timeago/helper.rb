# frozen_string_literal: true

require 'active_support/time'

module Rails
  module Timeago
    module Helper
      # Create a time tag usable for jQuery timeago plugin.
      #
      #   timeago_tag Time.zone.now
      #   => "<time datetime="2012-03-10T12:07:07+01:00"
      #             title="Sat, 10 Mar 2012 12:07:07 +0100"
      #             data-time-ago="2012-03-10T12:07:07+01:00">2012-03-10</time>"
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
      #   Set a limit for time ago tags. All dates before given limit
      #   will not be converted.
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

        time_options = time_options.merge html_options.extract!(*time_options.keys.select {|k| html_options.include?(k) })
        return time_options[:default] if time.nil?

        time_options[:format] = time_options[:format].call(time, time_options) if time_options[:format].is_a?(Proc)
        if time_options[:title]
          html_options[:title] = time_options[:title].is_a?(Proc) ? time_options[:title].call(time, time_options) : time_options[:title]
        end
        time_options[:limit] = time_options[:limit].call if time_options[:limit].is_a?(Proc)

        time_range = unless time_options[:limit].nil?
                       now = Time.zone.now
                       limit = time_options[:limit]
                       limit < now ? limit...now : now...limit
                     end

        if time_options[:force] || time_range.nil? || time_range.cover?(time)
          html_options['data-time-ago'] = time.iso8601
        end
        time_tag time, timeago_tag_content(time, time_options), html_options
      end

      def timeago_tag_content(time, time_options = {}) # :nodoc:
        time = time.to_date            if time_options[:date_only]
        return time_ago_in_words(time) if time_options[:nojs] && (time_options[:limit].nil? || time_options[:limit] < time)

        I18n.l time, format: time_options[:format]
      end

      # Return a JavaScript tag to set jQuery timeago locale.
      def timeago_script_tag
        javascript_tag "jQuery.timeago.settings.lang=\"#{I18n.locale}\";" if I18n.locale != 'en'
      end
    end
  end
end
