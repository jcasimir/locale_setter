module LocaleSetter
  module Matcher
    def self.match(requested, against)
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
  end
end