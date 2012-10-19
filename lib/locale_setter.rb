require "locale_setter/version"
require "locale_setter/matcher"
require "locale_setter/rails"
require "locale_setter/http"
require "locale_setter/user"
require "locale_setter/param"

module LocaleSetter
  include LocaleSetter::Rails

  def self.included(controller)
    if controller.respond_to?(:before_filter)
      controller.before_filter :set_locale
    end
  end

  def set_locale
    i18n.locale = from_params ||
                  from_user   ||
                  from_http   ||
                  i18n.default_locale
  end

  def from_user
    if respond_to?(:current_user) && current_user
      LocaleSetter::User.for(current_user)
    end
  end

  def from_http
    if respond_to?(:request) && request.env && request.env['HTTP_ACCEPT_LANGUAGE']
      LocaleSetter::HTTP.for(request.env['HTTP_ACCEPT_LANGUAGE'])
    end
  end

  def from_params
    if respond_to?(:params) && params[:locale]
      LocaleSetter::Param.for(params[:locale])
    end
  end
end
