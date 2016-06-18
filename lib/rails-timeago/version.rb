module Rails
  module Timeago
    module VERSION
      MAJOR = 2
      MINOR = 13
      PATCH = 1
      STAGE = nil
      STRING = [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join('.').freeze

      def self.to_s
        STRING
      end
    end
  end
end
