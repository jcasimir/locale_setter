module LocaleSetter
  module Rails
    def self.included(controller)
      controller.before_filter :set_locale
    end

    def default_url_options(options = {})
      if i18n.locale == i18n.default_locale
        options
      else
        {URL_PARAM => i18n.locale}.merge(options)
      end
    end

    def set_locale
      Generic.set_locale(
        i18n,
        {:params => params,
         :user   => locale_user,
         :env    => request.env}
      )
    end

    def locale_user
      if respond_to?(:current_user) && current_user
        current_user
      end
    end

    def i18n
      I18n
    end
  end
end