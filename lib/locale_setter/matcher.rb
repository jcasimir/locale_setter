module LocaleSetter
  module Matcher
    def self.match(requested, against = available)
      matched = (sanitize(requested) & against).first
      matched.to_sym if matched
    end

    def self.sanitize(locales)
      locales.map{|l| l.downcase.strip}
    end

    def self.available
      I18n.available_locales.map(&:to_s)
    end
  end
end