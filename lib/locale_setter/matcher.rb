module LocaleSetter
  module Matcher
    def self.match(requested, against)
      table = generate_lookup_table(against)
      matched = (sanitize(requested) & table.keys).first
      if matched
        table[matched].to_sym
      end
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

    def self.generate_lookup_table(locales)
      table = {}
      locales.each { |l| table[sanitize_one(l)] = l}
      table
    end
  end
end