module LocaleSetter
  module Matcher
    def self.match(requested)
      matched = (requested & available).first
      matched.to_sym if matched
    end

    def self.available
      I18n.available_locales.map(&:to_s)
    end
  end
end