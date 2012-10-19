module LocaleSetter
  module Matcher
    def self.match(requested, against = available)
      matched = (sanitize(requested) & against).first
      matched.to_sym if matched
    end

    def self.sanitize(input)
      if input.respond_to? :map
        input.map{|l| sanitize_one(l)}
      else
        [sanitize_one(input)]
      end
    end

    def self.sanitize_one(locale)
      locale.to_s.downcase.strip
    end

    def self.available
      I18n.available_locales.map(&:to_s)
    end
  end
end