class Configuration
  attr_accessor :url_param, :user_locale_method, :localized_domains,
    :http_header, :current_user_method

  def initialize(options)
    options.each_pair { |k, v| send(:"#{k}=", v) }
  end
end
