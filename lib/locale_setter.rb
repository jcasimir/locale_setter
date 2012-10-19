require "locale_setter/version"
require "locale_setter/rails"
require "locale_setter/http"

module LocaleSetter
  include LocaleSetter::Rails

  def self.included(controller)
    if controller.respond_to?(:before_filter)
      controller.before_filter :set_locale
    end
  end

  def set_locale
    i18n.locale = LocaleSetter::HTTP.for(request.env['HTTP_ACCEPT_LANGUAGE'])
  end
end
