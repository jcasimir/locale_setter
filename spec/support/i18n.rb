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
end