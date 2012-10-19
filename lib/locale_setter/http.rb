module LocaleSetter
  module HTTP
    def self.for(accept_language)
      LocaleSetter::Matcher.match(AcceptLanguageParser.parse(accept_language))
    end

    module AcceptLanguageParser
      LOCALE_SEPARATOR = ','
      WEIGHT_SEPARATOR = ';'

      def self.parse(accept_language)
        locale_fragments = accept_language.split(LOCALE_SEPARATOR)
        weighted_fragments = locale_fragments.map{|f| f.split(WEIGHT_SEPARATOR)}
        sorted_fragments = weighted_fragments.sort_by{|f| -f.last.to_f }
        sorted_fragments.map{|locale, weight| locale}
      end
    end
  end
end