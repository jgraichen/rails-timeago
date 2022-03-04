# frozen_string_literal: true

module Rails
  module Timeago
    module VERSION
      MAJOR = 2
      MINOR = 20
      PATCH = 0
      STAGE = nil
      STRING = [MAJOR, MINOR, PATCH, STAGE].compact.join('.').freeze

      def self.to_s
        STRING
      end
    end
  end
end
