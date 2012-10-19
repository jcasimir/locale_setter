module LocaleSetter
  module HTTP
    def self.for(accept_language)
      requested = AcceptLanguageParser.parse(accept_language)
      available = I18n.available_locales
      (requested & available).first
    end

    module AcceptLanguageParser
      def self.parse(accept_language)
        weighted_fragments = accept_language.split(";").map{|f| f.split(",")}
        sorted_fragments = weighted_fragments.sort_by{|f| -f.last.to_f }
        sorted_fragments.map{|locale, weight| locale.to_sym}
      end
    end
  end
end