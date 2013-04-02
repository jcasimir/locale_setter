require "locale_setter/version"
require "locale_setter/matcher"
require "locale_setter/controller"
require "locale_setter/railtie" if defined?(Rails)
require "locale_setter/http"
require "locale_setter/user"
require "locale_setter/domain"
require "locale_setter/param"
require "locale_setter/generic"

module LocaleSetter
  HTTP_HEADER = 'HTTP_ACCEPT_LANGUAGE'
  URL_PARAM   = :locale
  USER_METHOD = :locale
end
