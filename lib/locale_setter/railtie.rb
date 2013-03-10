require 'rails/railtie'

module LocaleSetter
  class Railtie < Rails::Railtie
    config.after_initialize do |app|
      # I would prefer to do this in an initializer block, but it's important
      # that we do this _before_ any of the user's authentication stuff
      # happens. So this is the best we can get for now.
      ApplicationController.send(:include, LocaleSetter::Controller)
    end
  end
  module Rails
    def self.included(controller)
      ActiveSupport::Deprecation.warn("You don't need to include LocaleSetter::Rails any more. There's a Railtie for That (tm).")
    end
  end
end
