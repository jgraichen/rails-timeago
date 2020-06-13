# frozen_string_literal: true

module Rails
  module Timeago
    module VERSION
      MAJOR = 2
      MINOR = 19
      PATCH = 0
      STAGE = nil
      STRING = [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join('.').freeze

      def self.to_s
        STRING
      end
    end
  end
end
