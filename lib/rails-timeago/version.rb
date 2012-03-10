module Rails
  module Timeago
    module VERSION
      MAJOR = 1
      MINOR = 1
      PATCH = 1

      def self.to_s
        [MAJOR, MINOR, PATCH].join '.'
      end
    end
  end
end
