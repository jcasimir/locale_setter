require "locale_setter/version"
require "locale_setter/rails"
require "locale_setter/http"
require "locale_setter/user"

module LocaleSetter
  include LocaleSetter::Rails

  def self.included(controller)
    if controller.respond_to?(:before_filter)
      controller.before_filter :set_locale
    end
  end

  def set_locale
    i18n.locale = from_user ||
                  from_http
  end

  def from_user
    if respond_to?(:current_user) && current_user
      LocaleSetter::User.for(current_user)
    end
  end

  def from_http
    if respond_to?(:request) && request.env
      LocaleSetter::HTTP.for(request.env['HTTP_ACCEPT_LANGUAGE'])
    end
  end
end
