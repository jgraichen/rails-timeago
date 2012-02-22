module Rails
  module Timeago
    module VERSION
      MAJOR = 1
      MINOR = 0
      PATCH = 0

      def self.to_s
        [MAJOR, MINOR, PATCH].join '.'
      end
    end
  end
end
