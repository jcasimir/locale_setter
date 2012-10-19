module LocaleSetter
  module Matcher
    def self.match(requested)
      (requested & I18n.available_locales).first
    end
  end
end