class I18n
  def self.locale
    @@locale ||= ""
  end

  def self.locale=(input)
    @@locale = input
  end

  def self.available_locales
    @@available_locales ||= []
  end

  def self.available_locales=(input)
    @@available_locales = input
  end

  def self.default_locale
    @@default_locale ||= :default
  end

  def self.default_locale=(input)
    @@default_locale = input
  end
end