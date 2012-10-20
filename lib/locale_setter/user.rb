module LocaleSetter
  module User
    def self.for(user)
      if user && user.respond_to?(:locale) && user.locale && !user.locale.empty?
        LocaleSetter::Matcher.match(user.locale)
      end
    end
  end
end