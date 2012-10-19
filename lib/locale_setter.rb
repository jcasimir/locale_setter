require "locale_setter/version"

module LocaleSetter
  def self.included(controller)
    if controller.respond_to?(:before_filter)
      controller.before_filter :set_locale
    end
  end

  def default_url_options(options)
    {:locale => ""}.merge(options)
  end
end
