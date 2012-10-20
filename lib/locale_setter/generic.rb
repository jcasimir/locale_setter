module LocaleSetter
  module Generic

    def self.set_locale(i18n, options = {:params      => nil,
                                         :user        => nil,
                                         :request_env => nil})

      i18n.locale = from_params(options[:params], available(i18n))    ||
                    from_user(options[:user], available(i18n))        ||
                    from_http(options[:request_env], available(i18n)) ||
                    i18n.default_locale
    end

    def self.available(i18n)
      i18n.available_locales.map(&:to_s)
    end

    def self.from_user(user, available)
      LocaleSetter::User.for(user, available) if user
    end

    def self.from_http(request_env, available)
      if request_env && request_env[HTTP_HEADER]
        LocaleSetter::HTTP.for(request_env[HTTP_HEADER], available)
      end
    end

    def self.from_params(params, available)
      if params && params[URL_PARAM]
        LocaleSetter::Param.for(params[URL_PARAM], available)
      end
    end
  end
end