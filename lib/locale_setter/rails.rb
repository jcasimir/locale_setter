module LocaleSetter
  module Rails
    attr_accessor :i18n

    def default_url_options(options = {})
      if i18n.locale == i18n.default_locale
        options
      else
        {:locale => i18n.locale}.merge(options)
      end
    end

    def i18n
      @i18n ||= I18n
    end
  end
end