module LocaleSetter
  module Rails
    attr_accessor :i18n

    def default_url_options(options)
      {:locale => ""}.merge(options)
    end

    def i18n
      @i18n ||= I18n
    end
  end
end