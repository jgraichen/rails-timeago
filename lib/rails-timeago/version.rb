module Rails
  module Timeago
    module VERSION
      MAJOR = 1
      MINOR = 1
      PATCH = 2
      STAGE = 'rc1'

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
