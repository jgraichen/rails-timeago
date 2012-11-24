module Rails
  module Timeago
    module VERSION
      MAJOR = 2
      MINOR = 0
      PATCH = 0
      STAGE = 'beta1'

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
