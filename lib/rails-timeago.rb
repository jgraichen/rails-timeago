require "rails-timeago/version"
require "rails-timeago/helper"

module Rails
  module Timeago 
    class Engine < ::Rails::Engine # :nodoc:
      initializer 'rails-timeago' do |app|
        ActiveSupport.on_load(:action_controller) do
          include Rails::Timeago::Helper
        end

        ActiveSupport.on_load(:action_view) do
          include Rails::Timeago::Helper
        end
      end
    end
  end
end
