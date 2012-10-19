module LocaleSetter
  module User
    def self.for(user)
      if user && user.locale && !user.locale.empty?
        LocaleSetter::Matcher.match(user.locale)
      end
    end
  end
end