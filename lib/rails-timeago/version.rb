module Rails
  module Timeago
    module VERSION
      MAJOR = 2
      MINOR = 7
      PATCH = 0
      STAGE = nil

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
