module Rails
  module Timeago
    module Helper
      # Create a time tag usable for jQuery timeago plugin.
      #
      #   timeago_tag Time.zone.now
      #   => ""
      #
      # Available options:
      # [:+nojs+]
      #   Add time ago in words as time tag content instead of absolute time.
      #
      # [:+date_only+]
      #   Only print date as tag content instead of full time.
      #
      # [:+format+]
      #   A time format for localize method used to format static time.
      # 
      # [:+limit+]
      #   Set a limit for time ago tags. All dates before given limit will not be converted. 
      #   (default: 4.days.ago) 
      #
      # [:+force+]
      #   Force time ago tag ignoring limit option.
      #
      # All other options will be given as options to tag helper.
      #
      def timeago_tag(time, html_options = {})
        time_options = {
          :nojs      => false, 
          :force     => false, 
          :format    => :default, 
          :limit     => 4.days.ago,
          :date_only => true
        }

        time_options.merge! html_options.extract!(*time_options.keys.select{|k| html_options.include?(k)})
        html_options.merge! :title => I18n.l(time, :format => time_options[:format])

        if time_options[:force] or time_options[:limit].nil? or time_options[:limit] < time
          html_options.reverse_merge!('data-time-ago' => time.iso8601)

          time_tag time, timeago_tag_content(time, time_options), html_options
        else
          time_tag time, timeago_tag_content(time, time_options), html_options
        end
      end

      def timeago_tag_content(time, time_options = {}) # :nodoc:
        time = time.to_date            if time_options[:date_only]
        return time_ago_in_words(time) if time_options[:nojs]

        I18n.l time, :format => time_options[:format]
      end
    end
  end
end