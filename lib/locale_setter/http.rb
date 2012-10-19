module LocaleSetter
  module HTTP
    def self.for(accept_language)
      LocaleSetter::Matcher.match(AcceptLanguageParser.parse(accept_language))
    end

    module AcceptLanguageParser
      def self.parse(accept_language)
        weighted_fragments = accept_language.split(";").map{|f| f.split(",")}
        sorted_fragments = weighted_fragments.sort_by{|f| -f.last.to_f }
        sorted_fragments.map{|locale, weight| locale}
      end
    end
  end
end